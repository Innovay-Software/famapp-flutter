//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class FolderFileApi {
  FolderFileApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Delete folder files based on ids
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] folderId (required):
  ///
  /// * [FolderFileDeleteFolderFilesPathRequest] folderFileDeleteFolderFilesPathRequest (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<Response> folderFileDeleteFolderFilesPathWithHttpInfo(int folderId, FolderFileDeleteFolderFilesPathRequest folderFileDeleteFolderFilesPathRequest, { String? acceptLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v2/folder-files/delete-files/{folderId}'
      .replaceAll('{folderId}', folderId.toString());

    // ignore: prefer_final_locals
    Object? postBody = folderFileDeleteFolderFilesPathRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (acceptLanguage != null) {
      headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    }

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Delete folder files based on ids
  ///
  /// Parameters:
  ///
  /// * [int] folderId (required):
  ///
  /// * [FolderFileDeleteFolderFilesPathRequest] folderFileDeleteFolderFilesPathRequest (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<void> folderFileDeleteFolderFilesPath(int folderId, FolderFileDeleteFolderFilesPathRequest folderFileDeleteFolderFilesPathRequest, { String? acceptLanguage, }) async {
    final response = await folderFileDeleteFolderFilesPathWithHttpInfo(folderId, folderFileDeleteFolderFilesPathRequest,  acceptLanguage: acceptLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Delete user's folder
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] folderId (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<Response> folderFileDeleteFolderPathWithHttpInfo(int folderId, { String? acceptLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v2/folder/delete-folder/{folderId}'
      .replaceAll('{folderId}', folderId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (acceptLanguage != null) {
      headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Delete user's folder
  ///
  /// Parameters:
  ///
  /// * [int] folderId (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<void> folderFileDeleteFolderPath(int folderId, { String? acceptLanguage, }) async {
    final response = await folderFileDeleteFolderPathWithHttpInfo(folderId,  acceptLanguage: acceptLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Display folder file
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] folderFileId (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<Response> folderFileDisplayOriginalPathWithHttpInfo(int folderFileId, { String? acceptLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v2/folder-file-display/folder-file-original/{folderFileId}'
      .replaceAll('{folderFileId}', folderFileId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (acceptLanguage != null) {
      headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Display folder file
  ///
  /// Parameters:
  ///
  /// * [int] folderFileId (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<void> folderFileDisplayOriginalPath(int folderFileId, { String? acceptLanguage, }) async {
    final response = await folderFileDisplayOriginalPathWithHttpInfo(folderFileId,  acceptLanguage: acceptLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Display folder file
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] folderFileId (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<Response> folderFileDisplayPathWithHttpInfo(int folderFileId, { String? acceptLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v2/folder-file-display/folder-file/{folderFileId}'
      .replaceAll('{folderFileId}', folderFileId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (acceptLanguage != null) {
      headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Display folder file
  ///
  /// Parameters:
  ///
  /// * [int] folderFileId (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<void> folderFileDisplayPath(int folderFileId, { String? acceptLanguage, }) async {
    final response = await folderFileDisplayPathWithHttpInfo(folderFileId,  acceptLanguage: acceptLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Display folder file
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] folderFileId (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<Response> folderFileDisplayThumbnailPathWithHttpInfo(int folderFileId, { String? acceptLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v2/folder-file-display/folder-file-thumbnail/{folderFileId}'
      .replaceAll('{folderFileId}', folderFileId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (acceptLanguage != null) {
      headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Display folder file
  ///
  /// Parameters:
  ///
  /// * [int] folderFileId (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<void> folderFileDisplayThumbnailPath(int folderFileId, { String? acceptLanguage, }) async {
    final response = await folderFileDisplayThumbnailPathWithHttpInfo(folderFileId,  acceptLanguage: acceptLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get folder files after date time
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] folderId (required):
  ///
  /// * [String] pivotDate (required):
  ///   in \"2020-01-21\" format or \"-\" to indicate current date
  ///
  /// * [int] microTimestamp (required):
  ///   In unix timestamp format with 6 decimal points (microseconds) precision for seconds, or \"-\"
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<Response> folderFileGetFolderFilesAfterMicroTimestampShotAtWithHttpInfo(int folderId, String pivotDate, int microTimestamp, { String? acceptLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v2/folder-files/get-folder-files-after-micro-timestamp/{folderId}/{pivotDate}/{microTimestamp}'
      .replaceAll('{folderId}', folderId.toString())
      .replaceAll('{pivotDate}', pivotDate)
      .replaceAll('{microTimestamp}', microTimestamp.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (acceptLanguage != null) {
      headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get folder files after date time
  ///
  /// Parameters:
  ///
  /// * [int] folderId (required):
  ///
  /// * [String] pivotDate (required):
  ///   in \"2020-01-21\" format or \"-\" to indicate current date
  ///
  /// * [int] microTimestamp (required):
  ///   In unix timestamp format with 6 decimal points (microseconds) precision for seconds, or \"-\"
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<void> folderFileGetFolderFilesAfterMicroTimestampShotAt(int folderId, String pivotDate, int microTimestamp, { String? acceptLanguage, }) async {
    final response = await folderFileGetFolderFilesAfterMicroTimestampShotAtWithHttpInfo(folderId, pivotDate, microTimestamp,  acceptLanguage: acceptLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get folder files before date time
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] folderId (required):
  ///
  /// * [String] pivotDate (required):
  ///   in \"2020-01-21\" format or \"-\" to indicate current date
  ///
  /// * [int] microTimestamp (required):
  ///   In unix timestamp format with 6 decimal points (microseconds) precision for seconds, or \"-\"
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<Response> folderFileGetFolderFilesBeforeMicroTimestampShotAtWithHttpInfo(int folderId, String pivotDate, int microTimestamp, { String? acceptLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v2/folder-files/get-folder-files-before-micro-timestamp/{folderId}/{pivotDate}/{microTimestamp}'
      .replaceAll('{folderId}', folderId.toString())
      .replaceAll('{pivotDate}', pivotDate)
      .replaceAll('{microTimestamp}', microTimestamp.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (acceptLanguage != null) {
      headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    }

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get folder files before date time
  ///
  /// Parameters:
  ///
  /// * [int] folderId (required):
  ///
  /// * [String] pivotDate (required):
  ///   in \"2020-01-21\" format or \"-\" to indicate current date
  ///
  /// * [int] microTimestamp (required):
  ///   In unix timestamp format with 6 decimal points (microseconds) precision for seconds, or \"-\"
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<void> folderFileGetFolderFilesBeforeMicroTimestampShotAt(int folderId, String pivotDate, int microTimestamp, { String? acceptLanguage, }) async {
    final response = await folderFileGetFolderFilesBeforeMicroTimestampShotAtWithHttpInfo(folderId, pivotDate, microTimestamp,  acceptLanguage: acceptLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Save folder
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] folderId (required):
  ///
  /// * [FolderFileSaveFolderPathRequest] folderFileSaveFolderPathRequest (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<Response> folderFileSaveFolderPathWithHttpInfo(int folderId, FolderFileSaveFolderPathRequest folderFileSaveFolderPathRequest, { String? acceptLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v2/folder/save-folder/{folderId}'
      .replaceAll('{folderId}', folderId.toString());

    // ignore: prefer_final_locals
    Object? postBody = folderFileSaveFolderPathRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (acceptLanguage != null) {
      headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    }

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Save folder
  ///
  /// Parameters:
  ///
  /// * [int] folderId (required):
  ///
  /// * [FolderFileSaveFolderPathRequest] folderFileSaveFolderPathRequest (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<void> folderFileSaveFolderPath(int folderId, FolderFileSaveFolderPathRequest folderFileSaveFolderPathRequest, { String? acceptLanguage, }) async {
    final response = await folderFileSaveFolderPathWithHttpInfo(folderId, folderFileSaveFolderPathRequest,  acceptLanguage: acceptLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Update multiple folder files
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [FolderFileUpdateMultipleFolderFilesPathRequest] folderFileUpdateMultipleFolderFilesPathRequest (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<Response> folderFileUpdateMultipleFolderFilesPathWithHttpInfo(FolderFileUpdateMultipleFolderFilesPathRequest folderFileUpdateMultipleFolderFilesPathRequest, { String? acceptLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v2/folder-files/update-multiple-folder-files';

    // ignore: prefer_final_locals
    Object? postBody = folderFileUpdateMultipleFolderFilesPathRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (acceptLanguage != null) {
      headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    }

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Update multiple folder files
  ///
  /// Parameters:
  ///
  /// * [FolderFileUpdateMultipleFolderFilesPathRequest] folderFileUpdateMultipleFolderFilesPathRequest (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<void> folderFileUpdateMultipleFolderFilesPath(FolderFileUpdateMultipleFolderFilesPathRequest folderFileUpdateMultipleFolderFilesPathRequest, { String? acceptLanguage, }) async {
    final response = await folderFileUpdateMultipleFolderFilesPathWithHttpInfo(folderFileUpdateMultipleFolderFilesPathRequest,  acceptLanguage: acceptLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Update one single folder file
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [FolderFileUpdateSingleFolderFilePathRequest] folderFileUpdateSingleFolderFilePathRequest (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<Response> folderFileUpdateSingleFolderFilePathWithHttpInfo(FolderFileUpdateSingleFolderFilePathRequest folderFileUpdateSingleFolderFilePathRequest, { String? acceptLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v2/folder-files/update-single-folder-file';

    // ignore: prefer_final_locals
    Object? postBody = folderFileUpdateSingleFolderFilePathRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (acceptLanguage != null) {
      headerParams[r'Accept-Language'] = parameterToString(acceptLanguage);
    }

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Update one single folder file
  ///
  /// Parameters:
  ///
  /// * [FolderFileUpdateSingleFolderFilePathRequest] folderFileUpdateSingleFolderFilePathRequest (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<void> folderFileUpdateSingleFolderFilePath(FolderFileUpdateSingleFolderFilePathRequest folderFileUpdateSingleFolderFilePathRequest, { String? acceptLanguage, }) async {
    final response = await folderFileUpdateSingleFolderFilePathWithHttpInfo(folderFileUpdateSingleFolderFilePathRequest,  acceptLanguage: acceptLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
