import 'package:freezed_annotation/freezed_annotation.dart';

part 'respuesta.freezed.dart'; // Parte generada por Freezed, que contiene el código adicional necesario para que la unión de datos funcione correctamente.

/*Es una clase genérica que representa el resultado de una operación que puede tener éxito o puede fallar.
L = el tipo del error (Left)
R = el tipo del resultado exitoso (Right)
*/
@freezed
abstract class Respuesta<L, R> with _$Respuesta<L, R> {
  // Constructor que representa un estado de error.
  factory Respuesta.error(L value) = Error;

  // Constructor que representa un estado de éxito.
  factory Respuesta.exito(R value) = Exito;
}
