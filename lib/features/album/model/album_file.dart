import '../../../core/config.dart';
import '../../../core/global_data.dart';
import '../../../core/services/cache_service.dart';
import '../../../core/utils/google_cloud_storage_util.dart';
import '../../../core/utils/hw_obs_util.dart';
import '../../settings/viewmodel/user_viewmodel.dart';

class AlbumFile {
  dynamic rawData;
  final int _cloudStorageSignedUrlValidHours = 48;

  int id = 0;
  int ownerId = 0;
  int folderId = 0;
  bool isPreprocessing = false;

  // HW OBS
  String _hwObsOriginalFilePath = '';
  String _hwObsOriginalFileSignedUrl = '';
  DateTime _hwObsOriginalFileSignatureExpireTime = DateTime.now();

  // Google Cloud Storage
  String _googleOriginalFilePath = '';
  String _googleOriginalFileSignedUrl = '';
  DateTime _googleUrlSignatureExpireTime = DateTime.now();

  // Local cache
  String thumbnailLocalPath = '';
  String fileLocalPath = '';

  String fileMd5 = '';
  String fileName = '';
  String fileType = '';
  String remark = '';
  String folderName = '';
  Map metadata = {};
  bool isPrivate = false;
  int views = 0;
  DateTime shotAt = DateTime.now().toLocal();
  DateTime createdAtUnused = DateTime.now().toLocal();

  String get heroKeyFile {
    return 'HeroFolderFile$id';
  }

  String get heroKeyThumbnail {
    return 'HeroFolderFileThumbnail$id';
  }

  String get cacheKeyOriginalFile {
    return 'CacheFolderFileOriginal.$fileName';
  }

  String get cacheKeyFile {
    return 'CacheFolderFile.$fileMd5.${fileType == 'image' ? 'jpg' : 'mp4'}';
  }

  String get cacheKeyThumbnail {
    return 'CacheFolderFileThumbnail.$fileMd5.jpg';
  }

  Map<String, String> get thumbnailUrlHeaders {
    final viewmodel = UserViewmodel();
    if (thumbnailUrl.startsWith('http')) {
      return {'Authorization': 'Bearer ${viewmodel.currentUser.getAccessToken()}'};
    }
    return {};
  }

  String get thumbnailUrl {
    if (thumbnailLocalPath.isNotEmpty) return thumbnailLocalPath;
    return InnoConfig.mainNetworkConfig.displayFolderFileThumbnail(id);
  }

  Map<String, String> get fileUrlHeaders {
    final viewmodel = UserViewmodel();
    if (fileUrl.startsWith('http')) {
      return {'Authorization': 'Bearer ${viewmodel.currentUser.getAccessToken()}'};
    }
    return {};
  }

  String get fileUrl {
    if (fileLocalPath.isNotEmpty) return fileLocalPath;
    return InnoConfig.mainNetworkConfig.displayFolderFile(id);
  }

  String get originalFileUrl {
    if (InnoGlobalData.useRegionRemote) {
      return _getHwObsOriginalFileSignedUrl();
    }
    return _getGoogleCloudStorageOriginalFileSignedUrl();
  }

  AlbumFile(this.rawData) {
    updateFromJson(rawData);
  }

  factory AlbumFile.fromJson(Map<String, dynamic> json) {
    return AlbumFile(json);
  }

  Map<String, dynamic> toJson() {
    return rawData;
  }

  void updateFromJson(dynamic jsonData) {
    rawData = jsonData;
    id = int.tryParse('${rawData['id']}') ?? 0;
    ownerId = int.tryParse('${rawData['ownerId']}') ?? 0;
    folderId = int.tryParse('${rawData['folderId']}') ?? 0;
    isPreprocessing = '${rawData['isPreprocessing']}' == '1';

    _hwObsOriginalFilePath = '${rawData['hwOriginalFilePath'] ?? ''}';
    _googleOriginalFilePath = '${rawData['googleOriginalFilePath'] ?? ''}';

    fileName = '${rawData['fileName']}';
    fileMd5 = fileName.split('.').first;

    fileType = '${rawData['fileType'] ?? ''}';
    remark = '${rawData['remark'] ?? ''}';
    folderName = rawData['folder'] != null ? '${rawData['folder']['title']}' : '';

    metadata = rawData['metadata'] is Map ? rawData['metadata'] : {};
    isPrivate = '${rawData['isPrivate']}' == '1';
    views = int.tryParse('${rawData['views']}') ?? 0;
    shotAt = (DateTime.tryParse('${rawData['shotAt']}') ?? DateTime.now().toUtc()).toLocal();
    createdAtUnused = DateTime.tryParse('${rawData['createdAt']}') ?? DateTime.now().toUtc();

    CacheService.getCacheFile(thumbnailUrl.split('?').first).then((fileInfo) {
      if (fileInfo != null) {
        thumbnailLocalPath = fileInfo.file.path;
      }
    });
    CacheService.getCacheFile(fileUrl.split('?').first).then((fileInfo) {
      if (fileInfo != null) {
        fileLocalPath = fileInfo.file.path;
      }
    });
  }

