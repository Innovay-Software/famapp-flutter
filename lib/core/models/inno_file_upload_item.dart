import 'dart:convert';
import 'dart:io';

import '../../features/settings/model/uploaded_file.dart';
import '../config.dart';
import '../exceptions/inno_api_exception.dart';
import '../utils/debug_utils.dart';
import '../utils/network_utils.dart';
import '../utils/snack_bar_manager.dart';

class InnoFileUploadItem {
  String localPath;
  String remoteUrl;
  bool isUploading;
  bool isUploaded;
  bool useChunkUpload = false;
  int uploadProgress = 0;
  final int chunkSize = InnoConfig.chunkUploadSizeInMb * 1000 * 1000;
  int fileSize = 0;
  DateTime lastModified;

  InnoFileUploadItem(
    this.localPath,
    this.remoteUrl,
    this.isUploading,
    this.isUploaded,
    this.lastModified,
  ) {
    getFileSize();
  }

  void getFileSize() async {
    var file = File(localPath);
    fileSize = await file.length();
  }

  Future<String> getBase64EncodedString() async {
    var file = File(localPath);
    var imageBytes = await file.readAsBytes();
    return base64.encode(imageBytes);
  }

  String getFileName() {
    if (remoteUrl.isNotEmpty) {
      return remoteUrl.split('/').last;
    }
    if (localPath.isNotEmpty) {
      return localPath.split('/').last;
    }
    return '-';
  }

  void uploadToCloud(
    Function(dynamic document) successCallback, {
    bool useChunkUpload = false,
    Function(int)? progressCallback,
  }) async {
    this.useChunkUpload = useChunkUpload;

    if (isUploaded && remoteUrl.isNotEmpty) {
      successCallback({'fileUrl': remoteUrl});
      return;
    }

    // if (useChunkUpload) {
    chunkUpload(
      localPath,
      '',
      0,
      progressCallback ?? (progress) {},
      successCallback,
    );
    // } else {
    //   fullUpload(successCallback);
    // }
  }

  Future<UploadedFile> uploadToCloudSync({
    bool useChunkUpload = true,
    Function(int)? progressCallback,
  }) async {
    this.useChunkUpload = useChunkUpload;
    var uploadedFile = await chunkUploadSync(localPath, '', progressCallback ?? (progress) {});
    return uploadedFile;
  }

  Future<void> fullUpload(Function(dynamic) successCallback, {int repeatCount = 0}) async {
    isUploading = true;
    var base64String = await getBase64EncodedString();
    try {
      var res = await NetworkManager.postRequestSync(
        InnoConfig.mainNetworkConfig.imageFullUpload(),
        dataLoad: {
          'fileName': localPath.split('/').last,
          'base64EncodedFile': base64String,
        },
      );

      isUploading = false;
      isUploaded = true;
      remoteUrl = res['data']['document']['fileUrl'];
      successCallback(res['data']['document']);
      return;
    } on InnoApiException catch (e) {
      DebugManager.error(e.errorMessage());
    } catch (e) {
      DebugManager.error(e.toString());
    }

    isUploading = false;
    if (repeatCount >= 3) {
      SnackBarManager.displayMessage('File upload error');
      return;
    }
    fullUpload(successCallback, repeatCount: repeatCount + 1);
  }

  void chunkUpload(
    String filepath,
    String chunkedFilename,
    int startingChunk,
    Function(int) progressCallback,
    Function(dynamic) successCallback,
  ) async {
    isUploading = true;
    File file = File(filepath);
    String filename = filepath.split('/').last;

    var bytes = await file.readAsBytes();
    int totalChunks = (bytes.length / chunkSize).ceil();
    int startingByte = startingChunk * chunkSize;
    int endingByte = (startingChunk + 1) * chunkSize;
    bool hasMore = true;
    if (endingByte > bytes.length) {
      endingByte = bytes.length;
      hasMore = false;
    }
    var chunkBytes = bytes.sublist(startingByte, endingByte);
    var base64Chunk = base64.encode(chunkBytes);
    var url = InnoConfig.mainNetworkConfig.fileBase64ChunkUpload();
    DebugManager.log("chunk upload: $url");

    try {
      var res = await NetworkManager.postRequestSync(url, dataLoad: {
        'base64EncodedContent': base64Chunk,
        'fileName': filename,
        'hasMore': hasMore,
        'chunkedFileName': chunkedFilename,
      });

      DebugManager.log("chunk upload success");
      DebugManager.log(res['data'].toString());
      if (hasMore) {
        uploadProgress = ((1.0 * startingChunk + 1) / totalChunks * 100).round();
        progressCallback(uploadProgress);
        chunkUpload(filepath, res['data']['chunkedFilename'], startingChunk + 1, progressCallback, successCallback);
      } else {
        uploadProgress = 100;
        isUploading = false;
        isUploaded = true;
        remoteUrl = res['data']['document']['fileUrl'];
        successCallback(res['data']['document']);
      }
    } on InnoApiException catch (e) {
      DebugManager.error(e.errorMessage());
    } catch (e) {
      DebugManager.error(e.toString());
    }
  }

  Future<UploadedFile> chunkUploadSync(String filepath, String chunkedFilename, Function(int) progressCallback) async {
    isUploading = true;
    File file = File(filepath);
    String filename = filepath.split('/').last;
    var fileBytes = await file.readAsBytes();
    int totalChunks = (fileBytes.length / chunkSize).ceil();
    int currentChunkIndex = 0;

    while (true) {
      int startingByte = currentChunkIndex * chunkSize;
      int endingByte = (currentChunkIndex + 1) * chunkSize;
      bool hasMore = true;
      if (endingByte >= fileBytes.length) {
        endingByte = fileBytes.length;
        hasMore = false;
      }
      var chunkBytes = fileBytes.sublist(startingByte, endingByte);
      var base64Chunk = base64.encode(chunkBytes);
      var url = InnoConfig.mainNetworkConfig.fileBase64ChunkUpload();
      DebugManager.log("chunk upload: $url");

      var res = await NetworkManager.postRequestSync(url, dataLoad: {
        'base64EncodedContent': base64Chunk,
        'fileName': filename,
        'hasMore': hasMore,
        'chunkedFileName': chunkedFilename,
      });

      DebugManager.log("chunk upload success");
      DebugManager.log(res['data'].toString());
      if (hasMore) {
        uploadProgress = ((1.0 * currentChunkIndex + 1) / totalChunks * 100).round();
        progressCallback(uploadProgress);
        currentChunkIndex += 1;
        continue;
      }
      uploadProgress = 100;
      isUploading = false;
      isUploaded = true;
      final uploadedFile = UploadedFile.fromJson(res['data']['document']);
      remoteUrl = uploadedFile.fileUrl;
      return uploadedFile;
    }
  }
}
