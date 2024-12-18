import 'dart:convert';
import 'dart:io';

import 'package:famapp/features/settings/viewmodel/usecases/update_user_profile.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/abstracts/inno_viewmodel.dart';
import '../../../core/global_data.dart';
import '../../../core/models/inno_file_upload_item.dart';
import '../../../core/services/file_service.dart';
import '../../../core/services/inno_secure_storage_service.dart';
import '../../../core/utils/cache_utils.dart';
import '../../../core/utils/debug_utils.dart';
import '../../../enums/enums.dart';
import '../../album/viewmodel/album_viewmodel.dart';
import '../../members/model/member_model.dart';
import '../../members/viewmodel/members_viewmodel.dart';
import '../model/used_account.dart';
import '../model/user.dart';
import 'usecases/upload_user_avatar.dart';
import 'usecases/user_login.dart';
import 'usecases/user_refresh_token.dart';
import 'used_account_viewmodel.dart';

///
/// User Viewmodel
///
class UserViewmodel extends InnoViewmodel {
  static late BuildContext mainContext;
  static UserViewmodel? _instance;
  User _user = User.dummy();
  User get currentUser => _user;

  UserViewmodel._();

  static Future<UserViewmodel> asyncConstructor() async {
    if (_instance != null) {
      return _instance!;
    }
    _instance = UserViewmodel._();
    await _instance!._loadFromLocalCache();
    return _instance!;
  }

  factory UserViewmodel() {
    if (_instance == null) {
      throw Exception("UserViewmodel has not been properly initialized");
    }
    return _instance!;
  }

  // Handles user log in, returns bool to indicate if log in was successful
  Future<bool> login(String mobile, String password, String deviceToken) async {
    final useCase = UserLogin();
    final response = await useCase.call(
      mobile: mobile,
      password: password,
      deviceToken: deviceToken,
    );

    if (!validateUseCaseResponse2(response)) {
      return false;
    }

    _onUserLoggedIn(response.data, '');
    return true;
  }

  Future<bool> loginWithAccessToken(String localAccessToken) async {
    final useCase = UserLoginWithAccessToken();
    final response = await useCase.call(accessToken: localAccessToken);
    if (!validateUseCaseResponse2(response)) {
      return false;
    }

    _onUserLoggedIn(response.data, localAccessToken);
    return true;
  }

  void _onUserLoggedIn(Map<String, dynamic> jsonData, String localAccessToken) {
    DebugManager.warning("_onUserLoggedIn: $localAccessToken");
    final userData = jsonData['userData'];
    final memberListData = jsonData['memberList'];
    final foldersData = jsonData['folders'];
    final albumViewmodel = AlbumViewmodel();

    _user = User.fromJson(userData);
    _user.setAccessToken('${jsonData['accessToken']}');
    _user.setRefreshToken('${jsonData['refreshToken']}');

    albumViewmodel.setAlbums(foldersData);

    _saveToLocalCache();
    _storeLastLoggedInUserId();

    UsedAccountViewmodel().addToUsedAccount(UsedAccount(
      id: _user.id,
      name: _user.name,
      mobile: _user.mobile,
      avatar: _user.avatarUrl,
    ));

    final memberViewModel = MemberViewmodel();
    final memberList = <Member>[];
    for (var item in memberListData) {
      var member = Member.fromJson(item);
      memberList.add(member);
      CacheUtils.setAvatar(member.id, member.avatar);
    }
    memberViewModel.members.clear();
    memberViewModel.members.addAll(memberList);

    if (jsonData['imCenterData'] != null) {
      InnoGlobalData.wsInitialization(jsonData['imCenterData']);
    }
    if (jsonData['notifications'] != null) {
      InnoGlobalData.notificationService.syncRawData(jsonData['notifications']);
    }

    // Used for Google Cloud Storage url signing
    InnoGlobalData.googleCloudStorageDomain = jsonData['googleCloudStorageDomain'] ?? '';
    InnoGlobalData.googleCloudStorageBucketName = jsonData['googleCloudStorageBucketName'] ?? '';
    InnoGlobalData.googleCloudStorageAccessId = jsonData['googleCloudStorageAccessId'] ?? '';
    InnoGlobalData.googleCloudStorageAccessSecretKey = jsonData['googleCloudStorageAccessSecretKey'] ?? '';

    // Used for HW Obs url signing
    InnoGlobalData.hwObsDomain = jsonData['hwObsDomain'] ?? '';
    InnoGlobalData.hwObsBucketName = jsonData['hwObsBucketName'] ?? '';
    InnoGlobalData.hwObsAccessId = jsonData['hwObsAccessId'] ?? '';
    InnoGlobalData.hwObsAccessSecretKey = jsonData['hwObsAccessSecretKey'] ?? '';

    notifyListeners();
  }

  Future<void> logout() async {
    InnoGlobalData.switchLoadingOverlay(true);
    _user = User.fromJson({});

    _user.isLoggedIn = false;
    _user.id = 0;
    _user.uuid = '';
    _user.name = '';
    _user.mobile = '';
    _user.avatarUrl = '';
    _user.clearAccessToken();
    _storeLastLoggedInUserId();

    InnoSecureStorageService().clearAllCache();
    InnoGlobalData.switchLoadingOverlay(false);
    Navigator.pushNamedAndRemoveUntil(InnoGlobalData.bottomNavigatorContext!, '/InitializationScreen', (r) => false);
    InnoGlobalData.bottomNavigatorContext = null;
  }

