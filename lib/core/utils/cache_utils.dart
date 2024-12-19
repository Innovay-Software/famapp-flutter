class CacheUtils {
  static Map<String, dynamic> cacheMap = {};

  static setCache(String key, dynamic val) {
    cacheMap[key] = val;
  }

  static dynamic getCache(String key, dynamic defaultVal) {
    return cacheMap[key] ?? defaultVal;
  }

  static String _getAvatarKey(int userId) {
    return 'User${userId}Avatar';
  }

  static setAvatar(int userId, String url) {
    if (url.isEmpty) return;
    setCache(_getAvatarKey(userId), url);
  }
}
