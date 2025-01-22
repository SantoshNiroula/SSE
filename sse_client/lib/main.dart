import 'package:flutter/material.dart';
import 'package:sse_client/sse/sse_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SsePage(),
      ),
    );
  }
}
