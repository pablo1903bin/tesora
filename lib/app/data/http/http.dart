import 'dart:async';
import 'dart:io'; // Importa bibliotecas para manejar excepciones de sockets y cliente HTTP.

import 'package:http/http.dart'; // Importa la biblioteca HTTP para manejar las solicitudes HTTP.

import '../../domain/functional/respuesta.dart'; // Importa una clase personalizada para manejar respuestas funcionales.
import '../../domain/utils/log.dart'; // Importa una utilidad personalizada para registrar logs.

part 'http_part.dart';

class Http {
  // Cliente HTTP que se utiliza para realizar solicitudes.
  final Client _client;

  // Constructor que recibe un cliente HTTP.
  Http({required Client client}) : _client = client;

  // Método para reemplazar los parámetros de consulta en la URI (URL).
  Uri replaceQueryParameters(Uri uri, Map<String, String> query) {
    if (query.isNotEmpty) {
      uri = uri.replace(queryParameters: query);
    }
    return uri;
  }

  Future<Response> execute(
      Uri url,
      HttpMethod method,
      Map<String, String> headers,
      Map<String, String> params,
      String body) async {
    // Registra la solicitud en el log para depuración.
      Log.debug("[Http] Execute!....⭕️  ");

    switch (method) {
      case HttpMethod.post:
        return await _client.post(url, headers: headers, body: body).timeout(const Duration(seconds: 5)); 
      case HttpMethod.patch:
        return await _client.patch(url, headers: headers, body: body);
      case HttpMethod.delete:
        return await _client.delete(url, headers: headers, body: body);
      case HttpMethod.put:
        return await _client.put(url, headers: headers, body: body);
      case HttpMethod.get:
        return await _client.get(url, headers: headers).timeout(const Duration(seconds: 10));
      default:
        return await _client.get(url, headers: headers).timeout(const Duration(seconds: 10));
    }
  }

  // Método que convierte una cadena URI en un objeto Uri.
  Uri getUrl(String uri) {
    return Uri.parse(uri);
  }

  // Método que realiza una solicitud HTTP con un cuerpo y devuelve una respuesta.
  Future<Respuesta<HttpFailure, String>> requestBody(String uri,
      {HttpMethod method = HttpMethod.get, // Método HTTP por defecto es GET.
      Map<String, String> headers = const {}, // Encabezados HTTP por defecto.
      Map<String, String> params = const {}, // Parámetros de consulta por defecto.
      String body = ""}) async {

    final url = replaceQueryParameters( getUrl(uri), params); // Reemplaza los parámetros de consulta en la URL.

    // Registra la solicitud en el log para depuración.
    Log.debug("[request] url: $url");
    Log.debug("[request] method: $method");
    Log.debug("[request] headers: $headers");
    Log.debug("[request] Query-params: $params");
    Log.debug("[request] body: $body}");

    try {
      final Response response = await execute( url, method, headers, params, body); // Ejecuta la solicitud HTTP.

      // Registra la respuesta en el log para depuración.
      Log.debug("[response] response: $response");
      Log.debug("[response] statusCode: ${response.statusCode}");
      Log.debug("[response] body: ${response.body}");
      Log.debug("[response] return: ${getRespuesta(response)}");

      return getRespuesta(response); // Devuelve la respuesta procesada si todo fue ok.
    } catch (e) {
      Log.debug("[response-ERROR Http] Tipo de excepción: ${e.runtimeType}");

      // Registra la respuesta en el log para depuración.
      Log.debug("[response-ERROR Http]     ❌  response: $e");
      return getException(e); // Maneja y devuelve cualquier excepción ocurrida.
    }
  }

  Respuesta<HttpFailure,R> getRespuesta<R>(Response response){
    final statusCode = response.statusCode;
    if(statusCode >= 200 && statusCode < 300){
      return Respuesta.exito(response.body as R);
    }

    if(statusCode == 409 ){
       Log.debug("[Http getRespuesta]   statusCode: $statusCode");
      return Respuesta.error(HttpFailure(statusCode: statusCode, exception: UnauthorizedException(codigo:statusCode.toString(), mensaje: "")));
    }

    return Respuesta.error(HttpFailure(statusCode: statusCode, bodyError: response.body));
  }
  
  // Método que procesa las excepciones ocurridas durante la solicitud HTTP.
  Respuesta<HttpFailure, R> getException<R>(Object errorObject) {
    
    if(errorObject is SocketException ){
      Log.debug("[Http getException]   SocketException: ${errorObject.message}");
      return Respuesta.error( HttpFailure( statusCode: -1, exception: NetworkExceptionApiNotFound(), bodyError: errorObject.toString(), ), );
    }

    if ( errorObject is ClientException || errorObject is TimeoutException ) {
     
      return Respuesta.error( HttpFailure( statusCode: -1, exception: NetworkException(), bodyError: errorObject.toString(), ), );
    }

    return Respuesta.error(HttpFailure(exception: errorObject));
  }

}
