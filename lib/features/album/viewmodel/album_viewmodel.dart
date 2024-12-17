import '../../../core/abstracts/inno_viewmodel.dart';
import '../../../core/services/inno_secure_storage_service.dart';
import '../../../core/utils/debug_utils.dart';
import '../../../enums/enums.dart';
import '../model/album.dart';
import '../model/album_file.dart';
import 'usecases/delete_album.dart';
import 'usecases/delete_album_files.dart';
import 'usecases/load_album_files.dart';
import 'usecases/move_album_files.dart';
import 'usecases/save_album.dart';
import 'usecases/save_album_file.dart';
import 'usecases/set_album_files_shot_at_date.dart';

class AlbumViewmodel extends InnoViewmodel {
  static final AlbumViewmodel _instance = AlbumViewmodel._internal();
  factory AlbumViewmodel() => _instance;
  AlbumViewmodel._internal();

  final List<Album> _albums = [];
  List<Album> get albums => _albums;

  Album _currentAlbum = Album.createEmptyAlbum();
  Album get currentAlbum => _currentAlbum;

  void setCurrentAlbum(int albumId) {
    if (albumId == 0) {
      albumId = int.tryParse(InnoSecureStorageService().getStaticStorageValue(
            InnoSecureStorageKeys.lastActiveAlbumId,
          )) ??
          0;
    }
    for (var item in _albums) {
      if (item.id == albumId) {
        _currentAlbum = item;
        break;
      }
    }
    if (_currentAlbum == null) {
      if (_albums.isNotEmpty) {
        _currentAlbum = _albums.first;
      }
    }
    if (_currentAlbum != null) {
      InnoSecureStorageService().setStaticStorageValue(
        InnoSecureStorageKeys.lastActiveAlbumId,
        _currentAlbum!.id.toString(),
      );
    }
    notifyListeners();
  }

  void setAlbums(dynamic jsonData) {
    if (jsonData is! List) {
      return;
    }

    _albums.clear();
    for (var item in jsonData) {
      _albums.add(Album.fromJson(item));
    }
    setCurrentAlbum(0);
  }

  Future<bool> setAlbumNewParent(Album child, Album? newParent) async {
    DebugManager.log('set album new parent: ${child.title} -> ${newParent == null ? '-' : newParent.title}');
    if (newParent == null) {
      if (child.parent != null) {
        child.parent!.subAlbums.remove(child);
      }
      child.parent = null;
      child.parentId = 0;
      albums.add(child);
      final response = await saveAlbum(child);
      return response;
    }
    if (child == newParent) return true;
    if (child.parentId == newParent.id) return true;

    var newParentParentIds = newParent.getAncestorIdList();
    DebugManager.log(newParentParentIds.toString());

    if (newParentParentIds.contains(child.id)) {
      // Moving an album to one of its subAlbums
      var childFirstChild = newParent;
      while (true) {
        if (childFirstChild.parentId == child.id) break;
        childFirstChild = childFirstChild.parent!;
      }

      DebugManager.log('tempParent: ${childFirstChild.title}');
      if (child.parent == null) {
        childFirstChild.parent = null;
        childFirstChild.parentId = 0;
        albums.add(childFirstChild);
      } else {
        childFirstChild.parent = child.parent;
        childFirstChild.parentId = child.parentId;
        child.parent!.subAlbums.remove(child);
        child.parent!.subAlbums.add(childFirstChild);
      }

      child.subAlbums.remove(childFirstChild);
      saveAlbum(childFirstChild);
    }

    if (child.parent != null) {
      // DebugManager.log('check 2 ${child.parent!.id}');
      child.parent!.subAlbums.remove(child);
    } else {
      // DebugManager.log('check 3');
      albums.remove(child);
    }

    child.parent = newParent;
    child.parentId = newParent.id;
    newParent.subAlbums.add(child);
    saveAlbum(child);
    notifyListeners();
    return true;
  }

  Future<bool> saveAlbum(Album album) async {
    final useCase = SaveAlbum();
    final response = await useCase.call(album: album);
    if (!validateUseCaseResponse(response)) {
      return false;
    }
    notifyListeners();
    return true;
  }

  Future<bool> deleteAlbum(Album album) async {
    final useCase = DeleteAlbum();
    final response = await useCase.call(album: album);
    if (!validateUseCaseResponse(response)) {
      return false;
    }

    if (album.parent != null) {
      album.parent!.subAlbums.remove(album);
    } else {
      _albums.remove(album);
    }
    notifyListeners();
    return true;
  }

  Future<bool> setShotAtDate(List<int> albumFileIds, DateTime targetDate) async {
    final useCase = SetAlbumFilesShotAtDate();
    final response = await useCase.call(albumFileIds: albumFileIds, targetDate: targetDate);
    if (!validateUseCaseResponse(response)) {
      return false;
    }
    notifyListeners();
    return true;
  }

  List<Album> getAllAlbums() {
    var candidates = <Album>[];
    candidates.addAll(albums);
    var albumList = <Album>[];
    while (candidates.isNotEmpty) {
      albumList.add(candidates.first);
      if (candidates.first.subAlbums.isNotEmpty) {
        candidates.addAll(candidates.first.subAlbums);
      }
      candidates.removeAt(0);
    }
    return albumList;
  }

  Future<void> loadFromCache(List<int> albumIds) async {
    _albums.clear();
    for (var albumId in albumIds) {
      var album = await Album.loadFromLocalCache(albumId);
      if (album == null) continue;
      _albums.add(album);
    }
    setCurrentAlbum(0);
    notifyListeners();
  }

  Future<bool> loadFiles({
    required Album album,
    required bool forceReload,
    required DateTime pivotDate,
    required Function() startCallback,
  }) async {
    if (!forceReload && !album.hasMore) return false;
    startCallback();
    final useCase = LoadAlbumFiles();
    final response = await useCase.call(
      album: album,
      forceReload: forceReload,
      pivotDate: pivotDate,
      beforeShotAtDateTime: forceReload || album.files.isEmpty ? DateTime.now() : album.files.last.shotAt,
    );
    if (!validateUseCaseResponse(response)) {
      return false;
    }
    DebugManager.log("LoadFiles, notifyListeners");
    notifyListeners();
    return true;
  }

  Future<bool> deleteFiles({
    required Album album,
    required List<int> albumFileIds,
  }) async {
    final useCase = DeleteAlbumFiles();
    final response = await useCase.call(album: album, deleteFileIds: albumFileIds);
    if (!validateUseCaseResponse(response)) {
      return false;
    }
    notifyListeners();
    return true;
  }

  Future<bool> moveToNewAlbum({
    required Album oldAlbum,
    required Album newAlbum,
    required List<int> albumFileIds,
  }) async {
    final useCase1 = MoveAlbumFiles();
    final response1 = await useCase1.call(oldAlbum: oldAlbum, newAlbum: newAlbum, fileIds: albumFileIds);
    if (!validateUseCaseResponse(response1)) {
      return false;
    }

    final useCase2 = LoadAlbumFiles();
    final response2 = await useCase2.call(
      album: newAlbum,
      forceReload: true,
      pivotDate: DateTime.now().toUtc(),
      beforeShotAtDateTime: DateTime.now(),
    );
    if (!validateUseCaseResponse(response2)) {
      return false;
    }

    notifyListeners();
    return true;
  }

  Future<bool> saveAlbumFile({required AlbumFile albumFile}) async {
    final useCase1 = SaveAlbumFile();
    final response1 = await useCase1.call(albumFile: albumFile);
    if (!validateUseCaseResponse(response1)) {
      return false;
    }

    notifyListeners();
    return true;
  }
}
