# openapi.api.ContactApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createContactV1**](ContactApi.md#createcontactv1) | **POST** /api/v1/contacts | 
[**deleteContactV1**](ContactApi.md#deletecontactv1) | **DELETE** /api/v1/contacts/{uuid} | 
[**updateContactV1**](ContactApi.md#updatecontactv1) | **PUT** /api/v1/contacts/{uuid} | 
[**viewContactDetailV1**](ContactApi.md#viewcontactdetailv1) | **GET** /api/v1/contacts/{uuid} | 
[**viewContactIndexV1**](ContactApi.md#viewcontactindexv1) | **GET** /api/v1/contacts | 


# **createContactV1**
> CreateContactResponse createContactV1(createContactCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getContactApi();
final CreateContactCommand createContactCommand = ; // CreateContactCommand | 

try {
    final response = api.createContactV1(createContactCommand);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ContactApi->createContactV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createContactCommand** | [**CreateContactCommand**](CreateContactCommand.md)|  | 

### Return type

[**CreateContactResponse**](CreateContactResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteContactV1**
> deleteContactV1(uuid)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getContactApi();
final String uuid = uuid_example; // String | 

try {
    api.deleteContactV1(uuid);
} on DioException catch (e) {
    print('Exception when calling ContactApi->deleteContactV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **uuid** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateContactV1**
> updateContactV1(uuid, updateContactCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getContactApi();
final String uuid = uuid_example; // String | 
final UpdateContactCommand updateContactCommand = ; // UpdateContactCommand | 

try {
    api.updateContactV1(uuid, updateContactCommand);
} on DioException catch (e) {
    print('Exception when calling ContactApi->updateContactV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **uuid** | **String**|  | 
 **updateContactCommand** | [**UpdateContactCommand**](UpdateContactCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **viewContactDetailV1**
> ViewContactDetailResponse viewContactDetailV1(uuid)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getContactApi();
final String uuid = uuid_example; // String | 

try {
    final response = api.viewContactDetailV1(uuid);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ContactApi->viewContactDetailV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **uuid** | **String**|  | 

### Return type

[**ViewContactDetailResponse**](ViewContactDetailResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **viewContactIndexV1**
> ViewContactIndexResponse viewContactIndexV1(pagination, sort, filter, search)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getContactApi();
final PaginatedOffsetQuery pagination = ; // PaginatedOffsetQuery | 
final BuiltList<ViewContactIndexSortQuery> sort = ; // BuiltList<ViewContactIndexSortQuery> | 
final ViewContactIndexFilterQuery filter = ; // ViewContactIndexFilterQuery | 
final String search = search_example; // String | 

try {
    final response = api.viewContactIndexV1(pagination, sort, filter, search);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ContactApi->viewContactIndexV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **pagination** | [**PaginatedOffsetQuery**](.md)|  | [optional] 
 **sort** | [**BuiltList&lt;ViewContactIndexSortQuery&gt;**](ViewContactIndexSortQuery.md)|  | [optional] 
 **filter** | [**ViewContactIndexFilterQuery**](.md)|  | [optional] 
 **search** | **String**|  | [optional] 

### Return type

[**ViewContactIndexResponse**](ViewContactIndexResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

