# openapi.api.UserApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**setUserRolesV1**](UserApi.md#setuserrolesv1) | **POST** /api/v1/users/{user}/role | 
[**viewMeV1**](UserApi.md#viewmev1) | **GET** /api/v1/users/me | 
[**viewUserDetailV1**](UserApi.md#viewuserdetailv1) | **GET** /api/v1/users/{uuid} | 
[**viewUserIndexV1**](UserApi.md#viewuserindexv1) | **GET** /api/v1/users | 


# **setUserRolesV1**
> setUserRolesV1(user, setUserRolesCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();
final String user = user_example; // String | 
final SetUserRolesCommand setUserRolesCommand = ; // SetUserRolesCommand | 

try {
    api.setUserRolesV1(user, setUserRolesCommand);
} on DioException catch (e) {
    print('Exception when calling UserApi->setUserRolesV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **user** | **String**|  | 
 **setUserRolesCommand** | [**SetUserRolesCommand**](SetUserRolesCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **viewMeV1**
> ViewMeResponse viewMeV1()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();

try {
    final response = api.viewMeV1();
    print(response);
} on DioException catch (e) {
    print('Exception when calling UserApi->viewMeV1: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ViewMeResponse**](ViewMeResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **viewUserDetailV1**
> ViewUserDetailResponse viewUserDetailV1(uuid)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();
final String uuid = uuid_example; // String | 

try {
    final response = api.viewUserDetailV1(uuid);
    print(response);
} on DioException catch (e) {
    print('Exception when calling UserApi->viewUserDetailV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **uuid** | **String**|  | 

### Return type

[**ViewUserDetailResponse**](ViewUserDetailResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **viewUserIndexV1**
> ViewUserIndexResponse viewUserIndexV1(pagination, search)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getUserApi();
final PaginatedOffsetQuery pagination = ; // PaginatedOffsetQuery | 
final String search = search_example; // String | 

try {
    final response = api.viewUserIndexV1(pagination, search);
    print(response);
} on DioException catch (e) {
    print('Exception when calling UserApi->viewUserIndexV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pagination** | [**PaginatedOffsetQuery**](.md)|  | [optional] 
 **search** | **String**|  | [optional] 

### Return type

[**ViewUserIndexResponse**](ViewUserIndexResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

