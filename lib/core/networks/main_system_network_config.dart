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

  String login() {
    return '$mainBackendApi/auth/mobile-login';
  }

  String accessTokenLogin() {
    return '$mainBackendApi/auth/access-token-login';
  }

  String logout() {
    return '$mainBackendApi/auth/logout';
  }

  String updateUserProfile() {
    return '$mainBackendApi/user/update-profile';
  }

  String defaultAvatar() {
    return '$mainBackend/default-avatar.png';
  }

  // String appInitialization() {
  //   return '$mainBackendApi/public/app-initialization/app';
  // }

  String checkForUpdate(String os, String version) {
    return '$mainBackendApi/util/check-for-mobile-update/$os/$version';
  }

  // String setUserAvatar() {
  //   return '$mainBackendApi/user/set-user-avatar';
  // }

  // String getUsers2() {
  //   return '$mainBackendApi/user/get-users';
  // }

  // String updateDeviceToken2() {
  //   return '$mainBackendApi/user/update-device-token';
  // }

  // String pagePublic2(String pageName) {
  //   return '$mainBackendApi/public/page/app/$pageName';
  // }

  String userAvatar(int userId) {
    return '$mainBackendApi/util/user-avatar/$userId';
  }

  String getConfig(String configKey) {
    return '$mainBackendApi/util/config/$configKey';
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

  // String wholeUploadFolderFile(int folderId) {
  //   return '$mainBackendApi/files/whole-upload-folder-file/$folderId';
  // }

  String folderFileChunkUploadInit() {
    return '$mainBackendApi/folder-files/chunk-upload-folder-file-get-upload-id';
  }

  String folderFileChunkUpload(int folderId) {
    return '$mainBackendApi/folder-files/chunk-upload-folder-file/$folderId';
  }

  String getFolderFilesBeforeMicroTimestamp(int folderId, String pivotDate, int microTimestampUTC) {
    return '$mainBackendApi/folder-files/get-folder-files-before-micro-timestamp/$folderId/$pivotDate/$microTimestampUTC';
  }

  String saveAlbum(int folderId) {
    return '$mainBackendApi/folder-files/save-folder/$folderId';
  }

  String deleteAlbum(int folderId) {
    return '$mainBackendApi/folder-files/delete-folder/$folderId';
  }

  String deleteFiles(int folderId) {
    return '$mainBackendApi/folder-files/delete-files/$folderId';
  }

  // Old 1
  String moveFilesToAlbum(int folderId) {
    return '$mainBackendApi/folder-files/update-multiple-folder-files';
  }

  // Old 2
  String setShotAtDate(String date) {
    return '$mainBackendApi/folder-files/update-multiple-folder-files';
  }

  String displayFolderFileThumbnail(int folderFileId) {
    return '$mainBackendApi/folder-file-display/folder-file-thumbnail/$folderFileId';
  }

  String displayFolderFile(int folderFileId) {
    return '$mainBackendApi/folder-file-display/folder-file/$folderFileId';
  }

  String saveAlbumFile(int folderFileId) {
    return '$mainBackendApi/folder-files/update-folder-file/$folderFileId';
  }

  String getLockerNotes(int page, int pageSize) {
    return '$mainBackendApi/locker-notes/list-notes';
  }

  String saveLockerNote(int noteId) {
    return '$mainBackendApi/locker-notes/save-note/$noteId';
  }

  String deleteLockerNote(int noteId) {
    return '$mainBackendApi/locker-notes/delete-note/$noteId';
  }

  String adminGetAllMembers(int afterId) {
    return '$mainBackendApi/admin/get-all-users/$afterId';
  }

  String adminSaveMemberInfo(int memberId) {
    return '$mainBackendApi/admin/save-user/$memberId';
  }

  String adminDeleteMember(int memberId) {
    return '$mainBackendApi/admin/delete-user/$memberId';
  }
}
