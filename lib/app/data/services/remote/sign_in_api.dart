import 'dart:convert';

import 'package:http/http.dart';
import 'package:tesora/app/domain/models/loguin/user_loguin_response.dart';

import '../../../domain/functional/respuesta.dart';
import '../../http/http.dart';
import '../../http/http_app_flutter.dart';

class SignInApi {
  final HttpAppFlutter _http;

  SignInApi({HttpAppFlutter? http})
      : _http = http ??
            HttpAppFlutter(
                client: Client(),
            );

  // Método para la creación de un nuevo usuario
  Future<Respuesta<HttpFailure, dynamic>> createUser({
    required String username,
    required String password,
    required String name,
    required String apellido,
    required String telefono,
    required String email,
  }) async {

    return await _http.request<dynamic>("/auth-service/authentication/sign-up",
        method: HttpMethod.post,
        headers: {
          "Content-Type": "application/json"
        },
        body: {
          'username': username,
          'password': password,
          'name': name,
          'apellido': apellido,
          'telefono': telefono,
          'email': email,
        }, procesaExito: (json) {
  
      return jsonDecode(json); // Devuelve el JSON decodificado
    });
  }

  Future<Respuesta<HttpFailure, UserLoginResponse>> loginUser({ required String username, required String password}) async {
  
    return await _http.request<UserLoginResponse>(
        "/auth-service/authentication/sign-in",
        method: HttpMethod.post,
        headers: {
          "Content-Type": "application/json"
        },
        body: {
          'username': username,
          'password': password,
        }, 
        procesaExito: (json) {
          final decoded = jsonDecode(json);

          // Si el backend te responde con un error lógico pero HTTP 200
          if (decoded is Map<String, dynamic> && decoded["codigo"] == "ERROR") {
            throw Exception("Error de negocio: ${decoded["mensaje"]}");
          }

          // Si todo está bien, intenta mapear
          return UserLoginResponse.fromJson(decoded);
        }
    );
  }
}
