# openapi.api.PreferenceApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**updateUiPreferencesV1**](PreferenceApi.md#updateuipreferencesv1) | **PATCH** /api/v1/me/ui-preferences | 
[**viewUiPreferencesV1**](PreferenceApi.md#viewuipreferencesv1) | **GET** /api/v1/me/ui-preferences | 


# **updateUiPreferencesV1**
> updateUiPreferencesV1(updateUiPreferencesCommand)



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPreferenceApi();
final UpdateUiPreferencesCommand updateUiPreferencesCommand = ; // UpdateUiPreferencesCommand | 

try {
    api.updateUiPreferencesV1(updateUiPreferencesCommand);
} on DioException catch (e) {
    print('Exception when calling PreferenceApi->updateUiPreferencesV1: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateUiPreferencesCommand** | [**UpdateUiPreferencesCommand**](UpdateUiPreferencesCommand.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **viewUiPreferencesV1**
> ViewUiPreferencesResponse viewUiPreferencesV1()



### Example
```dart
import 'package:openapi/api.dart';

final api = Openapi().getPreferenceApi();

try {
    final response = api.viewUiPreferencesV1();
    print(response);
} on DioException catch (e) {
    print('Exception when calling PreferenceApi->viewUiPreferencesV1: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ViewUiPreferencesResponse**](ViewUiPreferencesResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

