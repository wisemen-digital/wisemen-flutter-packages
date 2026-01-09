# openapi.api.APIStatusApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getApiInfo**](APIStatusApi.md#getapiinfo) | **GET** /api | 


# **getApiInfo**
> GetApiInfoResponse getApiInfo()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getAPIStatusApi();

try {
    final response = api.getApiInfo();
    print(response);
} on DioException catch (e) {
    print('Exception when calling APIStatusApi->getApiInfo: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**GetApiInfoResponse**](GetApiInfoResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

