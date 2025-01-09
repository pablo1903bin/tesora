import 'package:json_annotation/json_annotation.dart';

part 'gasto.g.dart';

@JsonSerializable()
class Gasto {
  final int id;
  final String? nombre; // Nombre o título del gasto.
  final String? descripcion; // Descripción detallada del gasto.
  final double monto; // Monto del gasto.
  final String categoria; // Categoría a la que pertenece el gasto.
  final String? estado; // Estado del gasto (e.g., "Pagado", "Pendiente").
  final DateTime fecha; // Fecha en la que se realizó el gasto.
  final int? idUsuario; // ID del usuario que registró el gasto.
  final int? idCategoria; // ID de la categoría.
  final String?
      metodoPago; // Método de pago utilizado (e.g., "Efectivo", "Tarjeta").
  final String? comprobante; // URL o identificación del comprobante.
  final int? idGrupo; // ID del grupo al que pertenece el gasto (si aplica).
  final List<int>? participantes; // IDs de usuarios involucrados en el gasto.

  Gasto({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.monto,
    required this.categoria,
    required this.fecha,
    this.estado,
    this.idUsuario,
    this.idCategoria,
    this.metodoPago,
    this.comprobante,
    this.idGrupo,
    this.participantes,
  });

  // Generación de JSON
  factory Gasto.fromJson(Map<String, dynamic> json) => _$GastoFromJson(json);

  Map<String, dynamic> toJson() => _$GastoToJson(this);
}
