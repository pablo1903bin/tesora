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
    print("[getUrl] URL generada: $completeUrl"); // Log de la URL generada
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
    print(
        "[addHeaders] Encabezados finales: $updatedHeaders"); // Log de los encabezados generados
    return updatedHeaders;
  }

  Map<String, String> getDefaulPostHeaders() {
    final headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
    };
    print(
        "[getDefaulPostHeaders] Encabezados por defecto: $headers"); // Log de encabezados por defecto
    return headers;
  }

  String _getPayload(bool jsonPost, Map<String, dynamic> body) {
    final payload = jsonPost ? jsonEncode(body) : mapToQueryString(body);
    print(
        "[_getPayload] Payload generado: $payload"); // Log del payload generado
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
    print("[request] Iniciando solicitud con URI: $uri"); // Inicio del método
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
            print(
                "[request] Error durante la deserialización: $e"); // Log de error en deserialización
            return Respuesta.error(HttpFailure(statusCode: -1, exception: e));
          }
        },
      );
    } catch (e) {
      print(
          "[request] Excepción durante la solicitud: $e"); // Log de excepciones generales
      return Respuesta.error(HttpFailure(statusCode: -1, exception: e));
    }
  }

  Respuesta<HttpFailure, R> exito<R>(
    R Function(String)? procesaExito,
    String? jsonKey,
    String body,
  ) {
    print("[exito] Procesando éxito con body: $body"); // Log al procesar una respuesta exitosa
    if (procesaExito != null) {
      return Respuesta.exito(procesaExito(body));
    }
    if (jsonKey != null) {
      return _onExito(body, jsonKey);
    }
    return Respuesta.exito(body as R);
  }

  Respuesta<HttpFailure, R> _onExito<R>(String body, String key) {
  print( "[_onExito] Extrayendo clave: $key del body: $body"); // Log del procesamiento por clave
    return Respuesta.exito(getKeyFromJson(body, key));
  }

  R getKeyFromJson<R>(String body, String key) {
    final json = jsonDecode(body);
    final extractedValue = json[key];
   // print("[getKeyFromJson] Valor extraído para clave '$key': $extractedValue"); // Log del valor extraído
    return extractedValue;
  }

  String mapToQueryString(Map<String, dynamic> map) {
    final queryString = map.entries.map((entry) {
      final key = Uri.encodeComponent(entry.key);
      final value = Uri.encodeComponent(entry.value.toString());
      return '$key=$value';
    }).join('&');
    //print("[mapToQueryString] Query string generada: $queryString"); // Log del query string generado
    return queryString;
  }

  HttpSesionService get sessionService {
   // print( "[sessionService] Obteniendo servicio de sesión"); // Log al acceder al servicio de sesión
    return _httpSesionService;
  }
}
