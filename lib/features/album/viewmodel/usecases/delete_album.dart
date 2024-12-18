import 'package:famapp/features/album/viewmodel/datasources/AlbumRemoteDatasource.dart';

import '../../../../core/utils/api_utils.dart';
import '../../model/album.dart';

class DeleteAlbum {
  Future<ApiResponse> call({required List<Album> albums, required int albumId}) async {
    final datasource = AlbumRemoteDatasource();
    final response = await datasource.deleteFolder(folderId: albumId);
    if (!response.successful) {
      return response;
    }

    for (var i = 0; i < albums.length; i++) {
      if (albums[i].id == albumId) {
        albums.removeAt(i);
        break;
      }
    }
    return response;
  }
}
