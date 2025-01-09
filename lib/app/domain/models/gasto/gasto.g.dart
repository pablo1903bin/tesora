// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gasto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gasto _$GastoFromJson(Map<String, dynamic> json) => Gasto(
      id: (json['id'] as num).toInt(),
      nombre: json['nombre'] as String?,
      descripcion: json['descripcion'] as String?,
      monto: (json['monto'] as num).toDouble(),
      categoria: json['categoria'] as String,
      fecha: DateTime.parse(json['fecha'] as String),
      estado: json['estado'] as String?,
      idUsuario: (json['idUsuario'] as num?)?.toInt(),
      idCategoria: (json['idCategoria'] as num?)?.toInt(),
      metodoPago: json['metodoPago'] as String?,
      comprobante: json['comprobante'] as String?,
      idGrupo: (json['idGrupo'] as num?)?.toInt(),
      participantes: (json['participantes'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$GastoToJson(Gasto instance) => <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'descripcion': instance.descripcion,
      'monto': instance.monto,
      'categoria': instance.categoria,
      'estado': instance.estado,
      'fecha': instance.fecha.toIso8601String(),
      'idUsuario': instance.idUsuario,
      'idCategoria': instance.idCategoria,
      'metodoPago': instance.metodoPago,
      'comprobante': instance.comprobante,
      'idGrupo': instance.idGrupo,
      'participantes': instance.participantes,
    };
