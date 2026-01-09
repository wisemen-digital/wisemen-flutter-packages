# openapi.api.EventLogApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**viewDomainEventLogIndexV1**](EventLogApi.md#viewdomaineventlogindexv1) | **GET** /api/v1/event-logs | 


# **viewDomainEventLogIndexV1**
> ViewDomainEventLogIndexResponse viewDomainEventLogIndexV1(filter, pagination)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getEventLogApi();
final ViewDomainEventLogIndexFilterQuery filter = ; // ViewDomainEventLogIndexFilterQuery | 
final ViewDomainEventLogIndexPaginationQuery pagination = ; // ViewDomainEventLogIndexPaginationQuery | 

try {
    final response = api.viewDomainEventLogIndexV1(filter, pagination);
    print(response);
} on DioException catch (e) {
    print('Exception when calling EventLogApi->viewDomainEventLogIndexV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **filter** | [**ViewDomainEventLogIndexFilterQuery**](.md)|  | [optional] 
 **pagination** | [**ViewDomainEventLogIndexPaginationQuery**](.md)|  | [optional] 

### Return type

[**ViewDomainEventLogIndexResponse**](ViewDomainEventLogIndexResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

