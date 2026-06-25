import 'package:flutter/material.dart';
import 'package:wise_text/wise_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wise Text Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('Wise Text')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: .center,
              children: [
                WiseTextWidget(
                  'Join the Flutter meetup on July 15, 2026 at 6:00 PM at 1600 Amphitheatre Parkway, Mountain View, CA 94043. Call +1 650-253-0000, visit https://flutter.dev or email events@flutter.dev',
                  classified: true,
                  textAlign: TextAlign.center,
                  tags: {
                    WiseTextItemType.date.tagName: StyledTextTag(
                      style: TextStyle(color: Colors.red),
                    ),
                    WiseTextItemType.phoneNumber.tagName: StyledTextTag(
                      style: TextStyle(color: Colors.green),
                    ),
                    WiseTextItemType.email.tagName: StyledTextTag(
                      style: TextStyle(color: Colors.blue),
                    ),
                    WiseTextItemType.link.tagName: StyledTextTag(
                      style: TextStyle(color: Colors.purple),
                    ),
                    WiseTextItemType.address.tagName: StyledTextTag(
                      style: TextStyle(color: Colors.orange),
                    ),
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
