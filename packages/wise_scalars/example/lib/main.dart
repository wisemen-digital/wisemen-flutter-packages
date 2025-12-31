import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wise_scalars/wise_scalars.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final scalarOptions = await ScalarOptions.fromMethodChannel();

  runApp(ScalarScopeExample(options: scalarOptions));
}

class ScalarScopeExample extends StatefulWidget {
  const ScalarScopeExample({required this.options, super.key});

  final ScalarOptions options;

  @override
  State<ScalarScopeExample> createState() => _ScalarScopeExampleState();
}

class _ScalarScopeExampleState extends State<ScalarScopeExample> with WidgetsBindingObserver {
  late ScalarOptions scalarOptions;
  @override
  void initState() {
    super.initState();
    scalarOptions = widget.options;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshScalarOptions();
    }
  }

  Future<void> _refreshScalarOptions() async {
    final refreshedOptions = await ScalarOptions.fromMethodChannel();
    if (refreshedOptions != scalarOptions) {
      setState(() {
        scalarOptions = refreshedOptions;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WiseScalarScope(options: scalarOptions, child: const App());
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              spacing: 8,
              children: [
                const Text('This is an example app for wise_scalars plugin.'),
                Text('Time: ${DateTime.now().time(context)}'),
                Text('Date short: ${DateTime.now().short(context)}'),
                Text('Date medium: ${DateTime.now().medium(context)}'),
                Text('Date long: ${DateTime.now().long(context)}'),
                Text('Date full: ${DateTime.now().full(context)}'),
                Text('20 celsius is: ${const Temperature(value: 20, unit: TemperatureUnit.celsius).label(context)}'),
                Text('100 meters is: ${const Distance(value: 100, unit: DistanceUnit.meters).label(context)}'),
                Text(
                  'First day of the week: ${DateFormat('EEEE').format(DateTime.now().subtract(Duration(days: DateTime.now().weekday - (ScalarOptions.of(context).firstDayOfWeek ?? 1))))}',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
