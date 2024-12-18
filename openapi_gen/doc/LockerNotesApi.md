# openapi.api.LockerNotesApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**lockerNoteDeletePath**](LockerNotesApi.md#lockernotedeletepath) | **POST** /api/v2/locker-notes/delete-note/{noteId} | Delete user's locker note
[**lockerNoteListPath**](LockerNotesApi.md#lockernotelistpath) | **POST** /api/v2/locker-notes/list-notes | List user's locker notes
[**lockerNoteSavePath**](LockerNotesApi.md#lockernotesavepath) | **POST** /api/v2/locker-notes/save-note/{noteId} | Save user's locker note


# **lockerNoteDeletePath**
> lockerNoteDeletePath(noteId, acceptLanguage)

Delete user's locker note

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = LockerNotesApi();
final noteId = 789; // int | 
final acceptLanguage = acceptLanguage_example; // String | Accepted language from client side

try {
    api_instance.lockerNoteDeletePath(noteId, acceptLanguage);
} catch (e) {
    print('Exception when calling LockerNotesApi->lockerNoteDeletePath: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **noteId** | **int**|  | 
 **acceptLanguage** | **String**| Accepted language from client side | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lockerNoteListPath**
> lockerNoteListPath(acceptLanguage)

List user's locker notes

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = LockerNotesApi();
final acceptLanguage = acceptLanguage_example; // String | Accepted language from client side

try {
    api_instance.lockerNoteListPath(acceptLanguage);
} catch (e) {
    print('Exception when calling LockerNotesApi->lockerNoteListPath: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **acceptLanguage** | **String**| Accepted language from client side | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **lockerNoteSavePath**
> lockerNoteSavePath(noteId, lockerNoteSavePathRequest, acceptLanguage)

Save user's locker note

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = LockerNotesApi();
final noteId = 789; // int | 
final lockerNoteSavePathRequest = LockerNoteSavePathRequest(); // LockerNoteSavePathRequest | 
final acceptLanguage = acceptLanguage_example; // String | Accepted language from client side

try {
    api_instance.lockerNoteSavePath(noteId, lockerNoteSavePathRequest, acceptLanguage);
} catch (e) {
    print('Exception when calling LockerNotesApi->lockerNoteSavePath: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **noteId** | **int**|  | 
 **lockerNoteSavePathRequest** | [**LockerNoteSavePathRequest**](LockerNoteSavePathRequest.md)|  | 
 **acceptLanguage** | **String**| Accepted language from client side | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

