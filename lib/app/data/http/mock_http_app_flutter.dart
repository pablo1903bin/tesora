import 'dart:async';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:tesora/app/data/http/http.dart';

import 'http_app_flutter.dart';

class MockHttpAppFlutter extends HttpAppFlutter {
  MockHttpAppFlutter({
    required super.client,
    required super.hostApi,
  });

  @override
  Future<Response> execute(
    Uri url,
    HttpMethod method,
    Map<String, String> headers,
    Map<String, String> params,
    String body,
  ) async {
    final filePath = _getMockFilePath(url);

    try {
      final mockJson = await rootBundle.loadString(filePath);

      await Future.delayed(const Duration(seconds: 2)); // Simula latencia

      return Response(mockJson, 200);
    } catch (e) {
      return Response('{"codigo":"ERROR","mensaje":"Mock no encontrado"}', 404);
    }
  }

  String _getMockFilePath(Uri url) {
    // Ejemplo: /authentication/sign-in → assets/mocks/authentication/sign-in.json
    return 'assets/mock${url.path}.json';
  }
}
