import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../features/album/model/album_file_upload_item_model_v2.dart';
import '../global_data.dart';
import '../utils/datetime_util.dart';
import '../utils/debug_utils.dart';
import '../utils/snack_bar_manager.dart';
import 'file_service.dart';

class MediaFileUploadBackgroundService {
  final Map<String, AlbumFileUploadItemModelV2> uploadItemsMap = {};
  final List<Map<String, dynamic>> waitingUploadTaskList = [];
  final List<Function> onAllFilesUploadedCallbacks = [];
  final FileDownloader _fileUploader = FileDownloader();
  int _uploadProgress = 0;

  MediaFileUploadBackgroundService() {
    _fileUploader.updates.listen(_onUploadUpdate);
  }

  void onPickMediaTap(int targetFolderId) async {
    DebugManager.log('pickMediasFromGallery');
    DebugManager.log("before calling pickMultipleMedia");

    const pickLimit = 20;
    var tasks = await _fileUploader.allTasks();
    for (var task in tasks) {
      _fileUploader.cancelTaskWithId(task.taskId);
    }
    DebugManager.log("tasks count: ${tasks.length}");

    final filePaths = await FileService.pickMedias(pickLimit, false, false, false);
    if (filePaths.isEmpty) {
      return SnackBarManager.displayMessage(
        AppLocalizations.of(InnoGlobalData.materialAppKey.currentContext!)!.didNotSelectFiles,
      );
    }
    List<AlbumFileUploadItemModelV2> pickedFileUploadItems = [];
    for (var i = 0; i < filePaths.length; i++) {
      var filePath = filePaths[i];
      if (i >= pickLimit) {
        SnackBarManager.displayMessage(
          AppLocalizations.of(InnoGlobalData.materialAppKey.currentContext!)!.filePickLimitExceeded(pickLimit),
        );
        break;
      }
      DebugManager.log("File $i path = $filePath");
      var uploadItem = AlbumFileUploadItemModelV2(filePath, targetFolderId);
      // DebugManager.log("File $i size = ${pickedMedias[i].size}");
      var file = File(filePath);
      DebugManager.log("File $i date = ${DatetimeUtils.formattedDate(file.lastAccessedSync())}");
      pickedFileUploadItems.add(uploadItem);
    }
    _add(pickedFileUploadItems);
  }

  void _onUploadUpdate(TaskUpdate update) {
    DebugManager.log("_onUploadUpdate ${update.toJson()}");
    var taskId = update.task.taskId;
    if (!uploadItemsMap.containsKey(taskId)) {
      DebugManager.error("Unrecognized taskId: $taskId");
      return;
    }

    switch (update) {
      case TaskStatusUpdate _:
        // process the TaskStatusUpdate, e.g.
        DebugManager.log("TaskStatusUpdate ${update.status}");
        switch (update.status) {
          case TaskStatus.running:
            DebugManager.log('Task ${update.task.taskId} running!');
          case TaskStatus.enqueued:
            DebugManager.log('Task ${update.task.taskId} enqueued!');
          case TaskStatus.complete:
            DebugManager.log('Task ${update.task.taskId} success!');
            uploadItemsMap[taskId]!.updateTaskProgress(taskId, 100);
            // When a task is completed, and the waiting list is not empty, start the next task
            _startNextUploadJobOnWaitingList();
          case TaskStatus.canceled:
            DebugManager.log('Upload was canceled');
            _startNextUploadJobOnWaitingList();
          case TaskStatus.paused:
            DebugManager.log('Upload was paused');

          default:
            DebugManager.log('Upload not successful');
        }

      case TaskProgressUpdate _:
        DebugManager.log("OnUploadUpdate: ${update.progress}, ${update.toJson()} ");
        uploadItemsMap[taskId]!.updateTaskProgress(taskId, (update.progress * 100).floor());
        _uploadProgress = 0;
        var seenUploadJobs = <AlbumFileUploadItemModelV2>[];
        for (var item in uploadItemsMap.values) {
          if (seenUploadJobs.contains(item)) {
            continue;
          }

          seenUploadJobs.add(item);
          if (item.isCancelled) {
            _uploadProgress += 100;
          } else {
            var tProgress = item.getUploadProgress();
            DebugManager.log("tProgress = $tProgress");
            _uploadProgress += tProgress;
          }
        }
        if (seenUploadJobs.isEmpty) {
          _uploadProgress = 0;
        } else {
          _uploadProgress = (_uploadProgress / seenUploadJobs.length).floor();
        }
    }
  }

