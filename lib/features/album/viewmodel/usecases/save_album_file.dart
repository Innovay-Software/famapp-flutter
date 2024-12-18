import 'package:famapp/features/album/viewmodel/datasources/AlbumFilesRemoteDatasource.dart';

import '../../../../core/utils/api_utils.dart';
import '../../model/album_file.dart';

class SaveAlbumFile {
  Future<ApiResponse> call({required AlbumFile albumFile}) async {
    final datasource = AlbumFilesRemoteDatasource();
    final response = await datasource.updateSingleFile(
      folderFileId: albumFile.id,
      remarks: albumFile.remark,
      isPrivate: albumFile.isPrivate,
    );
    if (!response.successful) {
      return response;
    }
    return response;
  }
}
