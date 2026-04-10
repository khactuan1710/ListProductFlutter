import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class LoggingClient extends http.BaseClient {
  final http.Client _inner;

  LoggingClient(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final start = DateTime.now();

    if (kDebugMode) {
      debugPrint('➡️ REQUEST');
      debugPrint('URL: ${request.url}');
      debugPrint('METHOD: ${request.method}');
      debugPrint('HEADERS: ${request.headers}');
    }

    if (request is http.Request && kDebugMode) {
      debugPrint('BODY: ${request.body}');
    }

    final response = await _inner.send(request);

    final responseBody = await response.stream.bytesToString();
    final duration = DateTime.now().difference(start);

    if (kDebugMode) {
      debugPrint('⬅️ RESPONSE');
      debugPrint('URL: ${request.url}');
      debugPrint('STATUS: ${response.statusCode}');
      debugPrint('TIME: ${duration.inMilliseconds} ms');
      debugPrint('BODY: ${_prettyJson(responseBody)}');
    }

    return http.StreamedResponse(
      Stream.value(utf8.encode(responseBody)),
      response.statusCode,
      headers: response.headers,
      request: request,
    );
  }

  String _prettyJson(String input) {
    try {
      final jsonObject = json.decode(input);
      return const JsonEncoder.withIndent('  ').convert(jsonObject);
    } catch (_) {
      return input;
    }
  }
}