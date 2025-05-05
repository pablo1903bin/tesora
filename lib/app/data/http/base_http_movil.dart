import 'dart:convert';

import 'package:tesora/app/data/http/http.dart';
import 'package:tesora/app/data/local/http_sesion_service.dart';
import 'package:tesora/app/domain/functional/respuesta.dart';

class BaseHttpMovil extends Http {
  final String _hostApi;
  final HttpSesionService _httpSesionService;

  BaseHttpMovil({
    required super.client,
    required hostApi,
    required httpSesionService,
  })  : _hostApi = hostApi,
        _httpSesionService = httpSesionService;

  @override
  Uri getUrl(String uri) {
    final completeUrl = Uri.parse("$_hostApi$uri");

    return completeUrl;
  }


  Map<String, String> addHeaders(
      HttpMethod method, Map<String, String> headers, bool jsonPost) {
    var updatedHeaders = headers;
    if (jsonPost) {
      updatedHeaders = {
        ...updatedHeaders,
        "Content-Type": "application/json",
      };
    }

    if (_httpSesionService.sesion.cookies.isNotEmpty) {
      updatedHeaders = {
        ...updatedHeaders,
        "Cookie": _httpSesionService.sesion.cookies.join("; "),
      };
    }
// Log de los encabezados generados
    return updatedHeaders;
  }

  Map<String, String> getDefaulPostHeaders() {
    final headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
    };

    return headers;
  }

  String _getPayload(bool jsonPost, Map<String, dynamic> body) {
    final payload = jsonPost ? jsonEncode(body) : mapToQueryString(body);

    return payload;
  }

  Future<Respuesta<HttpFailure, R>> request<R>(
    String uri, {
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {},
    Map<String, String> params = const {},
    Map<String, dynamic> body = const {},
    R Function(String)? procesaExito,
    String? jsonKey,
    bool jsonPost = false,
  }) async {
    print("Request: $uri");
    try {
      final response = await super.requestBody(
        uri,
        method: method,
        headers: addHeaders(method, headers, jsonPost),
        body: _getPayload(jsonPost, body),
      );

      return response.when(
        error: (err) {
          return Respuesta.error(err);
        },
        exito: (body) {
          try {
            return exito<R>(procesaExito, jsonKey, body);
          } catch (e) {

            return Respuesta.error(HttpFailure(statusCode: -1, exception: e));
          }
        },
      );
    } catch (e) {
      return Respuesta.error(HttpFailure(statusCode: -1, exception: e));
    }
  }

  Respuesta<HttpFailure, R> exito<R>(
    R Function(String)? procesaExito,
    String? jsonKey,
    String body,
  ) {

    if (procesaExito != null) {
      return Respuesta.exito(procesaExito(body));
    }
    if (jsonKey != null) {
      return _onExito(body, jsonKey);
    }
    return Respuesta.exito(body as R);
  }

  Respuesta<HttpFailure, R> _onExito<R>(String body, String key) {

    return Respuesta.exito(getKeyFromJson(body, key));
  }

  R getKeyFromJson<R>(String body, String key) {
    final json = jsonDecode(body);
    final extractedValue = json[key];

    return extractedValue;
  }

  String mapToQueryString(Map<String, dynamic> map) {
    final queryString = map.entries.map((entry) {
      final key = Uri.encodeComponent(entry.key);
      final value = Uri.encodeComponent(entry.value.toString());
      return '$key=$value';
    }).join('&');

    return queryString;
  }

  HttpSesionService get sessionService {

    return _httpSesionService;
  }
}
