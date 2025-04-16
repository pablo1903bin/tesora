
import 'package:freezed_annotation/freezed_annotation.dart';

import '../http/http_request_failure.dart';

part 'login_user_failure.freezed.dart';

@freezed
class LoginUserFailure with _$LoginUserFailure {

  
  const factory LoginUserFailure.invalidCredentials() = _InvalidCredentials;

  const factory LoginUserFailure.redirectionDetectada() = _RedirectionDetectada;

  const factory LoginUserFailure.sinInternet() = _SinInternet;

  const factory LoginUserFailure.servidorNoEncontrado() = _ServidorNoEncontrado;

  const factory LoginUserFailure.errorInterno() = _ErrorInterno;

  const factory LoginUserFailure.errorDeCliente() = _ErrorDeCliente;

  const factory LoginUserFailure.errorDesconocido() = _ErrorDesconocido;

  const factory LoginUserFailure.custom(int codigo, String mensaje) = _Custom;

  const factory LoginUserFailure.errorDeNegocio(
    String codigo,
    String mensaje,
  ) = _Negocio;

  // Este es opcional, si quieres seguir usando el viejo error generalizado
  const factory LoginUserFailure.httpFailure(HttpRequestFailure httpFailure) =
      _LoginUserFailureHttpFailure;

  const factory LoginUserFailure.unexpected() = _Unexpected;
}
