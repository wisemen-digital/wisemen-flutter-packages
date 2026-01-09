# openapi.api.OneSignalApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createOneSignalTokenV1**](OneSignalApi.md#createonesignaltokenv1) | **POST** /api/v1/onesignal/token | 
[**sendPushNotificationV1**](OneSignalApi.md#sendpushnotificationv1) | **POST** /api/v1/onesignal/push-notification | 


# **createOneSignalTokenV1**
> CreateOneSignalTokenResponse createOneSignalTokenV1()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getOneSignalApi();

try {
    final response = api.createOneSignalTokenV1();
    print(response);
} on DioException catch (e) {
    print('Exception when calling OneSignalApi->createOneSignalTokenV1: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**CreateOneSignalTokenResponse**](CreateOneSignalTokenResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sendPushNotificationV1**
> sendPushNotificationV1(sendPushNotificationCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getOneSignalApi();
final SendPushNotificationCommand sendPushNotificationCommand = ; // SendPushNotificationCommand | 

try {
    api.sendPushNotificationV1(sendPushNotificationCommand);
} on DioException catch (e) {
    print('Exception when calling OneSignalApi->sendPushNotificationV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sendPushNotificationCommand** | [**SendPushNotificationCommand**](SendPushNotificationCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

