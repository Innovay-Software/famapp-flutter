import '../../../../core/utils/api_utils.dart';
import '../datasources/AlbumFilesRemoteDatasource.dart';

class SetAlbumFilesShotAtDate {
  Future<ApiResponse> call({required List<int> albumFileIds, required DateTime targetDate}) async {
    final datasource = AlbumFilesRemoteDatasource();
    final response = await datasource.updateMultipleFiles(
      folderFileIds: albumFileIds,
      newFolderId: -1,
      newShotAtMicroTimestamp: targetDate.microsecondsSinceEpoch,
    );
    if (!response.successful) {
      return response;
    }
    return response;
  }
}
