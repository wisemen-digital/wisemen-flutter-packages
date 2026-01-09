# openapi.api.TypesenseApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**importCollectionsV1**](TypesenseApi.md#importcollectionsv1) | **GET** /api/v1/typesense/import | 
[**migrateCollectionsV1**](TypesenseApi.md#migratecollectionsv1) | **GET** /api/v1/typesense/migrate | 
[**viewCollectionIndexV1**](TypesenseApi.md#viewcollectionindexv1) | **GET** /api/v1/typesense/collections | 
[**viewCollectionsV1**](TypesenseApi.md#viewcollectionsv1) | **GET** /api/v1/typesense/collections/details | 


# **importCollectionsV1**
> importCollectionsV1(collections)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getTypesenseApi();
final BuiltList<TypesenseCollectionName> collections = ; // BuiltList<TypesenseCollectionName> | 

try {
    api.importCollectionsV1(collections);
} on DioException catch (e) {
    print('Exception when calling TypesenseApi->importCollectionsV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **collections** | [**BuiltList&lt;TypesenseCollectionName&gt;**](TypesenseCollectionName.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **migrateCollectionsV1**
> migrateCollectionsV1(fresh, collections)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getTypesenseApi();
final bool fresh = true; // bool | 
final BuiltList<TypesenseCollectionName> collections = ; // BuiltList<TypesenseCollectionName> | 

try {
    api.migrateCollectionsV1(fresh, collections);
} on DioException catch (e) {
    print('Exception when calling TypesenseApi->migrateCollectionsV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **fresh** | **bool**|  | 
 **collections** | [**BuiltList&lt;TypesenseCollectionName&gt;**](TypesenseCollectionName.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **viewCollectionIndexV1**
> ViewCollectionIndexResponse viewCollectionIndexV1()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getTypesenseApi();

try {
    final response = api.viewCollectionIndexV1();
    print(response);
} on DioException catch (e) {
    print('Exception when calling TypesenseApi->viewCollectionIndexV1: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ViewCollectionIndexResponse**](ViewCollectionIndexResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **viewCollectionsV1**
> viewCollectionsV1()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getTypesenseApi();

try {
    api.viewCollectionsV1();
} on DioException catch (e) {
    print('Exception when calling TypesenseApi->viewCollectionsV1: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

