# openapi.model.ViewJobDetailResponse

## Load the model package
```dart
import 'package:openapi/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**queueName** | [**QueueName**](QueueName.md) |  | 
**priority** | **num** |  | 
**name** | **String** |  | 
**data** | [**JsonObject**](.md) |  | 
**status** | [**JobStatus**](JobStatus.md) |  | 
**retryLimit** | **num** |  | 
**retryCount** | **num** |  | 
**retryDelay** | **num** |  | 
**retryBackoff** | **bool** |  | 
**startAfter** | [**DateTime**](DateTime.md) |  | 
**startedAt** | [**DateTime**](DateTime.md) |  | 
**singletonKey** | **String** |  | 
**singletonOn** | [**DateTime**](DateTime.md) |  | 
**expireIn** | [**JsonObject**](.md) |  | 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**completedAt** | [**DateTime**](DateTime.md) |  | 
**keepUntil** | [**DateTime**](DateTime.md) |  | 
**output** | [**JsonObject**](.md) |  | 
**deadLetter** | **String** |  | 
**policy** | **String** |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


