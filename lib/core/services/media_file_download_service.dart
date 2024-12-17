import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saver_gallery/saver_gallery.dart';

import '../../features/album/model/album_file.dart';
import '../utils/debug_utils.dart';
import '../utils/snack_bar_manager.dart';
import 'cache_service.dart';

class MediaFileDownloadJob {
  AlbumFile albumFile;
  bool downloadOriginal;
  int progress = 0;
  bool isDownloading = false;
  bool isCompleted = false;
  bool isFailed = false;
  dynamic error;
  final CancelToken _cancelToken = CancelToken();

  MediaFileDownloadJob(this.albumFile, this.downloadOriginal);

  void download(Function(bool, dynamic) callback) async {
    if (isDownloading) return;

    isDownloading = true;

    if (!downloadOriginal) {
      // Check for local cache
      var cachedFile = await CacheService.getCacheFile(albumFile.fileUrl);
      if (cachedFile != null) {
        DebugManager.log("Found cache");
        var isSuccessful = await saveToImageGallery(cachedFile.file.path);
        callback(isSuccessful, null);
        return;
      }
    }
    var appTempDir = await getTemporaryDirectory();
    var fileName = albumFile.fileName;
    var savePath = "${appTempDir.path}/$fileName";
    var url = downloadOriginal ? albumFile.originalFileUrl : albumFile.fileUrl;
    DebugManager.log("Start download: $url");
    // return;
    var response = await Dio().download(
      url,
      savePath,
      options: Options(headers: albumFile.fileUrlHeaders),
      onReceiveProgress: (count, total) {
        progress = (count / total * 100).floor();
        // DebugManager.log("${(count / total * 100).toStringAsFixed(0)}%");
      },
      cancelToken: _cancelToken,
    ).catchError((res) {
      isFailed = true;
      error = res;
      callback(false, res);
      return res;
    });

    DebugManager.log('Download completed for ${albumFile.id}');

    var isSuccessful = await saveToImageGallery(savePath);
    DebugManager.log("Saved to gallery: $isSuccessful for ${albumFile.id}");
    File(savePath).delete();
    isDownloading = false;
    isCompleted = true;
    callback(isSuccessful, null);
  }

  void cancelDownload() {
    _cancelToken.cancel();
  }

  Future<bool> saveToImageGallery(String localFilePath) async {
    var file = File(localFilePath);
    DebugManager.log("before saveToImageGallery: file size = ${file.lengthSync()}");

    ///
    /// Save option 1:image_gallery_saver
    /// Pro: None
    /// Cons: Not reserving EXIF info from the original file downloaded from server
    /// Action: Disable it for now
    ///
    // final result = await ImageGallerySaver.saveFile(localFilePath, isReturnPathOfIOS: true);
    // DebugManager.log("saveToImageGallery: $localFilePath");
    // DebugManager.log(result.toString());
    // if (!result['isSuccess']) {
    //   SnackBarManager.displayMessage(result['errorMessage']);
    //   return false;
    // }
    ///
    /// End of option 1
    ///

    ///
    /// Save option 2: saver_gallery
    /// Pro: Able to reserve EXIF data from the original file downloaded from server
    /// Cons: none
    /// Action: Enabled it since v1.8.5
    ///
    var result = await SaverGallery.saveFile(
      file: localFilePath,
      name: basename(localFilePath),
      androidExistNotSave: true,
    );
    DebugManager.log("was successful: ${result.isSuccess}");
    if (!result.isSuccess) {
      SnackBarManager.displayMessage(result.errorMessage ?? 'Error');
      return false;
    }
    //
    ///
    /// End of option 2
    ///

    progress = 100;
    isDownloading = false;
    isFailed = false;
    SnackBarManager.displayMessage('Download Succeeded');
    return true;
  }
}

class MediaFileDownloadService {
  List<MediaFileDownloadJob> jobs = [];

  bool isDownloading() {
    for (var item in jobs) {
      if (item.progress < 100) {
        return true;
      }
    }
    return false;
  }

  int getCurrentDownloadJobProgress() {
    if (jobs.isEmpty) {
      return 100;
    }

    int totalProgress = 0;
    for (var item in jobs) {
      totalProgress += item.progress;
    }
    return (totalProgress / jobs.length).floor();
  }

  void add(AlbumFile mediaFile, bool downloadOriginal) {
    var newJob = MediaFileDownloadJob(mediaFile, downloadOriginal);

    // Check for duplicate jobs
    for (var i = 0; i < jobs.length; i++) {
      if (jobs[i].albumFile == mediaFile || jobs[i].albumFile.id == mediaFile.id) {
        return;
      }
    }

    // No duplicates found
    jobs.add(newJob);
    DebugManager.log("Added to downloader ${jobs.length}");
    SnackBarManager.displayMessage('Start Download');
    startNextAvailableJob();
  }

  void startNextAvailableJob() {
    if (jobs.isEmpty) {
      return;
    }
    while (jobs.isNotEmpty && jobs.first.isCompleted) {
      jobs.removeAt(0);
    }
    if (jobs.isNotEmpty && !jobs.first.isCompleted && !jobs.first.isDownloading) {
      jobs.first.download((wasSuccessful, error) {
        if (!wasSuccessful) {
          DebugManager.log("Download error");
          DebugManager.log(error.toString());
        }
        startNextAvailableJob();
      });
    }
  }

  void delete(MediaFileDownloadJob downloadJob) {
    downloadJob.cancelDownload();
    jobs.remove(downloadJob);
    startNextAvailableJob();
  }
}