  // Picks a media, upload it to cloud, and saves user profile
  Future<bool> updateUserAvatar(Function(InnoFileUploadItem?) progressCallback) async {
    final filePaths = await FileService.pickMedias(1, true, true, false);
    if (filePaths.isEmpty) {
      return false;
    }

    var oldAvatarUrl = currentUser.avatarUrl;
    currentUser.avatarUrl = filePaths.first;
    notifyListeners();

    final InnoFileUploadItem uploadItem = InnoFileUploadItem(filePaths.first, '', false, false, DateTime.now());
    final useCase = UploadUserAvatar();
    await useCase.call(user: _user, uploadItem: uploadItem, progressCallback: progressCallback);
    if (!uploadItem.isUploaded) {
      DebugManager.log("Unable to upload file, rolling back to oldAvatarUrl");
      currentUser.avatarUrl = oldAvatarUrl;
      notifyListeners();
      return false;
    }

    currentUser.avatarUrl = uploadItem.remoteUrl;
    progressCallback(null);

    return updateUserProfile(avatar: currentUser.avatarUrl);
  }

  // Updates user profile
  Future<bool> updateUserProfile({
    String name = '',
    String mobile = '',
    String password = '',
    String lockerPasscode = '',
    String avatar = '',
  }) async {
    final total = [name, mobile, password, lockerPasscode, avatar].join('');
    DebugManager.info("Save user profile: $total");
    if (total.isEmpty) {
      return true;
    }
    final user = UserViewmodel().currentUser;
    final useCase = UpdateUserProfile();
    final response = await useCase.call(
      name: name.isEmpty ? null : name,
      mobile: mobile.isEmpty ? null : mobile,
      password: password.isEmpty ? null : password,
      lockerPasscode: lockerPasscode.isEmpty ? null : lockerPasscode,
      avatar: avatar.isEmpty ? null : avatar,
    );
    if (!validateUseCaseResponse2(response)) {
      return false;
    }

    user.name = name;
    user.mobile = mobile;
    if (lockerPasscode.isNotEmpty) {
      user.lockerPasscode = lockerPasscode;
    }
    if (avatar.isNotEmpty) {
      user.avatarUrl = response.data["userData"]["avatar"];
      CacheUtils.setAvatar(user.id, user.avatarUrl);
    }

    _saveToLocalCache();
    notifyListeners();
    return true;
  }

  String _localCachePath(int userId) {
    return 'userData/userModel$userId.json';
  }

  // Load user model from local cache
  Future<bool> _loadFromLocalCache() async {
    final lastLoggedInUserId = int.tryParse(getLastLoggedInUserId()) ?? 0;
    DebugManager.log("Last logged in user ID: $lastLoggedInUserId");
    if (lastLoggedInUserId == 0) return false;
    final cacheFilePath = _localCachePath(lastLoggedInUserId);

    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$cacheFilePath');
      if (!file.existsSync()) {
        return false;
      }

      final userData = jsonDecode(file.readAsStringSync());
      _user = await User.fromJsonAndLoadTokensFromDisk(userData);
      await _user.loadAccessTokenAndRefreshToken();

      final folderIdsRaw = (userData['folderIds'] ?? []) as List;
      final folderIds = folderIdsRaw.map((item) => int.tryParse('$item') ?? 0).toList();
      DebugManager.log("FolderIds: $folderIds");

      final albumViewmodel = AlbumViewmodel();
      await albumViewmodel.loadFromCache(folderIds);

      notifyListeners();
      return _user.isLoggedIn;
    } catch (e, stacktrace) {
      DebugManager.error('Unable to load from local cache $cacheFilePath');
      DebugManager.error(stacktrace);
    }
    return false;
  }

  void _saveToLocalCache() async {
    final cacheFilePath = _localCachePath(_user.id);
    final userData = _user.toJson();
    final documentDirectory = await getApplicationDocumentsDirectory();
    final lastSlashIndex = cacheFilePath.lastIndexOf('/');
    if (lastSlashIndex > 0) {
      final subDirectory = cacheFilePath.substring(0, lastSlashIndex);
      if (!await Directory('${documentDirectory.path}/$subDirectory').exists()) {
        await Directory('${documentDirectory.path}/$subDirectory').create(recursive: true);
      }
    }

    final file = File('${documentDirectory.path}/$cacheFilePath');
    DebugManager.log('UserMode.saveToLocalCache: saving to ${file.path}');
    file.writeAsString(jsonEncode(userData));

    // for (var folder in albums) {
    //   folder.saveLocalCache();
    // }
  }

  String getLastLoggedInUserId() {
    return InnoSecureStorageService().getStaticStorageValue(InnoSecureStorageKeys.lastLoggedInUserId);
  }

  String getStoredDefaultMediaSource() {
    return InnoSecureStorageService().getStaticStorageValue(InnoSecureStorageKeys.defaultMediaSource);
  }

  void _storeLastLoggedInUserId() {
    InnoSecureStorageService().setStaticStorageValue(InnoSecureStorageKeys.lastLoggedInUserId, '${_user.id}');
  }
}
