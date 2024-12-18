//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class LockerNotesApi {
  LockerNotesApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Delete user's locker note
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] noteId (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<Response> lockerNoteDeletePathWithHttpInfo(int noteId, { String? acceptLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v2/locker-notes/delete-note/{noteId}'
      .replaceAll('{noteId}', noteId.toString());

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

  /// Delete user's locker note
  ///
  /// Parameters:
  ///
  /// * [int] noteId (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<void> lockerNoteDeletePath(int noteId, { String? acceptLanguage, }) async {
    final response = await lockerNoteDeletePathWithHttpInfo(noteId,  acceptLanguage: acceptLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// List user's locker notes
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<Response> lockerNoteListPathWithHttpInfo({ String? acceptLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v2/locker-notes/list-notes';

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

  /// List user's locker notes
  ///
  /// Parameters:
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<void> lockerNoteListPath({ String? acceptLanguage, }) async {
    final response = await lockerNoteListPathWithHttpInfo( acceptLanguage: acceptLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Save user's locker note
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] noteId (required):
  ///
  /// * [LockerNoteSavePathRequest] lockerNoteSavePathRequest (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<Response> lockerNoteSavePathWithHttpInfo(int noteId, LockerNoteSavePathRequest lockerNoteSavePathRequest, { String? acceptLanguage, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v2/locker-notes/save-note/{noteId}'
      .replaceAll('{noteId}', noteId.toString());

    // ignore: prefer_final_locals
    Object? postBody = lockerNoteSavePathRequest;

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

  /// Save user's locker note
  ///
  /// Parameters:
  ///
  /// * [int] noteId (required):
  ///
  /// * [LockerNoteSavePathRequest] lockerNoteSavePathRequest (required):
  ///
  /// * [String] acceptLanguage:
  ///   Accepted language from client side
  Future<void> lockerNoteSavePath(int noteId, LockerNoteSavePathRequest lockerNoteSavePathRequest, { String? acceptLanguage, }) async {
    final response = await lockerNoteSavePathWithHttpInfo(noteId, lockerNoteSavePathRequest,  acceptLanguage: acceptLanguage, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
