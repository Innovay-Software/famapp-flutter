import 'package:famapp/features/album/viewmodel/enums/album_type.dart';

import '../../../../core/utils/api_utils.dart';
import '../../model/album.dart';
import '../datasources/AlbumRemoteDatasource.dart';

class SaveAlbum {
  Future<ApiResponse> call({required Album album}) async {
    final datasource = AlbumRemoteDatasource();
    final response = await datasource.saveFolder(
      folderId: album.id,
      ownerId: album.ownerId,
      parentId: album.parentId,
      title: album.title,
      cover: album.cover,
      type: album.albumType.toShortString(),
      isDefault: album.isDefault,
      isPrivate: album.isPrivate,
      metadata: album.metadata,
      invitees: album.inviteeIds,
    );
    if (!response.successful) {
      return response;
    }
    return response;
  }
}
