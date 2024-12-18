# openapi.api.AdminApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**adminAddUserPath**](AdminApi.md#adminadduserpath) | **POST** /api/v2/admin/add-user | Admin add user
[**adminDeleteUserPath**](AdminApi.md#admindeleteuserpath) | **POST** /api/v2/admin/delete-user/{uuid} | Admin delete user
[**adminListUsersPath**](AdminApi.md#adminlistuserspath) | **POST** /api/v2/admin/list-all-users/{afterId} | Admin list users
[**adminSaveUserPath**](AdminApi.md#adminsaveuserpath) | **POST** /api/v2/admin/update-user/{userId} | Admin save user


# **adminAddUserPath**
> adminAddUserPath(adminAddUserPathRequest, acceptLanguage)

Admin add user

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = AdminApi();
final adminAddUserPathRequest = AdminAddUserPathRequest(); // AdminAddUserPathRequest | 
final acceptLanguage = acceptLanguage_example; // String | Accepted language from client side

try {
    api_instance.adminAddUserPath(adminAddUserPathRequest, acceptLanguage);
} catch (e) {
    print('Exception when calling AdminApi->adminAddUserPath: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **adminAddUserPathRequest** | [**AdminAddUserPathRequest**](AdminAddUserPathRequest.md)|  | 
 **acceptLanguage** | **String**| Accepted language from client side | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminDeleteUserPath**
> adminDeleteUserPath(uuid, acceptLanguage)

Admin delete user

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = AdminApi();
final uuid = uuid_example; // String | 
final acceptLanguage = acceptLanguage_example; // String | Accepted language from client side

try {
    api_instance.adminDeleteUserPath(uuid, acceptLanguage);
} catch (e) {
    print('Exception when calling AdminApi->adminDeleteUserPath: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **uuid** | **String**|  | 
 **acceptLanguage** | **String**| Accepted language from client side | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminListUsersPath**
> adminListUsersPath(afterId, acceptLanguage)

Admin list users

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = AdminApi();
final afterId = 789; // int | 
final acceptLanguage = acceptLanguage_example; // String | Accepted language from client side

try {
    api_instance.adminListUsersPath(afterId, acceptLanguage);
} catch (e) {
    print('Exception when calling AdminApi->adminListUsersPath: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **afterId** | **int**|  | 
 **acceptLanguage** | **String**| Accepted language from client side | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminSaveUserPath**
> adminSaveUserPath(userId, adminSaveUserPathRequest, acceptLanguage)

Admin save user

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = AdminApi();
final userId = 789; // int | 
final adminSaveUserPathRequest = AdminSaveUserPathRequest(); // AdminSaveUserPathRequest | 
final acceptLanguage = acceptLanguage_example; // String | Accepted language from client side

try {
    api_instance.adminSaveUserPath(userId, adminSaveUserPathRequest, acceptLanguage);
} catch (e) {
    print('Exception when calling AdminApi->adminSaveUserPath: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **int**|  | 
 **adminSaveUserPathRequest** | [**AdminSaveUserPathRequest**](AdminSaveUserPathRequest.md)|  | 
 **acceptLanguage** | **String**| Accepted language from client side | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

