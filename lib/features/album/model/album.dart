import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../../../core/utils/debug_utils.dart';
import '../../settings/viewmodel/user_viewmodel.dart';
import '../viewmodel/enums/album_type.dart';
import 'album_file.dart';

class Album {
  Map rawData;

  int id = 0;
  int ownerId = 0;
  int parentId = 0;
  int totalFiles = 0;
  bool isDefault = false;
  bool isPrivate = false;
  bool hasMore = true;
  bool inviteePost = true;
  String title = '';
  String cover = '';
  String earliestFileDate = '';
  String latestFileDate = '';
  Map metadata = {};
  Album? parent;
  AlbumType albumType = AlbumType.normal;
  List<Album> subAlbums = [];
  List<int> inviteeIds = [];
  List<AlbumFile> files = [];
  // Map<String, Function()> updateListeners = {};
  bool isCallingApi = false;

  // Baby Album
  String babyName = '';
  DateTime babyBirthdate = DateTime.now();

  static String localCachePath(int folderId) {
    return 'userData/album$folderId.json';
  }

  static Future<Album?> loadFromLocalCache(int folderId) async {
    var cacheFilePath = localCachePath(folderId);
    try {
      var directory = await getApplicationDocumentsDirectory();
      var file = File('${directory.path}/$cacheFilePath');
      var data = jsonDecode(file.readAsStringSync());
      var folderModel = Album(data);
      var files = data['files'] as List<dynamic>;
      DebugManager.log("files count: ${files.length}");
      for (var file in files) {
        folderModel.files.add(AlbumFile(file));
      }
      return folderModel;
    } catch (e) {
      DebugManager.error('Unable to load from local cache $cacheFilePath, $e');
      return null;
    }
  }

  Album(this.rawData) {
    syncFromRawData(rawData);
  }

  void saveLocalCache() async {
    var cacheFilePath = localCachePath(id);
    var data = Map.from(rawData);
    var fileDataList = [];
    for (var file in files) {
      fileDataList.add(file.rawData);
    }
    data['files'] = fileDataList;
    var documentDirectory = await getApplicationDocumentsDirectory();
    var lastSlashIndex = cacheFilePath.lastIndexOf('/');
    if (lastSlashIndex > 0) {
      var subDirectory = cacheFilePath.substring(0, lastSlashIndex);
      if (!await Directory('${documentDirectory.path}/$subDirectory').exists()) {
        await Directory('${documentDirectory.path}/$subDirectory').create(recursive: true);
      }
    }

    var file = File('${documentDirectory.path}/$cacheFilePath');
    file.writeAsString(jsonEncode(data));
  }

  void syncFromRawData(Map rawData) {
    this.rawData = rawData;

    id = int.tryParse('${rawData['id']}') ?? 0;
    ownerId = int.tryParse('${rawData['ownerId']}') ?? 0;
    parentId = int.tryParse('${rawData['parentId']}') ?? 0;
    totalFiles = int.tryParse('${rawData['totalFiles']}') ?? 0;
    title = '${rawData['title'] ?? ''}';
    cover = '${rawData['cover'] ?? ''}';
    albumType = AlbumType.values.firstWhere(
      (e) => e.toShortString() == '${rawData['type'] ?? ''}',
      orElse: () => AlbumType.normal,
    );
    metadata = rawData['metadata'] ?? {};
    isDefault = rawData['isDefault'] == true;
    isPrivate = rawData['isPrivate'] == true;
    inviteePost = metadata['inviteePost'] ?? true;

    inviteeIds = ((rawData['inviteeIds'] ?? []) as List).map((item) => int.tryParse('$item') ?? 0).toList();
    earliestFileDate = '${rawData['earliestShotAt'] ?? ''}';
    latestFileDate = '${rawData['latestShotAt'] ?? ''}';

    subAlbums = [];

    for (var item in rawData['subFolders'] ?? []) {
      var child = Album.fromJson(item);
      child.parent = this;
      subAlbums.add(child);
    }

    if (rawData['latestPosts'] != null) {
      files.clear();
      for (var item in rawData['latestPosts']) {
        files.add(AlbumFile(item));
      }
      rawData['latestPosts'].clear();
    }
    DebugManager.log('folder $title has ${files.length} files');
  }

  factory Album.fromJson(Map json) {
    return Album(json);
  }

  Map<String, dynamic> toMap() {
    metadata['inviteePost'] = inviteePost;
    if (albumType == AlbumType.baby) {
      metadata['name'] = babyName;
      metadata['birthdate'] = babyBirthdate;
    }
    return {
      'ownerId': ownerId,
      'parentId': parentId,
      'title': title,
      'cover': cover,
      'type': albumType.toShortString(),
      'metadata': metadata,
      'isDefault': isDefault,
      'isPrivate': isPrivate,
      'inviteeIds': inviteeIds,
    };
  }

  List<int> getAncestorIdList() {
    var ids = <int>[];
    Album? currentParent = parent;
    while (true) {
      if (currentParent == null) break;
      ids.add(currentParent.id);
      currentParent = currentParent.parent;
    }
    return ids;
  }

  bool isOwner() {
    final userViewmodel = UserViewmodel();
    return ownerId == userViewmodel.currentUser.id;
  }

  bool canEditMediaFile(int mediaFileIndex) {
    if (isOwner()) return true;
    if (files[mediaFileIndex].isOwner()) return true;
    final userViewmodel = UserViewmodel();
    if (userViewmodel.currentUser.isAdmin()) return true;
    return false;
  }

  bool isDummy() {
    return id == 0;
  }

  static Album createEmptyAlbum() {
    final viewmodel = UserViewmodel();
    return Album({
      'ownerId': viewmodel.currentUser.id,
      'folderType': AlbumType.normal.toShortString(),
      'isDefault': false,
      'isPrivate': false,
    });
  }
}
