import 'package:json_annotation/json_annotation.dart';

part 'cooperacion.g.dart';

@JsonSerializable()
class Cooperacion {
  final String? nombre;
  final String? descripcion;
  final String? montoObjetivo;
  final String? numeroCuenta;
  final String fechaInicio;
  final String? fechaFin;
  final String? estado;
  final int? createdBy;
  final double? montoActual; // Nuevo campo Monto actual recaudado.
  final List<int>? participantes; // Lista de IDs de usuarios participantes.
  final int? updatedBy; // ID del usuario que actualizó.
  final String? updatedAt; // Fecha de la última actualización.
  final String? tipoCooperacion; // Tipo o categoría de la cooperación.
  final int idGrupo; // Campo adicional
  final int idCategoria; // Campo adicional
  final String fechaCreacion; // Nueva propiedad para fecha de creación.

  Cooperacion({
    required this.nombre,
    required this.descripcion,
    required this.montoObjetivo,
    required DateTime fechaInicio,
    required this.createdBy,
    required this.idGrupo,
    required this.idCategoria,
    this.estado,
    this.numeroCuenta,
    this.montoActual,
    this.participantes,
    this.updatedBy,
    this.updatedAt,
    this.tipoCooperacion,
    DateTime? fechaFin,
    DateTime? fechaCreacion, // Parámetro adicional para la fecha de creación.
  })  : fechaInicio = fechaInicio.toIso8601String(),
        fechaFin = fechaFin?.toIso8601String(),
        fechaCreacion = fechaCreacion?.toIso8601String() ?? DateTime.now().toIso8601String(); // Por defecto, fecha actual si no se pasa.

  factory Cooperacion.fromJson(Map<String, dynamic> json) =>
      _$CooperacionFromJson(json);

  Map<String, dynamic> toJson() => _$CooperacionToJson(this);
}
