import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for FileApi
void main() {
  final instance = Openapi().getFileApi();

  group(FileApi, () {
    //Future confirmFileUploadV2(String file, ConfirmFileUploadCommand confirmFileUploadCommand) async
    test('test confirmFileUploadV2', () async {
      // TODO
    });

    //Future<CreateFileResponse> createFileV1(CreateFileCommand createFileCommand) async
    test('test createFileV1', () async {
      // TODO
    });

    //Future downloadFileV1(String file) async
    test('test downloadFileV1', () async {
      // TODO
    });
  });
}
