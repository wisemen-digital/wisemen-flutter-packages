# Database to feature mappers

In this folder we map drift database objects to feature models.

# Steps

1. Find the folder or file that fits the use case.
    * File names should be '{model_name}_mapper.dart'
    * Folder names should be {feature_name}

2. Create an extension on the table object model with a function that returns the given feature model.
    * The table object can be found in 'file_name.drift.dart'
    * Make logical connections that match column names to feature fields
    * For text columns that convert json data
      * Create a new mapper that maps this model to the matching one in the feature
      * This new mapper should extend the converted model's type
    * Import necessary packages and files

3. Document the functions and extensions (dart docs: ///) for implementations that weren't clear and obvious.

4. Add newly created files/folders to existing barrel files

# Example: mapper

```dart
import 'package:database/database.dart';
import 'package:sandbox/features/settings/models/models.dart';

extension UserMapper on UserObject {
  User toFeature() {
    return User(
      firstName: firstName,
      lastName: lastName,
      email: email,
    );
  }
}
```
