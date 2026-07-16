import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wise_nav_bar/wise_nav_bar.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

/// Demo screen for [BiDirectionalPagedList]: a calendar-style list of days
/// that opens on today and pages further into the past (scroll up) or the
/// future (scroll down). Backed by fake in-memory data with a simulated
@RoutePage()
class BiDirectionalCalendarDemoScreen extends StatefulWidget {
  const BiDirectionalCalendarDemoScreen({super.key});

  @override
  State<BiDirectionalCalendarDemoScreen> createState() => _BiDirectionalCalendarDemoScreenState();
}

class _BiDirectionalCalendarDemoScreenState extends State<BiDirectionalCalendarDemoScreen> {
  final _repository = _CalendarDemoRepository();
  final List<DateTime> _backwardDays = [];
  final List<DateTime> _forwardDays = [];

  late final _backwardController = _DaysController(
    repository: _repository,
    isFuture: false,
    onItemsFetched: (days) => setState(() => _backwardDays.addAll(days)),
  );
  late final _forwardController = _DaysController(
    repository: _repository,
    isFuture: true,
    onItemsFetched: (days) => setState(() => _forwardDays.addAll(days)),
  );

  void _armSimulatedError(_DaysController controller, String label) {
    controller.simulateErrorOnce = true;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Next $label fetch will fail')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Bi-directional calendar demo'),
        actions: [
          IconButton(
            tooltip: 'Simulate error scrolling into the past',
            icon: const Icon(Icons.arrow_upward),
            onPressed: () => _armSimulatedError(_backwardController, 'past'),
          ),
          IconButton(
            tooltip: 'Simulate error scrolling into the future',
            icon: const Icon(Icons.arrow_downward),
            onPressed: () => _armSimulatedError(_forwardController, 'future'),
          ),
        ],
      ),
      body: Material(
        type: MaterialType.transparency,
        child: BiDirectionalPagedList<DateTime>(
          backwardItems: _backwardDays,
          forwardItems: _forwardDays,
          backwardController: _backwardController,
          forwardController: _forwardController,
          itemBuilder: (context, date, index) => _DayTile(date: date),
          separatorBuilder: (context, index) => const Divider(height: 1),
          emptyState: const Center(child: Text('No more days')),
          errorBuilder: (context, onRetry) => Center(
            child: TextButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ),
        ),
      ),
    );
  }
}

class _DayTile extends StatelessWidget {
  const _DayTile({required this.date});

  final DateTime date;

  static const _weekdayNames = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  bool get _isToday {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  String get _formatted {
    final weekday = _weekdayNames[date.weekday - 1];
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$weekday, ${date.year}-$month-$day';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        _formatted,
        style: _isToday ? const TextStyle(fontWeight: FontWeight.bold) : null,
      ),
      trailing: _isToday ? const Text('Today') : null,
    );
  }
}

class _DemoPagedError extends PagedError {
  _DemoPagedError({required super.message});
}

class _DaysPageMeta extends PaginationMeta<int> {
  const _DaysPageMeta({required super.next, required super.pageSize});
}

class _CalendarDemoRepository {
  static const int daysPerPage = 20;
  static const int maxPages = 5;

  Future<List<DateTime>> fetchDays({
    required int page,
    required bool isFuture,
    required bool simulateError,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));

    if (simulateError) {
      throw _DemoPagedError(
        message: 'Something went wrong while loading days.',
      );
    }

    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);

    return List<DateTime>.generate(daysPerPage, (index) {
      final dayOffset = page * daysPerPage + index;
      return isFuture ? startOfToday.add(Duration(days: dayOffset)) : startOfToday.subtract(Duration(days: dayOffset + 1));
    });
  }
}

class _DaysController extends InfiniteScrollController<int> {
  _DaysController({
    required this.repository,
    required this.isFuture,
    required this.onItemsFetched,
  }) : super(
         initialData: const _DaysPageMeta(
           next: 0,
           pageSize: _CalendarDemoRepository.daysPerPage,
         ),
       );

  final _CalendarDemoRepository repository;
  final bool isFuture;
  final void Function(List<DateTime> days) onItemsFetched;

  /// Set from the demo screen's app bar actions to exercise the error path.
  bool simulateErrorOnce = false;

  @override
  Future<_DaysPageMeta> fetchNewPage() async {
    final page = value.pageKey ?? 0;
    final shouldSimulateError = simulateErrorOnce;
    simulateErrorOnce = false;

    final days = await repository.fetchDays(
      page: page,
      isFuture: isFuture,
      simulateError: shouldSimulateError,
    );
    onItemsFetched(days);

    final hasMorePages = page < _CalendarDemoRepository.maxPages - 1;
    return _DaysPageMeta(
      next: hasMorePages ? page + 1 : null,
      pageSize: _CalendarDemoRepository.daysPerPage,
    );
  }

  @override
  Future<void> logError(Object error, StackTrace stackTrace) async {
    debugPrint('BiDirectionalCalendarDemoScreen fetch error: $error');
  }
}
