import 'dart:convert';

import '../../domain/functional/respuesta.dart';
import 'http.dart';

class HttpAppFlutter extends Http {
  final String _hostApi;

  HttpAppFlutter({required super.client, hostApi}) : _hostApi = hostApi;

  String _getPayload(Map<String, String> headers, Map<String, dynamic> body) {
    if (headers["Content-Type"] == "application/json") {
      return jsonEncode(body);
    } else {
      return mapToQueryString(body);
    }
  }

  String mapToQueryString(Map<String, dynamic> map) {
    return map.entries.map((entry) {
      final key = Uri.encodeComponent(entry.key);
      final value = Uri.encodeComponent(entry.value.toString());
      return '$key=$value';
    }).join('&');
  }

  Map<String, String> _addHeaders(
      HttpMethod method, Map<String, String> headers) {
    if (method == HttpMethod.post) {
      headers = {...headers, "Content-Type": "application/json"};
    }
    return headers;
  }

  @override
  Uri getUrl(String uri) {
    return Uri.parse("$_hostApi$uri");
  }

Future<Respuesta<HttpFailure, R>> request<R>(String uri,
    {HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {},
    Map<String, String> params = const {},
    Map<String, dynamic> body = const {},
    R Function(String)? procesaExito}) async {
  print("Sending request to: ${getUrl(uri)}"); // Imprime la URL completa
  print("Request method: $method");
  print("Headers: $headers");
  print("Body: ${_getPayload(headers, body)}");

  final response = await super.requestBody(uri,
      method: method,
      headers: _addHeaders(method, headers),
      body: _getPayload(headers, body));

  return response.when(
    error: (err) {
      print("Error response: ${err.toString()}");

      if (err.bodyError != null) {
        print("Error body: ${err.bodyError}"); // Imprime el cuerpo del error
        try {
          final Map<String, dynamic> errorJson = jsonDecode(err.bodyError!);
          print("Parsed error body: $errorJson");
        } catch (e) {
          print("Error parsing response body: $e");
        }
      }

      return Respuesta.error(err);
    },
    exito: (body) {
      print("Successful response: $body"); // Imprime la respuesta exitosa
      try {
        return _exito<R>(procesaExito, body);
      } catch (e) {
        print("Exception while processing response: $e");
        return Respuesta.error(HttpFailure(statusCode: -1, exception: e));
      }
    },
  );
}


  Respuesta<HttpFailure, R> _exito<R>(
      R Function(String)? procesaExito, String body) {
    print(
        "Processing successful response: $body"); // Imprime el cuerpo de la respuesta procesada
    if (procesaExito != null) {
      return Respuesta.exito(procesaExito(body));
    }

    return Respuesta.exito(body as R);
  }

  @override
  String toString() {
    return 'HostApi: $_hostApi';
  }
}
