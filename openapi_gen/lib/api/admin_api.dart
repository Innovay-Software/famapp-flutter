//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AdminApi {
  AdminApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Admin add user
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AdminAddUserPathRequest] adminAddUserPathRequest (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<Response> adminAddUserPathWithHttpInfo(AdminAddUserPathRequest adminAddUserPathRequest, { String? acceptLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v2/admin/add-user';

    // ignore: prefer_final_locals
    Object? postBody = adminAddUserPathRequest;

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

  /// Admin add user
  ///
  /// Parameters:
  ///
  /// * [AdminAddUserPathRequest] adminAddUserPathRequest (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<void> adminAddUserPath(AdminAddUserPathRequest adminAddUserPathRequest, { String? acceptLanguage, }) async {
    final response = await adminAddUserPathWithHttpInfo(adminAddUserPathRequest,  acceptLanguage: acceptLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Admin delete user
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] uuid (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<Response> adminDeleteUserPathWithHttpInfo(String uuid, { String? acceptLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v2/admin/delete-user/{uuid}'
      .replaceAll('{uuid}', uuid);

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

  /// Admin delete user
  ///
  /// Parameters:
  ///
  /// * [String] uuid (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<void> adminDeleteUserPath(String uuid, { String? acceptLanguage, }) async {
    final response = await adminDeleteUserPathWithHttpInfo(uuid,  acceptLanguage: acceptLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Admin list users
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] afterId (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<Response> adminListUsersPathWithHttpInfo(int afterId, { String? acceptLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v2/admin/list-all-users/{afterId}'
      .replaceAll('{afterId}', afterId.toString());

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

  /// Admin list users
  ///
  /// Parameters:
  ///
  /// * [int] afterId (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<void> adminListUsersPath(int afterId, { String? acceptLanguage, }) async {
    final response = await adminListUsersPathWithHttpInfo(afterId,  acceptLanguage: acceptLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Admin save user
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] userId (required):
  ///
  /// * [AdminSaveUserPathRequest] adminSaveUserPathRequest (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<Response> adminSaveUserPathWithHttpInfo(int userId, AdminSaveUserPathRequest adminSaveUserPathRequest, { String? acceptLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v2/admin/update-user/{userId}'
      .replaceAll('{userId}', userId.toString());

    // ignore: prefer_final_locals
    Object? postBody = adminSaveUserPathRequest;

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

  /// Admin save user
  ///
  /// Parameters:
  ///
  /// * [int] userId (required):
  ///
  /// * [AdminSaveUserPathRequest] adminSaveUserPathRequest (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<void> adminSaveUserPath(int userId, AdminSaveUserPathRequest adminSaveUserPathRequest, { String? acceptLanguage, }) async {
    final response = await adminSaveUserPathWithHttpInfo(userId, adminSaveUserPathRequest,  acceptLanguage: acceptLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
