import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for PreferenceApi
void main() {
  final instance = Openapi().getPreferenceApi();

  group(PreferenceApi, () {
    //Future updateUiPreferencesV1(UpdateUiPreferencesCommand updateUiPreferencesCommand) async
    test('test updateUiPreferencesV1', () async {
      // TODO
    });

    //Future<ViewUiPreferencesResponse> viewUiPreferencesV1() async
    test('test viewUiPreferencesV1', () async {
      // TODO
    });
  });
}
