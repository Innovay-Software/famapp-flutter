import 'package:extended_image/extended_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/debug_utils.dart';

class CacheService {
  static Future<bool> clearCache(String url, String? cacheKey) async {
    // imageCache.clear();
    url = url.split('?').first;
    try {
      DebugManager.log("CacheService.clearCache: $url, $cacheKey");
      var result = await clearDiskCachedImage(url, cacheKey: cacheKey);
      DebugManager.log("clearDiskCachedImage: $result");
      return result;
    } catch (e) {
      DebugManager.error("Cannot clear cache: $url");
      DebugManager.error(e.toString());
    }
    return false;
  }

  static Future<FileInfo?> getCacheFile(String key) async {
    if (key.startsWith('http')) {
      key = key.split('?').first;
    }

    var file = await DefaultCacheManager().getFileFromCache(key);
    // GallerySaver.saveImage(file!.file.path);
    //
    //
    // final cache = await CacheManager();
    // final file = await cache.getFileFromCache(url);
    // return file.path;
    return file;
  }

  static void printCacheStatus() async {
    DebugManager.log("PrintCacheStatus");
    // var cacheManager = DefaultCacheManager();
    // cacheManager.
    final directory = await getApplicationDocumentsDirectory();
    var listener = directory.list(recursive: true);
    listener.listen((event) {
      DebugManager.log("Cache file: ${event.path}");
    });
  }
}
