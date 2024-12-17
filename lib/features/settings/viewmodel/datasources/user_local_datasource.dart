// import 'dart:convert';
// import 'dart:io';
//
// import 'package:path_provider/path_provider.dart';
//
// import '../../model/user.dart';
//
// class UserLocalDatasource {
//   String localCachePath(int userId) {
//     return 'userData/userModel$userId.json';
//   }
//
//   Future<bool> loadFromCache(int userId) async {
//     var cacheFilePath = localCachePath(userId);
//     try {
//       var directory = await getApplicationDocumentsDirectory();
//       var file = File('${directory.path}/$cacheFilePath');
//       if (!file.existsSync()) {
//         return false;
//       }
//       var data = jsonDecode(file.readAsStringSync());
//       var userModel = User.instance;
//       userModel.onUserLoggedIn(data, true);
//
//       var folderIdsRaw = (data['userData']['folder_ids'] ?? []) as List;
//       var folderIds = folderIdsRaw.map((item) => int.tryParse('$item') ?? 0).toList();
//
//       userModel.folders.clear();
//       for (var folderId in folderIds) {
//         var folderModel = await FolderModel.loadFromLocalCache(folderId);
//         if (folderModel == null) continue;
//
//         userModel.folders.add(folderModel);
//       }
//
//       return true;
//     } catch (e) {
//       DebugManager.error('Unable to load from local cache $cacheFilePath');
//       return false;
//     }
//   }
//
//   Future<User> saveToCache(User user) async {}
// }
