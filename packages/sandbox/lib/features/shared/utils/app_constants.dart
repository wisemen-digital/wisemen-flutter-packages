import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';

class AppConstants {
  static const fakerMode = kDebugMode;
  static final faker = Faker();
  static String getSimpleStringId() {
    return Random().nextInt(5).toString();
  }
}
