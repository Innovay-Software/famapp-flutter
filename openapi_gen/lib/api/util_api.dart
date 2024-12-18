//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class UtilApi {
  UtilApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Base64 encoded chunk upload
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UtilBase64ChunkUploadPathRequest] utilBase64ChunkUploadPathRequest (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<Response> utilBase64ChunkUploadPathWithHttpInfo(UtilBase64ChunkUploadPathRequest utilBase64ChunkUploadPathRequest, { String? acceptLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v2/util/base64-chunked-upload-file';

    // ignore: prefer_final_locals
    Object? postBody = utilBase64ChunkUploadPathRequest;

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

  /// Base64 encoded chunk upload
  ///
  /// Parameters:
  ///
  /// * [UtilBase64ChunkUploadPathRequest] utilBase64ChunkUploadPathRequest (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<void> utilBase64ChunkUploadPath(UtilBase64ChunkUploadPathRequest utilBase64ChunkUploadPathRequest, { String? acceptLanguage, }) async {
    final response = await utilBase64ChunkUploadPathWithHttpInfo(utilBase64ChunkUploadPathRequest,  acceptLanguage: acceptLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Check for update
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] clientOs (required):
  ///
  /// * [String] clientVersion (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<Response> utilCheckForMobileUpdatePathWithHttpInfo(String clientOs, String clientVersion, { String? acceptLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v2/util/check-for-mobile-update/{clientOs}/{clientVersion}'
      .replaceAll('{clientOs}', clientOs)
      .replaceAll('{clientVersion}', clientVersion);

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

  /// Check for update
  ///
  /// Parameters:
  ///
  /// * [String] clientOs (required):
  ///
  /// * [String] clientVersion (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<void> utilCheckForMobileUpdatePath(String clientOs, String clientVersion, { String? acceptLanguage, }) async {
    final response = await utilCheckForMobileUpdatePathWithHttpInfo(clientOs, clientVersion,  acceptLanguage: acceptLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get system config
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] configKey (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<Response> utilConfigPathWithHttpInfo(String configKey, { String? acceptLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v2/util/config/{configKey}'
      .replaceAll('{configKey}', configKey);

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

  /// Get system config
  ///
  /// Parameters:
  ///
  /// * [String] configKey (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<void> utilConfigPath(String configKey, { String? acceptLanguage, }) async {
    final response = await utilConfigPathWithHttpInfo(configKey,  acceptLanguage: acceptLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Display user avatar
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] userId (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<Response> utilDisplayUserAvatarPathWithHttpInfo(int userId, { String? acceptLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v2/util/user-avatar/{userId}'
      .replaceAll('{userId}', userId.toString());

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

  /// Display user avatar
  ///
  /// Parameters:
  ///
  /// * [int] userId (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<void> utilDisplayUserAvatarPath(int userId, { String? acceptLanguage, }) async {
    final response = await utilDisplayUserAvatarPathWithHttpInfo(userId,  acceptLanguage: acceptLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Ping for health
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<Response> utilPingPathWithHttpInfo({ String? acceptLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v2/util/ping';

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

  /// Ping for health
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<void> utilPingPath({ String? acceptLanguage, }) async {
    final response = await utilPingPathWithHttpInfo( acceptLanguage: acceptLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