  void _startNextUploadJobOnWaitingList() {
    // Skip over cancelled tasks
    DebugManager.log("_startNextUploadJobOnWaitingList");
    while (waitingUploadTaskList.isNotEmpty) {
      var nextTask = waitingUploadTaskList.first;
      var task = nextTask['task'] as UploadTask;
      var uploadItem = nextTask['uploadItem'] as AlbumFileUploadItemModelV2;
      if (uploadItem.isCancelled) {
        waitingUploadTaskList.removeAt(0);
      } else {
        break;
      }
    }

    if (waitingUploadTaskList.isNotEmpty) {
      // start the next upload task
      var nextTask = waitingUploadTaskList.removeAt(0);
      var task = nextTask['task'] as UploadTask;
      var uploadItem = nextTask['uploadItem'] as AlbumFileUploadItemModelV2;
      _enqueueTask(task, uploadItem);
    } else {
      // check if all uploads are completed
      var keys = uploadItemsMap.keys;
      var removeKeys = [];
      for (var item in keys) {
        if (uploadItemsMap[item]!.getUploadProgress() == 100 || uploadItemsMap[item]!.isCancelled) {
          removeKeys.add(item);
        }
      }
      if (keys.length == removeKeys.length) {
        _onAllFilesUploaded();
      }
    }
  }

  void _add(List<AlbumFileUploadItemModelV2> newUploadItems) async {
    DebugManager.log("MediaFileUploadBackgroundService._add ${newUploadItems.length}");
    for (var item in newUploadItems) {
      if (item.isVideoFile()) {
        await item.generateThumbnail();
      }
    }

    for (var i = 0; i < newUploadItems.length; i++) {
      DebugManager.log("Current i = $i");
      var uploadItem = newUploadItems[i];
      // Upload item may generate multiple
      var tasks = await uploadItem.generateUploadTasks();
      for (var task in tasks) {
        uploadItemsMap[task.taskId] = uploadItem;
        waitingUploadTaskList.add({'task': task, 'uploadItem': uploadItem});
      }
    }

    // DebugManager.error("TESTING, Do not start ", repeatTime: 5);
    // return;
    // Start first task
    var waitingItem = waitingUploadTaskList.removeAt(0);
    var task = waitingItem['task'] as UploadTask;
    var uploadItem = waitingItem['uploadItem'] as AlbumFileUploadItemModelV2;
    DebugManager.log("Enqueue Task: ${task.taskId}");
    await _enqueueTask(task, uploadItem);
  }

  Future<void> _enqueueTask(UploadTask task, AlbumFileUploadItemModelV2 uploadItem) async {
    try {
      final result = await _fileUploader.enqueue(task);
      if (result) {
        uploadItemsMap[task.taskId] = uploadItem;
      } else {
        DebugManager.error("Unable to enqueue upload item");
      }
    } catch (error) {
      DebugManager.error(error.toString());
    }
  }

  void _onAllFilesUploaded() {
    SnackBarManager.displayMessage(
      AppLocalizations.of(InnoGlobalData.materialAppKey.currentContext!)!.allFilesUploaded,
    );
    for (var item in getUploadItems()) {
      item.dispose();
    }
    uploadItemsMap.clear();
    for (var item in onAllFilesUploadedCallbacks) {
      // DebugManager.error("Testing!!!!!!!!!!!!! commented out the following line");
      item();
    }
  }

  int getCurrentUploadProgress() {
    // DebugManager.log("Upload progress = $_uploadProgress");
    return _uploadProgress;
  }

  void cancelJob(AlbumFileUploadItemModelV2 uploadJob) {
    uploadJob.cancelUpload();
    for (var taskId in uploadJob.taskIdToProgressMap.keys) {
      _fileUploader.cancelTaskWithId(taskId);
    }
    _startNextUploadJobOnWaitingList();
  }

  List<AlbumFileUploadItemModelV2> getUploadItems() {
    var uploadItems = <AlbumFileUploadItemModelV2>[];
    for (var item in uploadItemsMap.values) {
      if (!uploadItems.contains(item)) {
        uploadItems.add(item);
      }
    }
    return uploadItems;
  }
}
