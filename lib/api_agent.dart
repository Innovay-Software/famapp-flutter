import 'dart:convert';

import 'package:famapp/core/utils/datetime_util.dart';
import 'package:famapp_api/api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'core/utils/api_utils.dart';
import 'core/utils/debug_utils.dart';
import 'core/utils/dot_env_manager.dart';
import 'core/utils/snack_bar_manager.dart';
import 'core/utils/unit_utils.dart';

///
/// ApiAgent holds the API call logic
///
class ApiAgent {
  static ApiAgent? _instance;
  static ApiAgent get instance {
    if (_instance == null) {
      throw Exception("ApiAgent not properly initialized");
    }
    return _instance!;
  }

  final String mainBackend;
  final Function(String, String) tokenUpdateHandler;

  late HttpBearerAuth _bearerAuth;
  late ApiClient _client;
  late AdminApi _adminApi;
  late AuthApi _authApi;
  late FolderFileApi _ffApi;
  late FolderFileUploadApi _ffuApi;
  late LockerNotesApi _lockerNoteApi;
  late UserApi _userApi;
  late UtilApi _utilApi;

  ApiAgent._(this.mainBackend, this.tokenUpdateHandler) {
    _bearerAuth = HttpBearerAuth();
    _client = ApiClient(
      basePath: mainBackend,
      authentication: _bearerAuth,
    );

    _adminApi = AdminApi(_client);
    _authApi = AuthApi(_client);
    _ffApi = FolderFileApi(_client);
    _ffuApi = FolderFileUploadApi(_client);
    _lockerNoteApi = LockerNotesApi(_client);
    _userApi = UserApi(_client);
    _utilApi = UtilApi(_client);
  }

  static ApiAgent init(String mainBackend, Function(String, String) tokenUpdateHandler) {
    _instance = ApiAgent._(mainBackend, tokenUpdateHandler);
    return _instance!;
  }

  ///
  /// Auth Client
  ///
  Future<ApiResponse> authMobileLoginEndPoint(String mobile, String password, String deviceToken) async {
    return _processResponse(
        "authMobileLoginEndPoint",
        await _authApi.authMobileLoginPathWithHttpInfo(
          AuthMobileLoginPathRequest(mobile: mobile, password: password, deviceToken: deviceToken),
        ));
  }

  Future<ApiResponse> authAccessTokenLoginEndPoint(String accessToken, String deviceToken) async {
    _bearerAuth.accessToken = accessToken;
    // _authApi.apiClient.authentication =
    return _processResponse(
      "authAccessTokenLoginEndPoint",
      await _authApi.authAccessTokenLoginPathWithHttpInfo(
        AuthAccessTokenLoginPathRequest(deviceToken: deviceToken),
      ),
    );
  }

  ///
  /// Admin Client
  ///
  Future<ApiResponse> adminListUsersEndPoint(int afterId) async {
    return _processResponse(
      "adminListUsersEndPoint",
      await _adminApi.adminListUsersPathWithHttpInfo(afterId),
    );
  }

  Future<ApiResponse> adminAddUserEndPoint(
    String name,
    String mobile,
    String password,
    String lockerPasscode,
    String role,
    int familyId,
  ) async {
    return _processResponse(
      "adminAddUserEndPoint",
      await _adminApi.adminAddUserPathWithHttpInfo(
        AdminAddUserPathRequest(
          name: name,
          mobile: mobile,
          password: password,
          lockerPasscode: lockerPasscode,
          role: role,
          familyId: familyId,
        ),
      ),
    );
  }

  Future<ApiResponse> adminSaveUserEndPoint(
    int userId,
    String name,
    String mobile,
    String password,
    String lockerPasscode,
    String role,
    int familyId,
  ) async {
    return _processResponse(
      "adminSaveUserEndPoint",
      await _adminApi.adminSaveUserPathWithHttpInfo(
        userId,
        AdminSaveUserPathRequest(
          name: name,
          mobile: mobile,
          password: password.isEmpty ? null : password,
          lockerPasscode: lockerPasscode.isEmpty ? null : password,
          role: role,
          familyId: familyId,
        ),
      ),
    );
  }

  Future<ApiResponse> adminDeleteUserEndPoint(String userUuid) async {
    return _processResponse(
      "adminDeleteUserEndPoint",
      await _adminApi.adminDeleteUserPathWithHttpInfo(userUuid),
    );
  }

  ///
  /// FolderFile
  ///
  Future<ApiResponse> folderFileSaveFolderEndPoint(
    int folderId,
    int ownerId,
    int parentId,
    String title,
    String cover,
    String type,
    bool isDefault,
    bool isPrivate,
    Object metadata,
    List<int> invitees,
  ) async {
    return _processResponse(
      "folderFileSaveFolderEndPoint",
      await _ffApi.folderFileSaveFolderPathWithHttpInfo(
        folderId,
        FolderFileSaveFolderPathRequest(
          ownerId: ownerId,
          parentId: parentId,
          title: title,
          cover: cover,
          type: type,
          isDefault: isDefault,
          isPrivate: isPrivate,
          metadata: metadata,
          inviteeIds: invitees,
        ),
      ),
    );
  }

