import 'package:flutter/material.dart';
import 'package:wise_sentry/wise_sentry.dart';

/// Example app to test UI error handling
///
/// Run this to verify that:
/// 1. Widget errors are caught automatically (no wrapping needed)
/// 2. Errors are sent to Sentry with proper context
/// 3. The app doesn't crash completely
void main() async {
  await WiseSentry.init(
    dsn: 'YOUR_SENTRY_DSN_HERE', // Replace with actual DSN for testing
    environment: 'test',
    logInDebugMode: true, // Enable logging in debug mode for testing
    appRunner: () => const MyTestApp(),
  );
}

class MyTestApp extends StatelessWidget {
  const MyTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI Error Test',
      home: const ErrorTestScreen(),
    );
  }
}

class ErrorTestScreen extends StatelessWidget {
  const ErrorTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Error Handler Tests'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Test different error scenarios:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Test 1: Build Error
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const _BuildErrorWidget(),
                ),
              );
            },
            child: const Text('1. Test Build Error'),
          ),
          const SizedBox(height: 8),

          // Test 2: Render Error
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const _RenderErrorWidget(),
                ),
              );
            },
            child: const Text('2. Test Render Error'),
          ),
          const SizedBox(height: 8),

          // Test 3: State Error
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const _StateErrorWidget(),
                ),
              );
            },
            child: const Text('3. Test State Error'),
          ),
          const SizedBox(height: 8),

          // Test 4: Async Error
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const _AsyncErrorWidget(),
                ),
              );
            },
            child: const Text('4. Test Async Error'),
          ),
          const SizedBox(height: 8),

          // Test 5: Manual wrapped error with context
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const _WrappedErrorWidget(),
                ),
              );
            },
            child: const Text('5. Test Wrapped Error (with context)'),
          ),
          const SizedBox(height: 24),

          const Card(
            color: Colors.blue,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expected Behavior:',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '✓ Errors caught automatically\n'
                    '✓ Sent to Sentry\n'
                    '✓ Red error screen shown\n'
                    '✓ App continues running\n'
                    '✓ No widget wrapping needed',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Test widget that throws during build
class _BuildErrorWidget extends StatelessWidget {
  const _BuildErrorWidget();

  @override
  Widget build(BuildContext context) {
    // This error will be caught by FlutterError.onError
    throw Exception('Build error test - this should be caught automatically!');
  }
}

// Test widget that throws during render
class _RenderErrorWidget extends StatelessWidget {
  const _RenderErrorWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Render Error Test')),
      body: CustomPaint(
        painter: _ErrorPainter(),
      ),
    );
  }
}

class _ErrorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    throw Exception('Render error test - caught during painting!');
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Test widget that throws during state update
class _StateErrorWidget extends StatefulWidget {
  const _StateErrorWidget();

  @override
  State<_StateErrorWidget> createState() => _StateErrorWidgetState();
}

class _StateErrorWidgetState extends State<_StateErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('State Error Test')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              throw Exception('State error test - caught during setState!');
            });
          },
          child: const Text('Trigger State Error'),
        ),
      ),
    );
  }
}

// Test widget with async error
class _AsyncErrorWidget extends StatefulWidget {
  const _AsyncErrorWidget();

  @override
  State<_AsyncErrorWidget> createState() => _AsyncErrorWidgetState();
}

class _AsyncErrorWidgetState extends State<_AsyncErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Async Error Test')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Simulate async operation
            await Future.delayed(const Duration(milliseconds: 100));
            throw Exception('Async error test - caught by PlatformDispatcher!');
          },
          child: const Text('Trigger Async Error'),
        ),
      ),
    );
  }
}

// Test widget wrapped with WiseUIErrorParser for additional context
class _WrappedErrorWidget extends StatelessWidget {
  const _WrappedErrorWidget();

  @override
  Widget build(BuildContext context) {
    return WiseUIErrorParser.parse(
      () {
        return Scaffold(
          appBar: AppBar(title: const Text('Wrapped Error Test')),
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                throw Exception('Wrapped error - has extra context!');
              },
              child: const Text('Trigger Wrapped Error'),
            ),
          ),
        );
      },
      location: 'error_test_manual.dart:_WrappedErrorWidget',
      context: {
        'screen': 'error_test',
        'userId': 'test-user-123',
        'additionalInfo': 'This error has rich context',
      },
    );
  }
}
