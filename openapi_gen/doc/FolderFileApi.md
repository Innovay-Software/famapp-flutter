# openapi.api.FolderFileApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:8080*

Method | HTTP request | Description
------------- | ------------- | -------------
[**folderFileDeleteFolderFilesPath**](FolderFileApi.md#folderfiledeletefolderfilespath) | **POST** /api/v2/folder-files/delete-files/{folderId} | Delete folder files based on ids
[**folderFileDeleteFolderPath**](FolderFileApi.md#folderfiledeletefolderpath) | **POST** /api/v2/folder/delete-folder/{folderId} | Delete user's folder
[**folderFileDisplayOriginalPath**](FolderFileApi.md#folderfiledisplayoriginalpath) | **GET** /api/v2/folder-file-display/folder-file-original/{folderFileId} | Display folder file
[**folderFileDisplayPath**](FolderFileApi.md#folderfiledisplaypath) | **GET** /api/v2/folder-file-display/folder-file/{folderFileId} | Display folder file
[**folderFileDisplayThumbnailPath**](FolderFileApi.md#folderfiledisplaythumbnailpath) | **GET** /api/v2/folder-file-display/folder-file-thumbnail/{folderFileId} | Display folder file
[**folderFileGetFolderFilesAfterMicroTimestampShotAt**](FolderFileApi.md#folderfilegetfolderfilesaftermicrotimestampshotat) | **POST** /api/v2/folder-files/get-folder-files-after-micro-timestamp/{folderId}/{pivotDate}/{microTimestamp} | Get folder files after date time
[**folderFileGetFolderFilesBeforeMicroTimestampShotAt**](FolderFileApi.md#folderfilegetfolderfilesbeforemicrotimestampshotat) | **POST** /api/v2/folder-files/get-folder-files-before-micro-timestamp/{folderId}/{pivotDate}/{microTimestamp} | Get folder files before date time
[**folderFileSaveFolderPath**](FolderFileApi.md#folderfilesavefolderpath) | **POST** /api/v2/folder/save-folder/{folderId} | Save folder
[**folderFileUpdateMultipleFolderFilesPath**](FolderFileApi.md#folderfileupdatemultiplefolderfilespath) | **POST** /api/v2/folder-files/update-multiple-folder-files | Update multiple folder files
[**folderFileUpdateSingleFolderFilePath**](FolderFileApi.md#folderfileupdatesinglefolderfilepath) | **POST** /api/v2/folder-files/update-single-folder-file | Update one single folder file


# **folderFileDeleteFolderFilesPath**
> folderFileDeleteFolderFilesPath(folderId, folderFileDeleteFolderFilesPathRequest, acceptLanguage)

Delete folder files based on ids

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = FolderFileApi();
final folderId = 789; // int | 
final folderFileDeleteFolderFilesPathRequest = FolderFileDeleteFolderFilesPathRequest(); // FolderFileDeleteFolderFilesPathRequest | 
final acceptLanguage = acceptLanguage_example; // String | Accepted language from client side

try {
    api_instance.folderFileDeleteFolderFilesPath(folderId, folderFileDeleteFolderFilesPathRequest, acceptLanguage);
} catch (e) {
    print('Exception when calling FolderFileApi->folderFileDeleteFolderFilesPath: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **folderId** | **int**|  | 
 **folderFileDeleteFolderFilesPathRequest** | [**FolderFileDeleteFolderFilesPathRequest**](FolderFileDeleteFolderFilesPathRequest.md)|  | 
 **acceptLanguage** | **String**| Accepted language from client side | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **folderFileDeleteFolderPath**
> folderFileDeleteFolderPath(folderId, acceptLanguage)

Delete user's folder

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = FolderFileApi();
final folderId = 789; // int | 
final acceptLanguage = acceptLanguage_example; // String | Accepted language from client side

try {
    api_instance.folderFileDeleteFolderPath(folderId, acceptLanguage);
} catch (e) {
    print('Exception when calling FolderFileApi->folderFileDeleteFolderPath: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **folderId** | **int**|  | 
 **acceptLanguage** | **String**| Accepted language from client side | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **folderFileDisplayOriginalPath**
> folderFileDisplayOriginalPath(folderFileId, acceptLanguage)

Display folder file

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = FolderFileApi();
final folderFileId = 789; // int | 
final acceptLanguage = acceptLanguage_example; // String | Accepted language from client side

try {
    api_instance.folderFileDisplayOriginalPath(folderFileId, acceptLanguage);
} catch (e) {
    print('Exception when calling FolderFileApi->folderFileDisplayOriginalPath: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **folderFileId** | **int**|  | 
 **acceptLanguage** | **String**| Accepted language from client side | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **folderFileDisplayPath**
> folderFileDisplayPath(folderFileId, acceptLanguage)

Display folder file

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = FolderFileApi();
final folderFileId = 789; // int | 
final acceptLanguage = acceptLanguage_example; // String | Accepted language from client side

try {
    api_instance.folderFileDisplayPath(folderFileId, acceptLanguage);
} catch (e) {
    print('Exception when calling FolderFileApi->folderFileDisplayPath: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **folderFileId** | **int**|  | 
 **acceptLanguage** | **String**| Accepted language from client side | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **folderFileDisplayThumbnailPath**
> folderFileDisplayThumbnailPath(folderFileId, acceptLanguage)

Display folder file

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = FolderFileApi();
final folderFileId = 789; // int | 
final acceptLanguage = acceptLanguage_example; // String | Accepted language from client side

try {
    api_instance.folderFileDisplayThumbnailPath(folderFileId, acceptLanguage);
} catch (e) {
    print('Exception when calling FolderFileApi->folderFileDisplayThumbnailPath: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **folderFileId** | **int**|  | 
 **acceptLanguage** | **String**| Accepted language from client side | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **folderFileGetFolderFilesAfterMicroTimestampShotAt**
> folderFileGetFolderFilesAfterMicroTimestampShotAt(folderId, pivotDate, microTimestamp, acceptLanguage)

Get folder files after date time

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = FolderFileApi();
final folderId = 789; // int | 
final pivotDate = 2020-01-21; // String | in \"2020-01-21\" format or \"-\" to indicate current date
final microTimestamp = 1723122861000001; // int | In unix timestamp format with 6 decimal points (microseconds) precision for seconds, or \"-\"
final acceptLanguage = acceptLanguage_example; // String | Accepted language from client side

try {
    api_instance.folderFileGetFolderFilesAfterMicroTimestampShotAt(folderId, pivotDate, microTimestamp, acceptLanguage);
} catch (e) {
    print('Exception when calling FolderFileApi->folderFileGetFolderFilesAfterMicroTimestampShotAt: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **folderId** | **int**|  | 
 **pivotDate** | **String**| in \"2020-01-21\" format or \"-\" to indicate current date | 
 **microTimestamp** | **int**| In unix timestamp format with 6 decimal points (microseconds) precision for seconds, or \"-\" | 
 **acceptLanguage** | **String**| Accepted language from client side | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **folderFileGetFolderFilesBeforeMicroTimestampShotAt**
> folderFileGetFolderFilesBeforeMicroTimestampShotAt(folderId, pivotDate, microTimestamp, acceptLanguage)

Get folder files before date time

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = FolderFileApi();
final folderId = 789; // int | 
final pivotDate = 2020-01-21; // String | in \"2020-01-21\" format or \"-\" to indicate current date
final microTimestamp = 1723122861000001; // int | In unix timestamp format with 6 decimal points (microseconds) precision for seconds, or \"-\"
final acceptLanguage = acceptLanguage_example; // String | Accepted language from client side

try {
    api_instance.folderFileGetFolderFilesBeforeMicroTimestampShotAt(folderId, pivotDate, microTimestamp, acceptLanguage);
} catch (e) {
    print('Exception when calling FolderFileApi->folderFileGetFolderFilesBeforeMicroTimestampShotAt: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **folderId** | **int**|  | 
 **pivotDate** | **String**| in \"2020-01-21\" format or \"-\" to indicate current date | 
 **microTimestamp** | **int**| In unix timestamp format with 6 decimal points (microseconds) precision for seconds, or \"-\" | 
 **acceptLanguage** | **String**| Accepted language from client side | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **folderFileSaveFolderPath**
> folderFileSaveFolderPath(folderId, folderFileSaveFolderPathRequest, acceptLanguage)

Save folder

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = FolderFileApi();
final folderId = 789; // int | 
final folderFileSaveFolderPathRequest = FolderFileSaveFolderPathRequest(); // FolderFileSaveFolderPathRequest | 
final acceptLanguage = acceptLanguage_example; // String | Accepted language from client side

try {
    api_instance.folderFileSaveFolderPath(folderId, folderFileSaveFolderPathRequest, acceptLanguage);
} catch (e) {
    print('Exception when calling FolderFileApi->folderFileSaveFolderPath: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **folderId** | **int**|  | 
 **folderFileSaveFolderPathRequest** | [**FolderFileSaveFolderPathRequest**](FolderFileSaveFolderPathRequest.md)|  | 
 **acceptLanguage** | **String**| Accepted language from client side | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **folderFileUpdateMultipleFolderFilesPath**
> folderFileUpdateMultipleFolderFilesPath(folderFileUpdateMultipleFolderFilesPathRequest, acceptLanguage)

Update multiple folder files

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = FolderFileApi();
final folderFileUpdateMultipleFolderFilesPathRequest = FolderFileUpdateMultipleFolderFilesPathRequest(); // FolderFileUpdateMultipleFolderFilesPathRequest | 
final acceptLanguage = acceptLanguage_example; // String | Accepted language from client side

try {
    api_instance.folderFileUpdateMultipleFolderFilesPath(folderFileUpdateMultipleFolderFilesPathRequest, acceptLanguage);
} catch (e) {
    print('Exception when calling FolderFileApi->folderFileUpdateMultipleFolderFilesPath: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **folderFileUpdateMultipleFolderFilesPathRequest** | [**FolderFileUpdateMultipleFolderFilesPathRequest**](FolderFileUpdateMultipleFolderFilesPathRequest.md)|  | 
 **acceptLanguage** | **String**| Accepted language from client side | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **folderFileUpdateSingleFolderFilePath**
> folderFileUpdateSingleFolderFilePath(folderFileUpdateSingleFolderFilePathRequest, acceptLanguage)

Update one single folder file

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure HTTP Bearer authorization: bearerAuth
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('bearerAuth').setAccessToken(yourTokenGeneratorFunction);

final api_instance = FolderFileApi();
final folderFileUpdateSingleFolderFilePathRequest = FolderFileUpdateSingleFolderFilePathRequest(); // FolderFileUpdateSingleFolderFilePathRequest | 
final acceptLanguage = acceptLanguage_example; // String | Accepted language from client side

try {
    api_instance.folderFileUpdateSingleFolderFilePath(folderFileUpdateSingleFolderFilePathRequest, acceptLanguage);
} catch (e) {
    print('Exception when calling FolderFileApi->folderFileUpdateSingleFolderFilePath: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **folderFileUpdateSingleFolderFilePathRequest** | [**FolderFileUpdateSingleFolderFilePathRequest**](FolderFileUpdateSingleFolderFilePathRequest.md)|  | 
 **acceptLanguage** | **String**| Accepted language from client side | [optional] 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

