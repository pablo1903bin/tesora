import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tesora/app/data/local/secure_storage_service.dart';
import 'package:tesora/app/data/services/remote/sign_in_api.dart';
import 'package:tesora/app/domain/failures/http/http_failure_mapper.dart';
import 'package:tesora/app/domain/failures/http/http_request_failure.dart';
import 'package:tesora/app/domain/failures/loguin/login_user_failure.dart';
import 'package:tesora/app/domain/models/loguin/user_loguin_response.dart';

import '../../domain/functional/respuesta.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../http/http.dart';

const _token = 'token';
const _username = 'username';
const _email = 'email';
const _name = 'name';

class AuthenticationRepositoryImpl with HttpFailureMapper implements AuthenticationRepository {
    final SecureStorageService _storageService;
  final FlutterSecureStorage _secureStorage;
  final SignInApi _signInApi;

//Inyeccion por constructor
  AuthenticationRepositoryImpl(this._secureStorage, this._signInApi, this._storageService);

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
  Future<Respuesta<LoginUserFailure, UserLoginResponse>> signIn(
      String username, String pass) async {
    final result = await _signInApi.loginUser(
      username: username,
      password: pass,
    );

    return result.when(
      error: _onRequestError,
      exito: (userState) {
        _secureStorage.write(key: _token, value: userState.token);
        _secureStorage.write(key: _username, value: userState.username);
        _secureStorage.write(key: _email, value: userState.email);
        _secureStorage.write(key: _name, value: userState.name);
        return Respuesta.exito(userState);
      },
    );
  }

  @override
  Future<void> signOut() async {
    print("Logout    ☢   ");
    await _secureStorage.delete(key: _token);
    await _secureStorage.delete(key: _username);
    await _secureStorage.delete(key: _email);
    await _secureStorage.delete(key: _name);
  }

  @override
  Future<String?> getToken() async {
    final token = await _secureStorage.read(key: _token);
    print('Token de autenticación: $token');
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

  // Manejo de errores específicos para LoginUserFailure utilizando el mixin HttpFailureMapper
  Respuesta<LoginUserFailure, T> _onRequestError<T>(HttpFailure error) {
    return mapFailure<Respuesta<LoginUserFailure, T>>(
        error, _failureWithLoginUser);
  }

  // Este método mapea los errores HTTP a fallos del dominio para LoginUser
  Respuesta<LoginUserFailure, T> _failureWithLoginUser<T>(
      HttpRequestFailure failure) {
    return Respuesta.error(LoginUserFailure.httpFailure(failure));
  }
}
