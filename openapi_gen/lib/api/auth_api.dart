//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AuthApi {
  AuthApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Refresh access token if it's about to expire
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AuthAccessTokenLoginPathRequest] authAccessTokenLoginPathRequest (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<Response> authAccessTokenLoginPathWithHttpInfo(AuthAccessTokenLoginPathRequest authAccessTokenLoginPathRequest, { String? acceptLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v2/auth/access-token-login';

    // ignore: prefer_final_locals
    Object? postBody = authAccessTokenLoginPathRequest;

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

  /// Refresh access token if it's about to expire
  ///
  /// Parameters:
  ///
  /// * [AuthAccessTokenLoginPathRequest] authAccessTokenLoginPathRequest (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<void> authAccessTokenLoginPath(AuthAccessTokenLoginPathRequest authAccessTokenLoginPathRequest, { String? acceptLanguage, }) async {
    final response = await authAccessTokenLoginPathWithHttpInfo(authAccessTokenLoginPathRequest,  acceptLanguage: acceptLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Mobile login using mobile number and password
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AuthMobileLoginPathRequest] authMobileLoginPathRequest (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<Response> authMobileLoginPathWithHttpInfo(AuthMobileLoginPathRequest authMobileLoginPathRequest, { String? acceptLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v2/auth/mobile-login';

    // ignore: prefer_final_locals
    Object? postBody = authMobileLoginPathRequest;

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

  /// Mobile login using mobile number and password
  ///
  /// Parameters:
  ///
  /// * [AuthMobileLoginPathRequest] authMobileLoginPathRequest (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<void> authMobileLoginPath(AuthMobileLoginPathRequest authMobileLoginPathRequest, { String? acceptLanguage, }) async {
    final response = await authMobileLoginPathWithHttpInfo(authMobileLoginPathRequest,  acceptLanguage: acceptLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
