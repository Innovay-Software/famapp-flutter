import '../global_data.dart';

class MainNetworkConfig {
  String apiVersion = '';
  String regionCABackend = '';
  String regionRemoteBackend = '';

  MainNetworkConfig(this.regionRemoteBackend, this.regionCABackend, this.apiVersion);

  String get mainBackend => InnoGlobalData.useRegionRemote ? regionRemoteBackend : regionCABackend;
  String get mainBackendApi => '$mainBackend/api/$apiVersion';

  String pingRegionCA() {
    return '$regionCABackend/api/$apiVersion/util/ping';
  }

  String pingRegionRemote() {
    return '$regionRemoteBackend/api/$apiVersion/util/ping';
  }

  String defaultAvatar() {
    return '$mainBackend/default-avatar.png';
  }

  String userAvatar(int userId) {
    return '$mainBackendApi/util/user-avatar/$userId';
  }

  String imageFullUpload() {
    return '$mainBackendApi/util/upload-image';
  }

  String fileFullUpload() {
    return '$mainBackendApi/util/upload-file';
  }

  String fileBase64ChunkUpload() {
    return '$mainBackendApi/util/base64-chunked-upload-file';
  }

  String folderFileChunkUpload(int folderId) {
    return '$mainBackendApi/folder-files/chunk-upload-folder-file/$folderId';
  }

  String displayFolderFileThumbnail(int folderFileId) {
    return '$mainBackendApi/folder-file-display/folder-file-thumbnail/$folderFileId';
  }

  String displayFolderFile(int folderFileId) {
    return '$mainBackendApi/folder-file-display/folder-file/$folderFileId';
  }
}
