import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/abstracts/inno_viewmodel.dart';
import '../../../core/utils/debug_utils.dart';
import '../../../core/utils/snack_bar_manager.dart';
import '../model/cache_manager_model.dart';

class CacheManagerViewmodel extends InnoViewmodel {
  static final CacheManagerViewmodel _instance = CacheManagerViewmodel._internal();
  factory CacheManagerViewmodel() => _instance;
  CacheManagerViewmodel._internal();
  final String _videoCacheDir = 'KTVHTTPCache';
  final String _imageCacheDir = cacheImageFolderName;

  final CacheStats _cacheStats = CacheStats(
    totalCacheSize: 0,
    mediaCacheSize: 0,
    imDatabasesCacheSize: 0,
  );
  CacheStats get cacheStats => _cacheStats;

  Future<bool> getCacheStats() async {
    var totalCacheSize = 0.0;
    var mediaCacheSize = 0.0;
    var imDatabaseCacheSize = 0.0;

    var tempDir = await getTemporaryDirectory();
    var databaseDir = Directory(await getDatabasesPath());

    DebugManager.log("DatabasesPath: ${tempDir.path}");
    DebugManager.log("Documents: ${(await getApplicationDocumentsDirectory()).path}");
    List<FileSystemEntity> subDirList = tempDir.listSync();
    for (var dir in subDirList) {
      var dirName = dir.path.split('/').last;
      var dirSize = _getSize(dir);
      if (dirName == _imageCacheDir) {
        mediaCacheSize = 1.0 * dirSize;
        totalCacheSize += mediaCacheSize;
        continue;
      }
    }

    var ktvHttpCache = Directory("${databaseDir.path}/$_videoCacheDir");
    if (ktvHttpCache.existsSync()) {
      DebugManager.log("$_videoCacheDir: ${ktvHttpCache.path}");
      var videoCacheSize = _getSize(ktvHttpCache);
      mediaCacheSize += 1.0 * videoCacheSize;
      totalCacheSize += 1.0 * videoCacheSize;
    }

    DebugManager.log("Database Path: ${databaseDir.path}");
    subDirList = databaseDir.listSync();
    for (var dir in subDirList) {
      if (dir.path.endsWith('userData') || dir.path.endsWith('.db')) {
        var dirSize = _getSize(dir);
        imDatabaseCacheSize += dirSize;
        totalCacheSize += dirSize;
        continue;
      }
      if (dir.path.endsWith(_videoCacheDir)) {
        continue;
      }

      var dirSize = _getSize(dir);
      DebugManager.log("Dir = ${dir.path}: $dirSize");
      totalCacheSize += dirSize;
    }
    await Future.delayed(const Duration(seconds: 2));
    _cacheStats.totalCacheSize = totalCacheSize;
    _cacheStats.mediaCacheSize = mediaCacheSize;
    _cacheStats.imDatabasesCacheSize = imDatabaseCacheSize;
    notifyListeners();
    return true;
  }

  int _getSize(FileSystemEntity file) {
    if (file is File) {
      return file.lengthSync();
    } else if (file is Directory) {
      int sum = 0;
      List<FileSystemEntity> children = file.listSync();
      for (FileSystemEntity child in children) {
        sum += _getSize(child);
      }
      return sum;
    }
    return 0;
  }

  Future<void> clearImageAndVideoCache() async {
    var tempDir = await getTemporaryDirectory();
    var cacheImageDir = Directory('${tempDir.path}/$_imageCacheDir');
    if (cacheImageDir.existsSync()) {
      await cacheImageDir.delete(recursive: true);
    }

    var databaseDir = await getDatabasesPath();
    var cacheVideoDir = Directory('$databaseDir/$_videoCacheDir');
    if (cacheVideoDir.existsSync()) {
      // var subDirList = cacheVideoDir.listSync();
      // for (var dir in subDirList) {
      //   if (dir.path.endsWith('archive')) {
      //     continue;
      //   }
      //   if (await FileSystemEntity.isDirectory(dir.path)) {
      //     var subSubDirList = Directory(dir.path).listSync();
      //     for (var subDir in subSubDirList) {
      //       subDir.deleteSync(recursive: true);
      //     }
      //   }
      // }

      // Delete all video cache because switching back to Video_Player package
      cacheVideoDir.deleteSync(recursive: true);
    }

    cacheStats.totalCacheSize -= cacheStats.mediaCacheSize;
    cacheStats.mediaCacheSize = 0;
    notifyListeners();
    SnackBarManager.displayMessage('清除成功');
  }
}
