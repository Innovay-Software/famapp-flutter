import 'package:famapp/core/utils/debug_utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../enums/enums.dart';

///
/// Secure Storage Wrapper
///
class InnoSecureStorageService {
  // Singleton instance
  static InnoSecureStorageService? _instance;

  // SecureStorage
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Cache
  // There two types of keys: static, dynamic.
  final Map<String, String> _storageCache = {};

  // Internal Constructor
  InnoSecureStorageService._();

  // Static async constructor
  static Future<InnoSecureStorageService> asyncConstructor() async {
    if (_instance != null) {
      return _instance!;
    }
    _instance = InnoSecureStorageService._();
    await _instance!._loadStaticSecureStorage();
    return _instance!;
  }

  // Factory constructor
  factory InnoSecureStorageService() {
    if (_instance == null) {
      throw Exception("InnoSecureStorageService has not been properly initialized, "
          "please call 'await InnoSecureStorage.init' in main");
    }
    return _instance!;
  }

  // Load all static data
  Future<void> _loadStaticSecureStorage() async {
    for (var key in InnoSecureStorageKeys.lastLoggedInUserId.allShortStrings()) {
      final value = await _storage.read(key: key) ?? '';
      _storageCache[key] = value;
    }
  }

  // Get static data
  String getStaticStorageValue(InnoSecureStorageKeys key, {String defaultValue = ''}) {
    return _storageCache[key.toShortString()] ?? defaultValue;
  }

  // Set static data
  void setStaticStorageValue(InnoSecureStorageKeys key, String value) {
    _storageCache[key.toShortString()] = value;
    _storage.write(key: key.toShortString(), value: value);
  }

  // Get accessToken
  Future<String> getAccessToken(int userId) async {
    return await _storage.read(key: 'User${userId}AccessToken') ?? '';
  }

  // Set accessToken
  Future<void> setAccessToken(int userId, String token) async {
    return await _storage.write(key: 'User${userId}AccessToken', value: token);
  }

  // Get refreshToken
  Future<String> getRefreshToken(int userId) async {
    return await _storage.read(key: 'User${userId}RefreshToken') ?? '';
  }

  // Set refreshToken
  Future<void> setRefreshToken(int userId, String token) async {
    return await _storage.write(key: 'User${userId}RefreshToken', value: token);
  }

  // Clear all cache
  void clearAllCache() {
    _storage.deleteAll();
  }

  // Log all storage
  Future<void> logAllStorageData() async {
    var temp = await _storage.readAll();
    DebugManager.log("InnoSecureStorageService.logAllStorageData");
    DebugManager.log(temp);
  }
}
