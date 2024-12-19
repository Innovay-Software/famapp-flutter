import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:famapp/api_agent.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../core/config.dart';
import '../../../core/utils/debug_utils.dart';
import '../../settings/viewmodel/user_viewmodel.dart';

class AlbumFileUploadItemModelV2 {
  final int targetAlbumId;
  final int chunkSize = InnoConfig.chunkUploadSizeInMb * 1000 * 1000;
  final String originalPath;
  final File _file;
  final Map<String, int> taskIdToProgressMap = {};
  final List<String> _generatedTempFiles = [];
  String localThumbnailPath = '';
  bool isCancelled = false;
  int fileSize = 0;

  AlbumFileUploadItemModelV2(this.originalPath, this.targetAlbumId) : _file = File(originalPath) {
    // generateThumbnail();
  }

  void dispose() {
    for (var tempFilePath in _generatedTempFiles) {
      var file = File(tempFilePath);
      file.delete();
    }
  }

  int getUploadProgress() {
    var total = 0;
    for (var item in taskIdToProgressMap.values) {
      total += item;
    }
    return (total / taskIdToProgressMap.length).floor();
  }

  int getCompletedTaskIds() {
    var total = 0;
    taskIdToProgressMap.forEach((key, value) {
      if (value >= 100) {
        total += 1;
      }
    });
    return total;
  }

  int getTotalTaskIds() {
    return taskIdToProgressMap.length;
  }

  void updateTaskProgress(String taskId, int progress) {
    DebugManager.log("UpdateTaskProgress, taskID=$taskId, progress=$progress");
    taskIdToProgressMap[taskId] = progress;
  }

  String getFileName() {
    if (originalPath.isNotEmpty) {
      return originalPath.split('/').last;
    }
    return '-';
  }

  bool isVideoFile() {
    var fileName = getFileName();
    var extension = fileName.split('.').last;
    return !['jpeg', 'jpg', 'png', 'gif', 'avif', 'svg', 'webp'].contains(extension);
  }

  void cancelUpload() {
    isCancelled = true;
  }

  Future<void> generateThumbnail() async {
    if (!isVideoFile()) {
      return;
    }

    // isVideo
    final uint8list = await VideoThumbnail.thumbnailData(
      video: originalPath,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 75,
    );

    if (uint8list == null) {
      DebugManager.error('Unable to generate thumbnail data from $originalPath');
      return;
    }
    localThumbnailPath = (await getTemporaryDirectory()).path;
    localThumbnailPath = '$localThumbnailPath${getFileName()}.thumbnail.jpg';
    await File(localThumbnailPath).writeAsBytes(uint8list);
  }

  Future<List<UploadTask>> generateUploadTasks() async {
    final user = UserViewmodel().currentUser;
    var applicationDocumentDirectory = await getApplicationDocumentsDirectory();
    // var applicationCacheDirectory = await getApplicationCacheDirectory();
    var fileExtension = originalPath.split('.').last;
    var filename = 'U${user.id}.${DateTime.now().toUtc().microsecondsSinceEpoch}.$fileExtension';
    var uploadTasks = <UploadTask>[];

    DebugManager.log("generateUploadTasks for file: $originalPath");
    // Divide the original file into multiple parts, and create a UploadTask for each parts.

    var bytes = await _file.readAsBytes();
    var totalChunks = (bytes.length / chunkSize).ceil();
    for (var chunkIndex = 0; chunkIndex < totalChunks; chunkIndex += 1) {
      int startingByte = chunkIndex * chunkSize;
      int endingByte = (chunkIndex + 1) * chunkSize;
      bool hasMore = true;
      if (endingByte > bytes.length) {
        endingByte = bytes.length;
        hasMore = false;
      }
      var chunkBytes = bytes.sublist(startingByte, endingByte);
      var tempFileSubDir = 'upload-temp';
      var tempFilePath = "${applicationDocumentDirectory.path}/$tempFileSubDir/$filename.$chunkIndex.$fileExtension";
      var tempFile = await File(tempFilePath).create(recursive: true);
      tempFile.writeAsBytesSync(chunkBytes);
      _generatedTempFiles.add(tempFilePath);

      final url = ApiAgent.instance.folderFileUploadUrl(targetAlbumId);
      // final url = "https://babyphotos.innovay.dev/api/v1/files/chunk-upload-folder-file/3";
      // final url = InnoConfig.mainNetworkConfig.login();
      // final url = 'localhost';
      DebugManager.log("Chunk $chunkIndex: $tempFilePath created, $url, size: ${chunkBytes.length}");

      final task = UploadTask(
        url: url,
        headers: {
          'Authorization': 'Bearer ${user.getAccessToken()}',
          'Filename': filename,
          'Chunkindex': chunkIndex.toString(),
          'Hasmore': hasMore ? '1' : '0',
          'Uploadid': '0',
        },
        httpRequestMethod: 'POST',
        filename: basename(tempFilePath),
        directory: tempFileSubDir,
        updates: Updates.statusAndProgress, // request status and progress updates
        post: 'binary',
        retries: 3,
      );

      uploadTasks.add(task);
      updateTaskProgress(task.taskId, 0);

      if (!hasMore) break;
    }

    return uploadTasks;
  }
}
