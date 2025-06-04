import 'package:flutter_test/flutter_test.dart';
import 'package:wisewidgetslibrary/src/models/pagination_meta.dart';

class TestPaginationMeta extends PaginationMeta<int> {
  const TestPaginationMeta({required super.next, required super.pageSize});

  @override
  factory TestPaginationMeta.fromJson(Map<String, dynamic> json) {
    return TestPaginationMeta(next: json['next'] as int, pageSize: appPageSize);
  }

  static const int appPageSize = 25;
  // ignore: prefer_constructors_over_static_methods
  static TestPaginationMeta get firstPage =>
      const TestPaginationMeta(next: 1, pageSize: appPageSize);
}

void main() {
  group('PaginationMeta', () {
    test('should throw UnimplementedError for fromJson', () {
      expect(
        TestPaginationMeta.fromJson({'next': 1}),
        isA<PaginationMeta<int>>(),
      );
    });

    test('should return correct values from implementation', () {
      const meta = TestPaginationMeta(next: 2, pageSize: 20);

      expect(meta.pageKey, 2);
      expect(meta.pageSize, 20);
      expect(meta.isLastPage, false);
    });

    test('should throw unimplemented if fromJson is not implemented', () {
      expect(
        () => PaginationMeta<int>.fromJson({'next': 1, 'pageSize': 20}),
        throwsUnimplementedError,
      );
    });
  });
}
