import 'package:flutter/material.dart';
import 'package:sse_client/sse/sse_client.dart';

class SsePage extends StatefulWidget {
  const SsePage({super.key});

  @override
  State<SsePage> createState() => _SsePageState();
}

class _SsePageState extends State<SsePage> {
  late final SseClient _client;

  @override
  void initState() {
    super.initState();
    _client = SseClient()..start();
  }

  @override
  void dispose() {
    _client.disponse();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _client.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: Image.network((snapshot.data!.data ?? '').replaceAll(' ', '')),
          );
        }
        return Center(
          child: Text('Data'),
        );
      },
    );
  }
}
