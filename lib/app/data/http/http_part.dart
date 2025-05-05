part of 'http.dart'; // Indica que esta es una parte de la clase `Http` definida en otro archivo (http.dart).

// Clase que representa un fallo en una solicitud HTTP.
class HttpFailure {
  
  final int? statusCode; // Código de estado HTTP que indica el tipo de error (por ejemplo, 404, 500).
  final Object? exception; // Excepción que puede haber ocurrido durante la solicitud, si es relevante.
  final String? bodyError; // Cuerpo de la respuesta en caso de que haya un error en el contenido.

  // Constructor que permite inicializar los atributos de la clase.
  HttpFailure({this.statusCode, this.exception, this.bodyError});
}

// Clase que representa una excepción de red, como problemas de conectividad.
class NetworkExceptionApiNotFound {
  // Esta clase podría extenderse con propiedades y métodos específicos
  // para manejar excepciones de red en la aplicación.
}

// Clase que representa una excepción de red, como problemas de conectividad.
class NetworkException {
  // Esta clase podría extenderse con propiedades y métodos específicos
  // para manejar excepciones de red en la aplicación.
}

class UnauthorizedException{
  final String codigo; // Código de error devuelto por la API.
  final String mensaje; // Mensaje de error devuelto por la API.

  // Constructor que requiere que se proporcionen el código y el mensaje de error.
  UnauthorizedException({required this.codigo, required this.mensaje});
}

class ErrorTimeoutException {
  final Duration timeoutDuration; // Duración del tiempo de espera.
  final String? message; // Mensaje descriptivo del error.
  final String? url; // URL o endpoint que causó el error.
  final HttpMethod? method; // Método HTTP que falló.

  // Constructor para inicializar las propiedades.
  ErrorTimeoutException({
    required this.timeoutDuration,
    this.message,
    this.url,
    this.method,
  });

  // Método para obtener un mensaje detallado.
  String getDetailedMessage() {
    return 'TimeoutException: ${message ?? "Tiempo de espera excedido"} '
        'después de ${timeoutDuration.inSeconds} segundos '
        '${method != null ? "durante una solicitud ${method.toString().split('.').last}" : ""} '
        '${url != null ? "a la URL $url" : ""}.';
  }

  // Método para registrar el error (puedes integrarlo con un sistema de logs).
  void logError() {
    Log.debug(
        "[TimeoutException] ${getDetailedMessage()}"); // Registra el mensaje detallado.
    // Aquí puedes agregar más lógica para manejar el error, como enviar un reporte o notificar al usuario.
    // Por ejemplo, podrías enviar el error a un servicio de monitoreo o registrar en un archivo.
  }
}

// Clase que representa una excepción de negocio específica para la API MMovil.
class MMovilV1BusinessException {
  final String codigo; // Código de error devuelto por la API.
  final String mensaje; // Mensaje de error devuelto por la API.

  // Constructor que requiere que se proporcionen el código y el mensaje de error.
  MMovilV1BusinessException({required this.codigo, required this.mensaje});
}


// Enumeración que define los diferentes métodos HTTP que la clase `Http` puede manejar.
enum HttpMethod {
  get, // Método GET: para recuperar datos del servidor.
  post, // Método POST: para enviar datos al servidor.
  patch, // Método PATCH: para modificar parcialmente recursos en el servidor.
  delete, // Método DELETE: para eliminar recursos en el servidor.
  put // Método PUT: para reemplazar recursos en el servidor.
}
