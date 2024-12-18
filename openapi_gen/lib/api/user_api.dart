//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class UserApi {
  UserApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Update user's profile
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UserUpdateProfilePathRequest] userUpdateProfilePathRequest (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<Response> userUpdateProfilePathWithHttpInfo(UserUpdateProfilePathRequest userUpdateProfilePathRequest, { String? acceptLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v2/user/update-profile';

    // ignore: prefer_final_locals
    Object? postBody = userUpdateProfilePathRequest;

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

  /// Update user's profile
  ///
  /// Parameters:
  ///
  /// * [UserUpdateProfilePathRequest] userUpdateProfilePathRequest (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<void> userUpdateProfilePath(UserUpdateProfilePathRequest userUpdateProfilePathRequest, { String? acceptLanguage, }) async {
    final response = await userUpdateProfilePathWithHttpInfo(userUpdateProfilePathRequest,  acceptLanguage: acceptLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
