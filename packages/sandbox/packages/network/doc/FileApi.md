# openapi.api.FileApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**confirmFileUploadV2**](FileApi.md#confirmfileuploadv2) | **POST** /api/v2/files/{file}/confirm-upload | 
[**createFileV1**](FileApi.md#createfilev1) | **POST** /api/v1/files | 
[**downloadFileV1**](FileApi.md#downloadfilev1) | **POST** /api/v1/files/{file}/download | 


# **confirmFileUploadV2**
> confirmFileUploadV2(file, confirmFileUploadCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getFileApi();
final String file = file_example; // String | 
final ConfirmFileUploadCommand confirmFileUploadCommand = ; // ConfirmFileUploadCommand | 

try {
    api.confirmFileUploadV2(file, confirmFileUploadCommand);
} on DioException catch (e) {
    print('Exception when calling FileApi->confirmFileUploadV2: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **file** | **String**|  | 
 **confirmFileUploadCommand** | [**ConfirmFileUploadCommand**](ConfirmFileUploadCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createFileV1**
> CreateFileResponse createFileV1(createFileCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getFileApi();
final CreateFileCommand createFileCommand = ; // CreateFileCommand | 

try {
    final response = api.createFileV1(createFileCommand);
    print(response);
} on DioException catch (e) {
    print('Exception when calling FileApi->createFileV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createFileCommand** | [**CreateFileCommand**](CreateFileCommand.md)|  | 

### Return type

[**CreateFileResponse**](CreateFileResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **downloadFileV1**
> downloadFileV1(file)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getFileApi();
final String file = file_example; // String | 

try {
    api.downloadFileV1(file);
} on DioException catch (e) {
    print('Exception when calling FileApi->downloadFileV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **file** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

