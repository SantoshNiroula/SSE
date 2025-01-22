import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sse_client/sse/sse_model.dart';

class SseClient {
  final http.Client _client;
  final StreamController<SseModel> _controller;

  SseClient()
      : _client = http.Client(),
        _controller = StreamController.broadcast();

  Stream<SseModel> get stream => _controller.stream;

  Future<void> start() async {
    try {
      final url = Platform.isAndroid ? '10.2.2.1' : 'http://127.0.0.1';
      final request = http.Request('GET', Uri.parse('$url:8080/events'));

      final response = await _client.send(request);

      response.stream.listen((data) {
        final charcterCode = String.fromCharCodes(data);
        final model = SseModel.fromText(charcterCode);
        _controller.add(model);
      });
    } on http.ClientException catch (e) {
      log(e.toString());
    } catch (e) {
      log("Error: ${e.toString()}");
    }
  }

  void disponse() {
    _client.close();
    _controller.close();
  }
}
