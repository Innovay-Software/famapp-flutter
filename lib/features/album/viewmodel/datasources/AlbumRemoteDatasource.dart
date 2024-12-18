import 'package:famapp/api_agent.dart';

import '../../../../core/utils/api_utils.dart';

class AlbumRemoteDatasource {
  Future<ApiResponse> saveFolder({
    required int folderId,
    required int ownerId,
    required int parentId,
    required String title,
    required String cover,
    required String type,
    required bool isDefault,
    required bool isPrivate,
    required Object metadata,
    required List<int> invitees,
  }) async {
    return ApiAgent.instance.folderFileSaveFolderEndPoint(
      folderId,
      ownerId,
      parentId,
      title,
      cover,
      type,
      isDefault,
      isPrivate,
      metadata,
      invitees,
    );
  }

  Future<ApiResponse> deleteFolder({
    required int folderId,
  }) async {
    return ApiAgent.instance.folderFileDeleteFolderEndPoint(
      folderId,
    );
  }

  Future<ApiResponse> loginWithAccessToken({
    required String accessToken,
    required String deviceToken,
  }) async {
    return ApiAgent.instance.authAccessTokenLoginEndPoint(accessToken, deviceToken);
  }

  Future<ApiResponse> updateUserProfile({
    required String? name,
    required String? mobile,
    required String? password,
    required String? lockerPasscode,
    required String? avatar,
  }) async {
    return ApiAgent.instance.userUpdateProfileEndPoint(name, mobile, password, lockerPasscode, avatar);
  }
}
