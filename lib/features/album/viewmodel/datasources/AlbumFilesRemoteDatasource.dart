import 'package:famapp/api_agent.dart';
import 'package:famapp/core/utils/api_utils.dart';

class AlbumFilesRemoteDatasource {
  Future<ApiResponse> getFilesAfterTimestamp({
    required int folderId,
    required DateTime pivotDate,
    required int microTimestamp,
  }) async {
    return ApiAgent.instance.folderFileGetFolderFilesAfterMicroTimestampShotAtEndPoint(
      folderId,
      pivotDate,
      microTimestamp,
    );
  }

  Future<ApiResponse> getFilesBeforeTimestamp({
    required int folderId,
    required DateTime pivotDate,
    required int microTimestamp,
  }) async {
    return ApiAgent.instance.folderFileGetFolderFilesBeforeMicroTimestampShotAtEndPoint(
      folderId,
      pivotDate,
      microTimestamp,
    );
  }

  Future<ApiResponse> deleteFiles({
    required int folderId,
    required List<int> folderFileIds,
  }) async {
    return ApiAgent.instance.folderFileDeleteFilesEndPoint(
      folderId,
      folderFileIds,
    );
  }

  Future<ApiResponse> updateSingleFile({
    required int folderFileId,
    required String remarks,
    required bool isPrivate,
  }) async {
    return ApiAgent.instance.folderFileUpdateSingleFolderFileEndPoint(
      folderFileId,
      remarks,
      isPrivate,
    );
  }

  Future<ApiResponse> updateMultipleFiles({
    required List<int> folderFileIds,
    required int newFolderId,
    required int newShotAtMicroTimestamp,
  }) async {
    return ApiAgent.instance.folderFileUpdateMultipleFolderFilesEndPoint(
      folderFileIds,
      newFolderId,
      newShotAtMicroTimestamp,
    );
  }
}
