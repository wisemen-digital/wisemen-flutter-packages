# openapi.api.PermissionApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**viewPermissionIndexV1**](PermissionApi.md#viewpermissionindexv1) | **GET** /api/v1/permissions | 


# **viewPermissionIndexV1**
> ViewPermissionIndexResponse viewPermissionIndexV1()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPermissionApi();

try {
    final response = api.viewPermissionIndexV1();
    print(response);
} on DioException catch (e) {
    print('Exception when calling PermissionApi->viewPermissionIndexV1: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ViewPermissionIndexResponse**](ViewPermissionIndexResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

