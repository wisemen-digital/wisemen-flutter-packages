# wise_scalars

A Flutter plugin that reads system settings and provides locale-aware formatting for scalars like dates, times, temperatures, and distances based on the user's device preferences.

## Features

- **System Settings Integration**: Automatically reads user preferences from device system settings
- **Date & Time Formatting**: Format dates and times according to user's locale preferences
- **Temperature Units**: Display temperatures in Celsius or Fahrenheit based on system settings
- **Distance Units**: Show distances in meters/kilometers or feet/miles according to user preferences
- **First Day of Week**: Respect the user's preferred first day of week setting
- **Reactive Updates**: Automatically refresh settings when the app resumes

## Installation

Add `wise_scalars` to your `pubspec.yaml`:

```yaml
dependencies:
  wise_scalars: ^1.0.0
```

## Usage

### Setup

Initialize the plugin and wrap your app with `WiseScalarScope`:

```dart
import 'package:flutter/material.dart';
import 'package:wise_scalars/wise_scalars.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final scalarOptions = await ScalarOptions.fromMethodChannel();

  runApp(MyApp(options: scalarOptions));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.options, super.key});

  final ScalarOptions options;

  @override
  Widget build(BuildContext context) {
    return WiseScalarScope(
      options: options,
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}
```

### Date & Time Formatting

Use the convenient extension methods on `DateTime`:

```dart
Text('Time: ${DateTime.now().time(context)}'),
Text('Date short: ${DateTime.now().short(context)}'),
Text('Date medium: ${DateTime.now().medium(context)}'),
Text('Date long: ${DateTime.now().long(context)}'),
Text('Date full: ${DateTime.now().full(context)}'),
```

### Temperature

Display temperatures with automatic unit conversion based on system settings:

```dart
const temperature = Temperature(
  value: 20,
  unit: TemperatureUnit.celsius,
);

Text('Temperature: ${temperature.label(context)}'),
// Displays "20°C" or "68°F" depending on system settings
```

### Distance

Show distances with appropriate units:

```dart
const distance = Distance(
  value: 100,
  unit: DistanceUnit.meters,
);

Text('Distance: ${distance.label(context)}'),
// Displays "100 m" or "328 ft" depending on system settings
```

### First Day of Week

Access the user's preferred first day of week:

```dart
final firstDayOfWeek = ScalarOptions.of(context).firstDayOfWeek ?? 1;
// Returns 1 for Monday, 7 for Sunday, etc.
```

## Platform Support

- ✅ Android
- ✅ iOS

## License

See the LICENSE file for details.
