import 'package:test/test.dart';
import 'package:openapi/openapi.dart';

/// tests for JobApi
void main() {
  final instance = Openapi().getJobApi();

  group(JobApi, () {
    //Future<ViewJobDetailResponse> viewJobDetailV1(String jobId, bool isArchived) async
    test('test viewJobDetailV1', () async {
      // TODO
    });

    //Future<ViewJobsIndexResponse> viewJobsIndexV1({ BuiltList<ViewJobsIndexSortQuery> sort, ViewJobsIndexFilterQuery filter, ViewJobsIndexPaginationQuery pagination }) async
    test('test viewJobsIndexV1', () async {
      // TODO
    });
  });
}
