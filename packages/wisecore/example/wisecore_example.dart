import 'package:wisecore/wisecore.dart';

void main() async {
  final now = DateTime.now();
  final oneHourAgo = now.subtract(const Duration(hours: 1));

  if (now.isSameDate(oneHourAgo)) {
    // Do something
  }
}