  Future<ApiResponse> folderFileDeleteFolderEndPoint(int folderId) async {
    return _processResponse(
      "folderFileDeleteFolderEndPoint",
      await _ffApi.folderFileDeleteFolderPathWithHttpInfo(folderId),
    );
  }

  Future<ApiResponse> folderFileGetFolderFilesAfterMicroTimestampShotAtEndPoint(
    int folderId,
    DateTime pivotDate,
    int microTimestamp,
  ) async {
    return _processResponse(
      "folderFileGetFolderFilesAfterMicroTimestampShotAtEndPoint",
      await _ffApi.folderFileGetFolderFilesAfterMicroTimestampShotAtWithHttpInfo(
          folderId, DatetimeUtils.formattedDate(pivotDate), microTimestamp),
    );
  }

  Future<ApiResponse> folderFileGetFolderFilesBeforeMicroTimestampShotAtEndPoint(
    int folderId,
    DateTime pivotDate,
    int microTimestamp,
  ) async {
    return _processResponse(
      "folderFileGetFolderFilesBeforeMicroTimestampShotAtEndPoint",
      await _ffApi.folderFileGetFolderFilesBeforeMicroTimestampShotAtWithHttpInfo(
          folderId, DatetimeUtils.formattedDate(pivotDate), microTimestamp),
    );
  }

  Future<ApiResponse> folderFileDeleteFilesEndPoint(
    int folderId,
    List<int> folderFileIds,
  ) async {
    return _processResponse(
        "folderFileDeleteFilesEndPoint",
        await _ffApi.folderFileDeleteFolderFilesPathWithHttpInfo(
          folderId,
          FolderFileDeleteFolderFilesPathRequest(folderFileIds: folderFileIds),
        ));
  }

  Future<ApiResponse> folderFileUpdateSingleFolderFileEndPoint(
    int folderFileId,
    String remarks,
    bool isPrivate,
  ) async {
    return _processResponse(
      "folderFileUpdateSingleFolderFileEndPoint",
      await _ffApi.folderFileUpdateSingleFolderFilePathWithHttpInfo(
        FolderFileUpdateSingleFolderFilePathRequest(
          folderFileId: folderFileId,
          remark: remarks.isEmpty ? null : remarks,
          isPrivate: isPrivate,
        ),
      ),
    );
  }

  Future<ApiResponse> folderFileUpdateMultipleFolderFilesEndPoint(
    List<int> folderFileIds,
    int newFolderId,
    int newShotAtMicroTimestamp,
  ) async {
    return _processResponse(
      "folderFileUpdateMultipleFolderFilesEndPoint",
      await _ffApi.folderFileUpdateMultipleFolderFilesPathWithHttpInfo(
        FolderFileUpdateMultipleFolderFilesPathRequest(
          folderFileIds: folderFileIds,
          newFolderId: newFolderId <= 0 ? null : newFolderId,
          newShotAtTimestamp: newShotAtMicroTimestamp <= 0 ? null : newShotAtMicroTimestamp,
        ),
      ),
    );
  }

  ///
  /// FolderFile Upload - disabled, will be handled by background uploader
  ///
  // Future<Map<String, dynamic>> folderFileChunkUploadEndPoint(
  //   int folderId,
  //   String hasMore,
  //   String filename,
  //   String chunkIndex,
  //   String uploadId,
  //   MultipartFile body,
  // ) async {
  //   return _processResponse(
  //     "folderFileChunkUploadEndPoint",
  //     await _ffuApi.folderFileChunkUploadPathWithHttpInfo(
  //       folderId,
  //       hasMore,
  //       filename,
  //       chunkIndex,
  //       uploadId,
  //       body,
  //     ),
  //   );
  // }

  Future<ApiResponse> folderFileGetChunkUploadIdEndPoint() async {
    return _processResponse(
      "folderFileGetChunkUploadIdEndPoint",
      await _ffuApi.folderFileGetChunkUploadIdPathWithHttpInfo(),
    );
  }

  ///
  /// Locker Notes
  ///
  Future<ApiResponse> lockerNoteListEndPoint() async {
    return _processResponse(
      "lockerNoteListEndPoint",
      await _lockerNoteApi.lockerNoteListPathWithHttpInfo(),
    );
  }

  Future<ApiResponse> lockerNoteSaveEndPoint(
    int noteId,
    String title,
    String content,
    List<int> inviteeIds,
  ) async {
    return _processResponse(
      "lockerNoteSaveEndPoint",
      await _lockerNoteApi.lockerNoteSavePathWithHttpInfo(
        noteId,
        LockerNoteSavePathRequest(
          title: title,
          content: content,
          inviteeIds: inviteeIds,
        ),
      ),
    );
  }

  Future<ApiResponse> lockerNoteDeleteEndPoint(int noteId) async {
    return _processResponse(
      "lockerNoteDeleteEndPoint",
      await _lockerNoteApi.lockerNoteDeletePathWithHttpInfo(noteId),
    );
  }

