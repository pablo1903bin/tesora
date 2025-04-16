


import 'package:freezed_annotation/freezed_annotation.dart';

part 'http_request_failure.freezed.dart';

// Importamos la anotación `@freezed` y las clases generadas automáticamente.
@freezed
// Definimos una clase inmutable `HttpRequestFailure` que representa los distintos tipos de errores de una solicitud HTTP.
class HttpRequestFailure with _$HttpRequestFailure {

  // Constructor para representar un error 404 (recurso no encontrado).
  factory HttpRequestFailure.notFound() = _NotFound;

  // Constructor para representar un error de red (como problemas de conectividad).
  factory HttpRequestFailure.network() = _Network;

  // Constructor para representar un error de autorización (como un código de estado 401).
  factory HttpRequestFailure.unauthorized() = _Unauthorized;

  // Constructor para representar un error desconocido.
  // Útil para capturar errores que no encajan en otros casos específicos.
  factory HttpRequestFailure.unknown() = _Unknown;

  // Constructor para representar un error interno del servidor (código de estado 500).
  factory HttpRequestFailure.internalError() = _InternalError;

  // Constructor para representar un error de solicitud mal formada (código de estado 400).
  factory HttpRequestFailure.badRequest() = _BadRequest;

  // Constructor para representar un error personalizado.
  // Recibe un código de error (`codigo`) y un mensaje (`mensaje`), 
  // lo que permite detallar más información específica del error.
  factory HttpRequestFailure.custom(
    int codigo, // Código de error HTTP.
    String mensaje // Mensaje descriptivo del error.
  ) = _CustomFailure;

  // Constructor para representar un error de negocio (error definido por las reglas de negocio).
  // Similar al caso personalizado, pero con un enfoque en errores propios de la lógica de la aplicación.
  factory HttpRequestFailure.businessError(
    String codigo, // Código de error propio de la lógica de negocio.
    String mensaje // Mensaje descriptivo del error de negocio.
  ) = _MMovilFailure;

  factory HttpRequestFailure.redirection() = _RedirectionFailure;
}
