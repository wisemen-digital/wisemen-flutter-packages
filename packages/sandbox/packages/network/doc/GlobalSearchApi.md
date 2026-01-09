# openapi.api.GlobalSearchApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**searchCollectionsV1**](GlobalSearchApi.md#searchcollectionsv1) | **GET** /api/v1/search | 


# **searchCollectionsV1**
> SearchCollectionsResponse searchCollectionsV1(filter, search)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getGlobalSearchApi();
final SearchCollectionsFilterQuery filter = ; // SearchCollectionsFilterQuery | 
final String search = search_example; // String | 

try {
    final response = api.searchCollectionsV1(filter, search);
    print(response);
} on DioException catch (e) {
    print('Exception when calling GlobalSearchApi->searchCollectionsV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **filter** | [**SearchCollectionsFilterQuery**](.md)|  | 
 **search** | **String**|  | 

### Return type

[**SearchCollectionsResponse**](SearchCollectionsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

