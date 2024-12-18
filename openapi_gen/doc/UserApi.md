# openapi.api.UserApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**userUpdateProfilePath**](UserApi.md#userupdateprofilepath) | **POST** /api/v2/user/update-profile | Update user's profile


# **userUpdateProfilePath**
> userUpdateProfilePath(userUpdateProfilePathRequest, acceptLanguage)

Update user's profile

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = UserApi();
final userUpdateProfilePathRequest = UserUpdateProfilePathRequest(); // UserUpdateProfilePathRequest | 
final acceptLanguage = acceptLanguage_example; // String | Accepted language from client side

try {
    api_instance.userUpdateProfilePath(userUpdateProfilePathRequest, acceptLanguage);
} catch (e) {
    print('Exception when calling UserApi->userUpdateProfilePath: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userUpdateProfilePathRequest** | [**UserUpdateProfilePathRequest**](UserUpdateProfilePathRequest.md)|  | 
 **acceptLanguage** | **String**| Accepted language from client side | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

