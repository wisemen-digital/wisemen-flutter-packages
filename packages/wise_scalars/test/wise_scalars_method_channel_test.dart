import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_scalars/platform/wise_scalars_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final platform = MethodChannelWiseScalars();
  const channel = MethodChannel('wise_scalars');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getTemperatureUnit', () async {
    expect(await platform.getTemperatureUnit(), '42');
  });
}
