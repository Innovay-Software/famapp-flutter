# openapi.api.UtilApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**utilBase64ChunkUploadPath**](UtilApi.md#utilbase64chunkuploadpath) | **POST** /api/v2/util/base64-chunked-upload-file | Base64 encoded chunk upload
[**utilCheckForMobileUpdatePath**](UtilApi.md#utilcheckformobileupdatepath) | **GET** /api/v2/util/check-for-mobile-update/{clientOs}/{clientVersion} | Check for update
[**utilConfigPath**](UtilApi.md#utilconfigpath) | **POST** /api/v2/util/config/{configKey} | Get system config
[**utilDisplayUserAvatarPath**](UtilApi.md#utildisplayuseravatarpath) | **GET** /api/v2/util/user-avatar/{userId} | Display user avatar
[**utilPingPath**](UtilApi.md#utilpingpath) | **GET** /api/v2/util/ping | Ping for health


# **utilBase64ChunkUploadPath**
> utilBase64ChunkUploadPath(utilBase64ChunkUploadPathRequest, acceptLanguage)

Base64 encoded chunk upload

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = UtilApi();
final utilBase64ChunkUploadPathRequest = UtilBase64ChunkUploadPathRequest(); // UtilBase64ChunkUploadPathRequest | 
final acceptLanguage = acceptLanguage_example; // String | Accepted language from client side

try {
    api_instance.utilBase64ChunkUploadPath(utilBase64ChunkUploadPathRequest, acceptLanguage);
} catch (e) {
    print('Exception when calling UtilApi->utilBase64ChunkUploadPath: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **utilBase64ChunkUploadPathRequest** | [**UtilBase64ChunkUploadPathRequest**](UtilBase64ChunkUploadPathRequest.md)|  | 
 **acceptLanguage** | **String**| Accepted language from client side | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **utilCheckForMobileUpdatePath**
> utilCheckForMobileUpdatePath(clientOs, clientVersion, acceptLanguage)

Check for update

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = UtilApi();
final clientOs = clientOs_example; // String | 
final clientVersion = clientVersion_example; // String | 
final acceptLanguage = acceptLanguage_example; // String | Accepted language from client side

try {
    api_instance.utilCheckForMobileUpdatePath(clientOs, clientVersion, acceptLanguage);
} catch (e) {
    print('Exception when calling UtilApi->utilCheckForMobileUpdatePath: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **clientOs** | **String**|  | 
 **clientVersion** | **String**|  | 
 **acceptLanguage** | **String**| Accepted language from client side | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **utilConfigPath**
> utilConfigPath(configKey, acceptLanguage)

Get system config

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = UtilApi();
final configKey = configKey_example; // String | 
final acceptLanguage = acceptLanguage_example; // String | Accepted language from client side

try {
    api_instance.utilConfigPath(configKey, acceptLanguage);
} catch (e) {
    print('Exception when calling UtilApi->utilConfigPath: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **configKey** | **String**|  | 
 **acceptLanguage** | **String**| Accepted language from client side | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **utilDisplayUserAvatarPath**
> utilDisplayUserAvatarPath(userId, acceptLanguage)

Display user avatar

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = UtilApi();
final userId = 789; // int | 
final acceptLanguage = acceptLanguage_example; // String | Accepted language from client side

try {
    api_instance.utilDisplayUserAvatarPath(userId, acceptLanguage);
} catch (e) {
    print('Exception when calling UtilApi->utilDisplayUserAvatarPath: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **int**|  | 
 **acceptLanguage** | **String**| Accepted language from client side | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **utilPingPath**
> utilPingPath(acceptLanguage)

Ping for health

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = UtilApi();
final acceptLanguage = acceptLanguage_example; // String | Accepted language from client side

try {
    api_instance.utilPingPath(acceptLanguage);
} catch (e) {
    print('Exception when calling UtilApi->utilPingPath: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **acceptLanguage** | **String**| Accepted language from client side | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

