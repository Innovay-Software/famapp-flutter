import '../../../../core/utils/api_utils.dart';
import '../../model/album.dart';
import '../datasources/AlbumFilesRemoteDatasource.dart';

class MoveAlbumFiles {
  Future<ApiResponse> call({
    required Album oldAlbum,
    required Album newAlbum,
    required List<int> fileIds,
  }) async {
    final datasource = AlbumFilesRemoteDatasource();
    final response = await datasource.updateMultipleFiles(
      folderFileIds: fileIds,
      newFolderId: newAlbum.id,
      newShotAtMicroTimestamp: -1,
    );

    if (!response.successful) {
      return response;
    }

    for (var i = 0; i < oldAlbum.files.length; i++) {
      if (fileIds.isEmpty) {
        break;
      }

      if (fileIds.contains(oldAlbum.files[i].id)) {
        fileIds.remove(oldAlbum.files[i].id);
        oldAlbum.files.removeAt(i);
        i--;
      }
    }

    return response;
  }
}
