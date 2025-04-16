import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tesora/app/data/services/remote/sign_in_api.dart';
import 'package:tesora/app/domain/failures/http/http_failure_mapper.dart';
import 'package:tesora/app/domain/failures/http/http_request_failure.dart';
import 'package:tesora/app/domain/failures/loguin/login_user_failure.dart';
import 'package:tesora/app/domain/models/loguin/user_loguin_response.dart';

import '../../domain/functional/respuesta.dart';
import '../../domain/models/user.dart';
import '../../domain/models/usuario/crear_usuario_request.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../http/http.dart';

const _token = 'token';
const _username = 'username';
const _email = 'email';
const _name = 'name';

class AuthenticationRepositoryImpl with HttpFailureMapper implements AuthenticationRepository {
  final FlutterSecureStorage _secureStorage;
  final SignInApi _signInApi;

//Inyeccion por constructor
  AuthenticationRepositoryImpl(this._secureStorage, this._signInApi);

  @override
  Future<Respuesta<LoginUserFailure, UserLoginResponse>> signIn( String username, String pass) async {
    // Realiza la solicitud...

    Respuesta<HttpFailure, UserLoginResponse> result = await _signInApi.loginUser(username: username, password: pass);

    return result.when(
      error: _onRequestError,
      exito: (userState) {
        return Respuesta.exito(userState);
      },
    );
  }

  @override
  Future<Respuesta<HttpFailure, dynamic>> register(
      CrearUsuarioRequest user) async {
    try {
      // Invoca el método de la API para crear el usuario
      final response = await _signInApi.createUser(
        username: user.username,
        password: user.password,
        name: user.name,
        apellido: user.apellido,
        telefono: user.telefono,
        email: user.email,
      );

      // Devuelve la respuesta recibida
      return response;
    } catch (e) {
      // Mapea el error si ocurre alguna excepción
      return Respuesta.error(HttpFailure(exception: e));
    }
  }

  @override
  Future<String?> getNameUser() async {
    final username = await _secureStorage.read(key: _username);
    return username;
  }

  @override
  Future<User> getUseDta() async {
    final tokenU = await _secureStorage.read(key: _token);
    final username = await _secureStorage.read(key: _username);
    final email = await _secureStorage.read(key: _email);

    if (tokenU != null) {
      return Future.value(User(name: username, email: email, token: tokenU));
    }
    return Future.value(User());
  }

  @override
  Future<bool> get isSignedIn async {
    final tokenU = await _secureStorage.read(key: _token);
    if (tokenU != null && tokenU.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> signOut() async {
    await _secureStorage.delete(key: _token);
    await _secureStorage.delete(key: _username);
    await _secureStorage.delete(key: _email);
    await _secureStorage.delete(key: _name);
  }

  @override
  Future<String?> getToken() async {
    final token = await _secureStorage.read(key: _token);
    return token;
  }

  // Métodos no implementados
  @override
  Future<bool> isLoggedIn() {
    throw UnimplementedError();
  }

  @override
  Future<bool> login(String username, String password) {
    throw UnimplementedError();
  }

// Manejo de errores específicos para LoginUserFailure utilizando el mixin HttpFailureMapper.
// Este método se encarga de mapear un error genérico de tipo HttpFailure a un error más específico
// relacionado con el proceso de inicio de sesión (LoginUserFailure).
  Respuesta<LoginUserFailure, T> _onRequestError<T>(HttpFailure error) {
    // Utiliza el método `mapFailure`, que aplica una transformación desde un HttpFailure
    // a una Respuesta<LoginUserFailure, T>. El método toma dos parámetros:
    // - El error original (HttpFailure).
    // - Una función que define cómo transformar el HttpFailure en un LoginUserFailure.
    return mapFailure<Respuesta<LoginUserFailure, T>>( error, _failureWithLoginUser);
  }

// Este método se encarga de transformar un error de tipo `HttpRequestFailure` (error técnico del HTTP)
// en un error más específico y semántico de tipo `LoginUserFailure`,
// el cual está orientado a representar errores del proceso de inicio de sesión en la lógica de negocio.
  Respuesta<LoginUserFailure, T> _failureWithLoginUser<T>( HttpRequestFailure failure) {
    // Usamos `when` (de Freezed) para hacer pattern matching de forma exhaustiva sobre todas las posibles variantes de `HttpRequestFailure`.
    return failure.when(
      // Error cuando el servidor no encuentra el recurso solicitado (404)
      notFound: () =>
          Respuesta.error(const LoginUserFailure.servidorNoEncontrado()),

      // Error de red (sin conexión a internet o red caída)
      network: () => Respuesta.error(const LoginUserFailure.sinInternet()),

      // Error de autorización (401) → Credenciales inválidas
      unauthorized: () =>
          Respuesta.error(const LoginUserFailure.invalidCredentials()),

      // Error interno del servidor (500)
      internalError: () =>
          Respuesta.error(const LoginUserFailure.errorInterno()),

      // Error del cliente (400) → solicitud malformada
      badRequest: () =>
          Respuesta.error(const LoginUserFailure.errorDeCliente()),
      // Error por redirección (como un 302) → normalmente ocurre por portales cautivos
      redirection: () =>
          Respuesta.error(const LoginUserFailure.redirectionDetectada()),

      // Error desconocido que no encaja en los anteriores
      unknown: () => Respuesta.error(const LoginUserFailure.errorDesconocido()),

      // Error custom → código y mensaje definidos por el backend
      custom: (codigo, mensaje) =>
          Respuesta.error(LoginUserFailure.custom(codigo, mensaje)),

      // Error de negocio → validaciones o reglas del sistema, también definidas por el backend
      businessError: (codigo, mensaje) =>
          Respuesta.error(LoginUserFailure.errorDeNegocio(codigo, mensaje)),
    );
  }
}