  ///
  /// User Client
  ///
  Future<ApiResponse> userUpdateProfileEndPoint(
    String? name,
    String? mobile,
    String? password,
    String? lockerPasscode,
    String? avatar,
  ) async {
    return _processResponse(
        "userUpdateProfileEndPoint",
        await _userApi.userUpdateProfilePathWithHttpInfo(
          UserUpdateProfilePathRequest(
            name: name,
            mobile: mobile,
            password: password,
            lockerPasscode: lockerPasscode,
            avatarUrl: avatar,
          ),
        ));
  }

  ///
  /// Util Client
  ///
  Future<ApiResponse> utilConfigEndPoint(
    String configKey,
  ) async {
    return _processResponse(
      "utilConfigEndPoint",
      await _utilApi.utilConfigPathWithHttpInfo(configKey),
    );
  }

  Future<ApiResponse> utilBase64ChunkUploadEndPoint(
    String base64EncodedContent,
    String fileName,
    String chunkedFileName,
    bool hasMore,
  ) async {
    return _processResponse(
      "utilBase64ChunkUploadEndPoint",
      await _utilApi.utilBase64ChunkUploadPathWithHttpInfo(
        UtilBase64ChunkUploadPathRequest(
          base64EncodedContent: base64EncodedContent,
          fileName: fileName,
          chunkedFileName: chunkedFileName,
          hasMore: hasMore,
        ),
      ),
    );
  }

  Future<ApiResponse> utilCheckForMobileUpdateEndPoint(
    String clientOs,
    String clientVersion,
  ) async {
    return _processResponse(
      "utilCheckForMobileUpdateEndPoint",
      await _utilApi.utilCheckForMobileUpdatePathWithHttpInfo(clientOs, clientVersion),
    );
  }

  Future<ApiResponse> utilPingEndPoint() async {
    return _processResponse(
      "utilPingEndPoint",
      await _utilApi.utilPingPathWithHttpInfo(),
    );
  }

  ///
  /// Helper Functions
  ///
  ApiResponse _processResponse(String url, http.Response response) {
    final logResponses = DotEnvField.LOG_NETWORK_RESPONSES.getDotEnvBool(false);
    if (logResponses || true) {
      DebugManager.rest("Response ${UnitUtils.formatByteLength(response.contentLength ?? 0)} of $url");
      DebugManager.rest(response.body);
    }
    if (response.statusCode != 200) {
      if (logResponses || kDebugMode) {
        DebugManager.rest(
            "Request error: ${response.request?.url.toString()}, stats code = ${response.statusCode.toString()}");
        DebugManager.rest(response.body);
      }
      SnackBarManager.displayMessage('System error ${response.statusCode}');
      throw ApiException(url, '${response.statusCode} Error');
    }
    final res = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    if (!res['success']) {
      if (res['errorMessage'] != null) {
        SnackBarManager.displayMessage(res['errorMessage'].toString());
        // if (kDebugMode) {
        //   // For debug purposes only:
        //   throw ApiException(url, res['errorMessage'].toString());
        // }
      } else {
        throw ApiException(url, 'bodyBytes decode error');
      }
    }

    // Logging
    if (logResponses) {
      DebugManager.rest("Request success: ${response.request?.url.toString()}");
    }

    // Snackbar Message
    var snackBarMessage = res['snackBarMessage'] ?? '';
    if (snackBarMessage != null && snackBarMessage.isNotEmpty) {
      SnackBarManager.displayMessage(snackBarMessage);
    }

    // Token update
    var refreshToken = '${res['data']['refreshToken'] ?? ''}';
    var accessToken = '${res['data']['accessToken'] ?? ''}';
    if (refreshToken.isNotEmpty || accessToken.isNotEmpty) {
      tokenUpdateHandler(refreshToken, accessToken);
    }

    // Update access token for bearer authentication
    if (accessToken.isNotEmpty) {
      _bearerAuth.accessToken = accessToken;
    }

    return ApiResponse.fromMap(res['success'] ?? false, res);
  }

  String folderFileUploadUrl(int folderId) {
    // ToDo: get url from ApiAgent instead of hard coding it in like this.
    // Needs to look into openapi generator and see if it supports extract url directly.
    return '$mainBackend/api/v2/folder-files/chunk-upload-folder-file/$folderId';
  }

  String displayFolderFileThumbnail(int folderFileId) {
    // ToDo: get url from ApiAgent instead of hard coding it in like this.
    // Needs to look into openapi generator and see if it supports extract url directly.
    return '$mainBackend/folder-file-display/folder-file-thumbnail/$folderFileId';
  }

  String displayFolderFile(int folderFileId) {
    // ToDo: get url from ApiAgent instead of hard coding it in like this.
    // Needs to look into openapi generator and see if it supports extract url directly.
    return '$mainBackend/folder-file-display/folder-file/$folderFileId';
  }
}

class ApiException implements Exception {
  String url;
  String error;
  ApiException(this.url, this.error);

  String errorMessage() {
    return error;
  }

  String fullErrorMessage() {
    return ("Invalid API call: $url ($error)");
  }
}