  String _getHwObsOriginalFileSignedUrl() {
    if (_hwObsOriginalFilePath.isEmpty) {
      // if the hw obs original file path is missing, returned the compressed fileUrl
      return fileUrl;
    }
    var isSignedUrlEmpty = _hwObsOriginalFileSignedUrl == '';
    var isSignedUrlAlmostExpired =
        _hwObsOriginalFileSignatureExpireTime.difference(DateTime.now()).inHours < _cloudStorageSignedUrlValidHours / 2;

    if (isSignedUrlEmpty || isSignedUrlAlmostExpired) {
      _hwObsOriginalFileSignatureExpireTime =
          DateTime.now().toUtc().add(Duration(hours: _cloudStorageSignedUrlValidHours));
      _hwObsOriginalFileSignedUrl = HwObsUtil.buildSignedUrl(
        _cloudStorageSignedUrlValidHours * 3600,
        _hwObsOriginalFilePath,
        fileType,
      );
    }
    return _hwObsOriginalFileSignedUrl;
  }

  String _getGoogleCloudStorageOriginalFileSignedUrl() {
    if (_googleOriginalFilePath.isEmpty) {
      // if the google original file path is missing, returned the compressed fileUrl
      return fileUrl;
    }
    var isSignedUrlEmpty = _googleOriginalFileSignedUrl == '';
    var isSignedUrlAlmostExpired =
        _googleUrlSignatureExpireTime.difference(DateTime.now()).inHours < _cloudStorageSignedUrlValidHours / 2;

    if (isSignedUrlEmpty || isSignedUrlAlmostExpired) {
      _googleUrlSignatureExpireTime = DateTime.now().add(Duration(hours: _cloudStorageSignedUrlValidHours));
      _googleOriginalFileSignedUrl = GoogleCloudStorageUtil.buildGoogleCloudStorageSignedUrl(
        _cloudStorageSignedUrlValidHours * 3600,
        '/${InnoGlobalData.googleCloudStorageBucketName}/$_googleOriginalFilePath',
      );
    }
    return _googleOriginalFileSignedUrl;
  }

  bool isOwner() {
    final viewmodel = UserViewmodel();
    return ownerId == viewmodel.currentUser.id;
  }

  String getSizeString() {
    int size = metadata['size'] ?? 0;
    if (size > 1000.0 * 1000.0 * 1000.0) {
      return '${(size / 1000.0 / 1000.0).ceil()} GB';
    } else if (size > 1000.0 * 1000.0 * 10) {
      return '${(size / 1000.0 / 1000.0).ceil()} MB';
    } else if (size > 1000.0 * 1000.0) {
      return '${(size / 1000.0 / 100.0).ceil() / 10.0} MB';
    } else {
      return '${(size / 1000.0).ceil()} KB';
    }
  }

  String getDurationString() {
    if (metadata['duration'] == null) {
      return '';
    }
    int seconds = metadata['duration'];
    int minutes = (seconds / 60).floor();
    seconds = seconds % 60;
    return '$minutes:${seconds < 10 ? '0' : ''}$seconds';
  }

  // void syncToCloud1(Function() successCallback) {
  //   NetworkManager.postRequest(InnoConfig.mainNetworkConfig.saveAlbumFile(id), {'remark': remark}, (res) {
  //     SnackBarManager.displayMessage('更新成功');
  //     successCallback();
  //   }, (p0) => null);
  // }
}
