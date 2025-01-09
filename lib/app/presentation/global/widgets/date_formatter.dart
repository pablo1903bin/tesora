import 'package:intl/intl.dart';

class DateFormatter {
  /// Formatea una fecha al formato dd/MM/yyyy
  static String formatDate(DateTime? date) {
    if (date == null) return 'Seleccionar';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  /// Formatea una fecha al formato 'Lunes 25 de Agosto de 2025'
  static String formatFullDate(DateTime? date) {
    if (date == null) return 'Seleccionar';

    // Formatear la fecha en español
    final formattedDate =
        DateFormat('EEEE d \'de\' MMMM \'de\' y', 'es_ES').format(date);

    // Capitalizar la primera letra de cada palabra
    return formattedDate
        .split(' ') // Divide la cadena en palabras
        .map((word) => word.isNotEmpty
            ? word[0].toUpperCase() +
                word.substring(1) // Capitaliza la primera letra
            : word) // Evita errores con cadenas vacías
        .join(' '); // Une las palabras con espacios
  }

  /// Convierte una cadena como 'Lunes 25 de Diciembre de 2025' a DateTime con hora actual
  static DateTime parseToDateTimeWithCurrentTime(String fullDateString) {
    try {
      // Parsear el texto 'Lunes 25 de Diciembre de 2025' a DateTime
      final inputFormat = DateFormat('EEEE d \'de\' MMMM \'de\' y', 'es_ES');
      final parsedDate = inputFormat.parse(fullDateString);

      // Obtener la hora actual del dispositivo
      final now = DateTime.now();

      // Combinar la fecha parseada con la hora actual
      return DateTime(
        parsedDate.year,
        parsedDate.month,
        parsedDate.day,
        now.hour,
        now.minute,
        now.second,
      );
    } catch (e) {
      throw Exception('Error al parsear la fecha: $e');
    }
  }

  /// Formatea un DateTime al formato ISO 8601: yyyy-MM-ddTHH:mm:ss
  static String formatToISO8601(DateTime date) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss').format(date);
  }

  /// Convierte una cadena como 'Lunes 25 de Diciembre de 2025' a 'aaaa/MM/dd'
  static String parseToBackendFormat(String fullDateString) {
    try {
      // Crear un DateFormat para parsear la cadena de entrada
      final inputFormat = DateFormat('EEEE d \'de\' MMMM \'de\' y', 'es_ES');

      // Convertir el texto a DateTime
      final DateTime parsedDate = inputFormat.parse(fullDateString);

      // Formatear la fecha al formato deseado yyyy/MM/dd
      return DateFormat('yyyy/MM/dd').format(parsedDate);
    } catch (e) {
      return ''; // En caso de error, retornar cadena vacía
    }
  }
}
