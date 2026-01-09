# openapi.api.NotificationPreferenceApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getMyNotificationPreferencesV1**](NotificationPreferenceApi.md#getmynotificationpreferencesv1) | **GET** /api/v1/me/notification-preferences | 
[**getNotificationTypesConfigV1**](NotificationPreferenceApi.md#getnotificationtypesconfigv1) | **GET** /api/v1/notification-preferences/config | 
[**updateMyChannelNotificationPreferenceV1**](NotificationPreferenceApi.md#updatemychannelnotificationpreferencev1) | **PATCH** /api/v1/me/notification-preferences/channels | 
[**updateMyNotificationPreferencePresetV1**](NotificationPreferenceApi.md#updatemynotificationpreferencepresetv1) | **PATCH** /api/v1/me/notification-preferences/preset | 
[**updateMyNotificationTypePreferenceV1**](NotificationPreferenceApi.md#updatemynotificationtypepreferencev1) | **PATCH** /api/v1/me/notification-preferences/types | 


# **getMyNotificationPreferencesV1**
> GetMyNotificationPreferencesResponse getMyNotificationPreferencesV1()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getNotificationPreferenceApi();

try {
    final response = api.getMyNotificationPreferencesV1();
    print(response);
} on DioException catch (e) {
    print('Exception when calling NotificationPreferenceApi->getMyNotificationPreferencesV1: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**GetMyNotificationPreferencesResponse**](GetMyNotificationPreferencesResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getNotificationTypesConfigV1**
> GetNotificationTypesConfigResponse getNotificationTypesConfigV1()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getNotificationPreferenceApi();

try {
    final response = api.getNotificationTypesConfigV1();
    print(response);
} on DioException catch (e) {
    print('Exception when calling NotificationPreferenceApi->getNotificationTypesConfigV1: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**GetNotificationTypesConfigResponse**](GetNotificationTypesConfigResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateMyChannelNotificationPreferenceV1**
> updateMyChannelNotificationPreferenceV1(updateMyChannelNotificationPreferenceCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getNotificationPreferenceApi();
final UpdateMyChannelNotificationPreferenceCommand updateMyChannelNotificationPreferenceCommand = ; // UpdateMyChannelNotificationPreferenceCommand | 

try {
    api.updateMyChannelNotificationPreferenceV1(updateMyChannelNotificationPreferenceCommand);
} on DioException catch (e) {
    print('Exception when calling NotificationPreferenceApi->updateMyChannelNotificationPreferenceV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateMyChannelNotificationPreferenceCommand** | [**UpdateMyChannelNotificationPreferenceCommand**](UpdateMyChannelNotificationPreferenceCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateMyNotificationPreferencePresetV1**
> updateMyNotificationPreferencePresetV1(updateMyNotificationPreferencePresetCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getNotificationPreferenceApi();
final UpdateMyNotificationPreferencePresetCommand updateMyNotificationPreferencePresetCommand = ; // UpdateMyNotificationPreferencePresetCommand | 

try {
    api.updateMyNotificationPreferencePresetV1(updateMyNotificationPreferencePresetCommand);
} on DioException catch (e) {
    print('Exception when calling NotificationPreferenceApi->updateMyNotificationPreferencePresetV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateMyNotificationPreferencePresetCommand** | [**UpdateMyNotificationPreferencePresetCommand**](UpdateMyNotificationPreferencePresetCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateMyNotificationTypePreferenceV1**
> updateMyNotificationTypePreferenceV1(updateMyNotificationTypePreferenceCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getNotificationPreferenceApi();
final UpdateMyNotificationTypePreferenceCommand updateMyNotificationTypePreferenceCommand = ; // UpdateMyNotificationTypePreferenceCommand | 

try {
    api.updateMyNotificationTypePreferenceV1(updateMyNotificationTypePreferenceCommand);
} on DioException catch (e) {
    print('Exception when calling NotificationPreferenceApi->updateMyNotificationTypePreferenceV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateMyNotificationTypePreferenceCommand** | [**UpdateMyNotificationTypePreferenceCommand**](UpdateMyNotificationTypePreferenceCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

