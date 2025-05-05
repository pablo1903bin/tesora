import 'dart:convert';

import 'package:tesora/app/domain/utils/log.dart';

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

    final response = await super.requestBody(uri, method: method, headers: _addHeaders(method, headers), body: _getPayload(headers, body));
   
    return response.when(
      error: (err) {
        Log.debug(
            "[HttpAppFlutter response] Error en la solicitud HTTP: ⁉️  ${err.statusCode} - BodyError: ${err.bodyError}");

        return Respuesta.error(err);
      },
      exito: (body) {
        Log.debug( "[HttpAppFlutter response] Exito en la solicitud HTTP: ${body.toString()}  ✅ ");
        try {
          return _exito<R>(procesaExito, body);
        } catch (e) {
          Log.debug( "[HttpAppFlutter super.requestBody ] Hubo un error${e.toString()}  ❌ ");
          return Respuesta.error(HttpFailure(statusCode: -2, exception: e, bodyError:  "error al deserealizar el json"));
        }
      },
    );
  }

  Respuesta<HttpFailure, R> _exito<R>( R Function(String)? procesaExito, String body) {
    try {
      if (procesaExito != null) {
        final result = procesaExito(body);
        return Respuesta.exito(result);
      }

      return Respuesta.exito(body as R);
    } catch (e) {
      Log.debug( "[HttpAppFlutter super.requestBody _exito] Hubo un error al deserealizar json ${body.toString()}  ❌ ");
      return Respuesta.error(HttpFailure(
        statusCode: -1,
        exception: e is Exception ? e : Exception(e.toString()),
      ));
    }
  }
}
