import 'package:famapp/core/services/inno_secure_storage_service.dart';
import 'package:famapp/core/utils/debug_utils.dart';

import '../../album/viewmodel/album_viewmodel.dart';

class User {
  // static final User instance = User._();

  bool isLoggedIn = false;
  int id = 0;
  String uuid = '';
  String name = '';
  String mobile = '';
  String avatarUrl = '';
  String avatarCacheKey = '';
  String lockerPasscode = '';
  String _role = '';
  String _accessToken = '';
  String _refreshToken = '';

  @override
  String toString() {
    return '$isLoggedIn $id $name $mobile';
  }

  User._({
    required this.id,
    required this.uuid,
    required this.name,
    required this.mobile,
    required this.avatarUrl,
    required this.avatarCacheKey,
    required this.lockerPasscode,
    required String role,
  }) {
    _role = role;
  }

  static User fromJson(Map<String, dynamic> userData) {
    final user = User._(
      id: int.tryParse('${userData['id']}') ?? 0,
      uuid: '${userData['uuid']}',
      name: '${userData['name']}',
      mobile: '${userData['mobile']}',
      avatarUrl: '${userData['avatar']}',
      avatarCacheKey: 'UserAvatar${userData['id'] ?? 0}',
      role: '${userData['role']}',
      lockerPasscode: '${userData['lockerPasscode']}',
    );
    user.isLoggedIn = user._accessToken.isNotEmpty;
    return user;
  }

  static Future<User> fromJsonAndLoadTokensFromDisk(Map<String, dynamic> userData) async {
    final user = fromJson(userData);
    await user.loadAccessTokenAndRefreshToken();
    user.isLoggedIn = user._accessToken.isNotEmpty;
    return user;
  }

  static User dummy() {
    return User._(
      id: 0,
      uuid: "",
      name: "",
      mobile: "",
      avatarUrl: "",
      avatarCacheKey: "",
      role: "",
      lockerPasscode: "",
    );
  }

  Map<String, dynamic> toJson() {
    final albumViewmodel = AlbumViewmodel();
    final albumIds = <int>[];
    for (var item in albumViewmodel.getAllAlbums()) {
      albumIds.add(item.id);
    }
    return {
      'id': id,
      'uuid': uuid,
      'name': name,
      'mobile': mobile,
      'avatar': avatarUrl,
      'role': _role,
      'lockerPasscode': lockerPasscode,
      'folderIds': albumIds,
    };
  }

  bool isAdmin() {
    return _role == 'admin';
  }

  Future<void> loadAccessTokenAndRefreshToken() async {
    _accessToken = await InnoSecureStorageService().getAccessToken(id);
    _refreshToken = await InnoSecureStorageService().getRefreshToken(id);
    DebugManager.log("Loaded tokens: $_accessToken, $_refreshToken, $id");
    isLoggedIn = _accessToken.isNotEmpty;
  }

  Future<void> setAccessToken(String token) async {
    DebugManager.warning("Set access token: $token");
    _accessToken = token;
    await InnoSecureStorageService().setAccessToken(id, token);
  }

  String getAccessToken() {
    return _accessToken;
  }

  Future<void> clearAccessToken() async {
    DebugManager.warning("Clear access token");
    _accessToken = '';
    await InnoSecureStorageService().setAccessToken(id, '');
  }

  Future<void> setRefreshToken(String token) async {
    DebugManager.warning("Set refresh token: $token");
    _refreshToken = token;
    await InnoSecureStorageService().setRefreshToken(id, token);
  }

  String getRefreshToken() {
    return _refreshToken;
  }
}
