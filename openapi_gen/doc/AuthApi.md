# openapi.api.AuthApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authAccessTokenLoginPath**](AuthApi.md#authaccesstokenloginpath) | **POST** /api/v2/auth/access-token-login | Refresh access token if it's about to expire
[**authMobileLoginPath**](AuthApi.md#authmobileloginpath) | **POST** /api/v2/auth/mobile-login | Mobile login using mobile number and password


# **authAccessTokenLoginPath**
> authAccessTokenLoginPath(authAccessTokenLoginPathRequest, acceptLanguage)

Refresh access token if it's about to expire

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = AuthApi();
final authAccessTokenLoginPathRequest = AuthAccessTokenLoginPathRequest(); // AuthAccessTokenLoginPathRequest | 
final acceptLanguage = acceptLanguage_example; // String | Accepted language from client side

try {
    api_instance.authAccessTokenLoginPath(authAccessTokenLoginPathRequest, acceptLanguage);
} catch (e) {
    print('Exception when calling AuthApi->authAccessTokenLoginPath: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authAccessTokenLoginPathRequest** | [**AuthAccessTokenLoginPathRequest**](AuthAccessTokenLoginPathRequest.md)|  | 
 **acceptLanguage** | **String**| Accepted language from client side | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authMobileLoginPath**
> authMobileLoginPath(authMobileLoginPathRequest, acceptLanguage)

Mobile login using mobile number and password

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AuthApi();
final authMobileLoginPathRequest = AuthMobileLoginPathRequest(); // AuthMobileLoginPathRequest | 
final acceptLanguage = acceptLanguage_example; // String | Accepted language from client side

try {
    api_instance.authMobileLoginPath(authMobileLoginPathRequest, acceptLanguage);
} catch (e) {
    print('Exception when calling AuthApi->authMobileLoginPath: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authMobileLoginPathRequest** | [**AuthMobileLoginPathRequest**](AuthMobileLoginPathRequest.md)|  | 
 **acceptLanguage** | **String**| Accepted language from client side | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

