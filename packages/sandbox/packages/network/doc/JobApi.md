# openapi.api.JobApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**viewJobDetailV1**](JobApi.md#viewjobdetailv1) | **GET** /api/v1/jobs/{jobId} | 
[**viewJobsIndexV1**](JobApi.md#viewjobsindexv1) | **GET** /api/v1/jobs | 


# **viewJobDetailV1**
> ViewJobDetailResponse viewJobDetailV1(jobId, isArchived)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getJobApi();
final String jobId = jobId_example; // String | 
final bool isArchived = true; // bool | 

try {
    final response = api.viewJobDetailV1(jobId, isArchived);
    print(response);
} on DioException catch (e) {
    print('Exception when calling JobApi->viewJobDetailV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **jobId** | **String**|  | 
 **isArchived** | **bool**|  | 

### Return type

[**ViewJobDetailResponse**](ViewJobDetailResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **viewJobsIndexV1**
> ViewJobsIndexResponse viewJobsIndexV1(sort, filter, pagination)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getJobApi();
final BuiltList<ViewJobsIndexSortQuery> sort = ; // BuiltList<ViewJobsIndexSortQuery> | 
final ViewJobsIndexFilterQuery filter = ; // ViewJobsIndexFilterQuery | 
final ViewJobsIndexPaginationQuery pagination = ; // ViewJobsIndexPaginationQuery | 

try {
    final response = api.viewJobsIndexV1(sort, filter, pagination);
    print(response);
} on DioException catch (e) {
    print('Exception when calling JobApi->viewJobsIndexV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sort** | [**BuiltList&lt;ViewJobsIndexSortQuery&gt;**](ViewJobsIndexSortQuery.md)|  | [optional] 
 **filter** | [**ViewJobsIndexFilterQuery**](.md)|  | [optional] 
 **pagination** | [**ViewJobsIndexPaginationQuery**](.md)|  | [optional] 

### Return type

[**ViewJobsIndexResponse**](ViewJobsIndexResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

