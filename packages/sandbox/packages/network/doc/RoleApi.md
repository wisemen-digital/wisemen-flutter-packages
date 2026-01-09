# openapi.api.RoleApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**clearRolePermissionsCacheV1**](RoleApi.md#clearrolepermissionscachev1) | **POST** /api/v1/roles/clear-cache | 
[**createRoleV1**](RoleApi.md#createrolev1) | **POST** /api/v1/roles | 
[**deleteRoleV1**](RoleApi.md#deleterolev1) | **DELETE** /api/v1/roles/{role} | 
[**updateRoleV1**](RoleApi.md#updaterolev1) | **POST** /api/v1/roles/{role} | 
[**updateRolesPermissionsV1**](RoleApi.md#updaterolespermissionsv1) | **PATCH** /api/v1/roles | 
[**viewRoleDetailV1**](RoleApi.md#viewroledetailv1) | **GET** /api/v1/roles/{role} | 
[**viewRoleIndexV1**](RoleApi.md#viewroleindexv1) | **GET** /api/v1/roles | 


# **clearRolePermissionsCacheV1**
> clearRolePermissionsCacheV1(clearRolePermissionsCacheCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getRoleApi();
final ClearRolePermissionsCacheCommand clearRolePermissionsCacheCommand = ; // ClearRolePermissionsCacheCommand | 

try {
    api.clearRolePermissionsCacheV1(clearRolePermissionsCacheCommand);
} on DioException catch (e) {
    print('Exception when calling RoleApi->clearRolePermissionsCacheV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **clearRolePermissionsCacheCommand** | [**ClearRolePermissionsCacheCommand**](ClearRolePermissionsCacheCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createRoleV1**
> CreateRoleResponse createRoleV1(createRoleCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getRoleApi();
final CreateRoleCommand createRoleCommand = ; // CreateRoleCommand | 

try {
    final response = api.createRoleV1(createRoleCommand);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RoleApi->createRoleV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createRoleCommand** | [**CreateRoleCommand**](CreateRoleCommand.md)|  | 

### Return type

[**CreateRoleResponse**](CreateRoleResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteRoleV1**
> deleteRoleV1(role)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getRoleApi();
final String role = role_example; // String | 

try {
    api.deleteRoleV1(role);
} on DioException catch (e) {
    print('Exception when calling RoleApi->deleteRoleV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **role** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateRoleV1**
> updateRoleV1(role, updateRoleCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getRoleApi();
final String role = role_example; // String | 
final UpdateRoleCommand updateRoleCommand = ; // UpdateRoleCommand | 

try {
    api.updateRoleV1(role, updateRoleCommand);
} on DioException catch (e) {
    print('Exception when calling RoleApi->updateRoleV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **role** | **String**|  | 
 **updateRoleCommand** | [**UpdateRoleCommand**](UpdateRoleCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateRolesPermissionsV1**
> updateRolesPermissionsV1(updateRolesPermissionsCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getRoleApi();
final UpdateRolesPermissionsCommand updateRolesPermissionsCommand = ; // UpdateRolesPermissionsCommand | 

try {
    api.updateRolesPermissionsV1(updateRolesPermissionsCommand);
} on DioException catch (e) {
    print('Exception when calling RoleApi->updateRolesPermissionsV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateRolesPermissionsCommand** | [**UpdateRolesPermissionsCommand**](UpdateRolesPermissionsCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **viewRoleDetailV1**
> ViewRoleDetailResponse viewRoleDetailV1(role)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getRoleApi();
final String role = role_example; // String | 

try {
    final response = api.viewRoleDetailV1(role);
    print(response);
} on DioException catch (e) {
    print('Exception when calling RoleApi->viewRoleDetailV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **role** | **String**|  | 

### Return type

[**ViewRoleDetailResponse**](ViewRoleDetailResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **viewRoleIndexV1**
> ViewRoleIndexResponse viewRoleIndexV1()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getRoleApi();

try {
    final response = api.viewRoleIndexV1();
    print(response);
} on DioException catch (e) {
    print('Exception when calling RoleApi->viewRoleIndexV1: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ViewRoleIndexResponse**](ViewRoleIndexResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

