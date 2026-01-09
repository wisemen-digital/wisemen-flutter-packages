import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for EventLogApi
void main() {
  final instance = Openapi().getEventLogApi();

  group(EventLogApi, () {
    //Future<ViewDomainEventLogIndexResponse> viewDomainEventLogIndexV1({ ViewDomainEventLogIndexFilterQuery filter, ViewDomainEventLogIndexPaginationQuery pagination }) async
    test('test viewDomainEventLogIndexV1', () async {
      // TODO
    });
  });
}
