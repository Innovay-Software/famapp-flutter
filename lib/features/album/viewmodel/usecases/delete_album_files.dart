import 'package:famapp/features/album/viewmodel/datasources/AlbumFilesRemoteDatasource.dart';

import '../../../../core/utils/api_utils.dart';
import '../../model/album.dart';

class DeleteAlbumFiles {
  Future<ApiResponse> call({
    required Album album,
    required List<int> deleteFileIds,
  }) async {
    final datasource = AlbumFilesRemoteDatasource();
    final response = await datasource.deleteFiles(folderId: album.id, folderFileIds: deleteFileIds);

    if (!response.successful) {
      return response;
    }

    for (var i = 0; i < album.files.length; i++) {
      if (deleteFileIds.isEmpty) {
        break;
      }

      if (deleteFileIds.contains(album.files[i].id)) {
        deleteFileIds.remove(album.files[i].id);
        album.files.removeAt(i);
        i -= 1;
      }
    }

    return response;
  }
}
