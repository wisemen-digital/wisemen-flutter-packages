# openapi.api.NotificationApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getMyNotificationsV1**](NotificationApi.md#getmynotificationsv1) | **GET** /api/v1/me/notifications | 
[**markAllNotificationAsReadV1**](NotificationApi.md#markallnotificationasreadv1) | **PATCH** /api/v1/me/notifications/mark-as-read | 
[**markNotificationAsReadV1**](NotificationApi.md#marknotificationasreadv1) | **PATCH** /api/v1/me/notifications/{notificationUuid}/mark-as-read | 
[**markNotificationAsUnreadV1**](NotificationApi.md#marknotificationasunreadv1) | **PATCH** /api/v1/me/notifications/{notificationUuid}/mark-as-unread | 
[**migrateNotificationTypesV1**](NotificationApi.md#migratenotificationtypesv1) | **POST** /api/v1/notifications/migrate | 
[**sendTestNotificationV1**](NotificationApi.md#sendtestnotificationv1) | **POST** /api/v1/notifications/test-notification | 
[**viewUnreadNotificationsCountV1**](NotificationApi.md#viewunreadnotificationscountv1) | **GET** /api/v1/me/notifications/unread-count | 
[**viewUserNotificationDetailV1**](NotificationApi.md#viewusernotificationdetailv1) | **GET** /api/v1/me/notifications/{notificationUuid} | 


# **getMyNotificationsV1**
> GetMyNotificationsResponse getMyNotificationsV1(filter, pagination)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getNotificationApi();
final GetMyNotificationsFilterQuery filter = ; // GetMyNotificationsFilterQuery | 
final GetMyNotificationsPaginationQuery pagination = ; // GetMyNotificationsPaginationQuery | 

try {
    final response = api.getMyNotificationsV1(filter, pagination);
    print(response);
} on DioException catch (e) {
    print('Exception when calling NotificationApi->getMyNotificationsV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **filter** | [**GetMyNotificationsFilterQuery**](.md)|  | [optional] 
 **pagination** | [**GetMyNotificationsPaginationQuery**](.md)|  | [optional] 

### Return type

[**GetMyNotificationsResponse**](GetMyNotificationsResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **markAllNotificationAsReadV1**
> markAllNotificationAsReadV1()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getNotificationApi();

try {
    api.markAllNotificationAsReadV1();
} on DioException catch (e) {
    print('Exception when calling NotificationApi->markAllNotificationAsReadV1: $e\n');
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

# **markNotificationAsReadV1**
> markNotificationAsReadV1(notificationUuid)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getNotificationApi();
final String notificationUuid = notificationUuid_example; // String | 

try {
    api.markNotificationAsReadV1(notificationUuid);
} on DioException catch (e) {
    print('Exception when calling NotificationApi->markNotificationAsReadV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **notificationUuid** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **markNotificationAsUnreadV1**
> markNotificationAsUnreadV1(notificationUuid)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getNotificationApi();
final String notificationUuid = notificationUuid_example; // String | 

try {
    api.markNotificationAsUnreadV1(notificationUuid);
} on DioException catch (e) {
    print('Exception when calling NotificationApi->markNotificationAsUnreadV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **notificationUuid** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **migrateNotificationTypesV1**
> migrateNotificationTypesV1(migrateNotificationTypesCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getNotificationApi();
final MigrateNotificationTypesCommand migrateNotificationTypesCommand = ; // MigrateNotificationTypesCommand | 

try {
    api.migrateNotificationTypesV1(migrateNotificationTypesCommand);
} on DioException catch (e) {
    print('Exception when calling NotificationApi->migrateNotificationTypesV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **migrateNotificationTypesCommand** | [**MigrateNotificationTypesCommand**](MigrateNotificationTypesCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sendTestNotificationV1**
> sendTestNotificationV1(sendTestNotificationCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getNotificationApi();
final SendTestNotificationCommand sendTestNotificationCommand = ; // SendTestNotificationCommand | 

try {
    api.sendTestNotificationV1(sendTestNotificationCommand);
} on DioException catch (e) {
    print('Exception when calling NotificationApi->sendTestNotificationV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sendTestNotificationCommand** | [**SendTestNotificationCommand**](SendTestNotificationCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **viewUnreadNotificationsCountV1**
> ViewUnreadNotificationsCountResponse viewUnreadNotificationsCountV1()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getNotificationApi();

try {
    final response = api.viewUnreadNotificationsCountV1();
    print(response);
} on DioException catch (e) {
    print('Exception when calling NotificationApi->viewUnreadNotificationsCountV1: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ViewUnreadNotificationsCountResponse**](ViewUnreadNotificationsCountResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **viewUserNotificationDetailV1**
> SystemTestNotificationNotification viewUserNotificationDetailV1(notificationUuid)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getNotificationApi();
final String notificationUuid = notificationUuid_example; // String | 

try {
    final response = api.viewUserNotificationDetailV1(notificationUuid);
    print(response);
} on DioException catch (e) {
    print('Exception when calling NotificationApi->viewUserNotificationDetailV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **notificationUuid** | **String**|  | 

### Return type

[**SystemTestNotificationNotification**](SystemTestNotificationNotification.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

