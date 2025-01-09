// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cooperacion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cooperacion _$CooperacionFromJson(Map<String, dynamic> json) => Cooperacion(
      nombre: json['nombre'] as String?,
      descripcion: json['descripcion'] as String?,
      montoObjetivo: json['montoObjetivo'] as String?,
      fechaInicio: DateTime.parse(json['fechaInicio'] as String),
      createdBy: (json['createdBy'] as num?)?.toInt(),
      idGrupo: (json['idGrupo'] as num).toInt(),
      idCategoria: (json['idCategoria'] as num).toInt(),
      estado: json['estado'] as String?,
      numeroCuenta: json['numeroCuenta'] as String?,
      montoActual: (json['montoActual'] as num?)?.toDouble(),
      participantes: (json['participantes'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      updatedBy: (json['updatedBy'] as num?)?.toInt(),
      updatedAt: json['updatedAt'] as String?,
      tipoCooperacion: json['tipoCooperacion'] as String?,
      fechaFin: json['fechaFin'] == null
          ? null
          : DateTime.parse(json['fechaFin'] as String),
      fechaCreacion: json['fechaCreacion'] == null
          ? null
          : DateTime.parse(json['fechaCreacion'] as String),
    );

Map<String, dynamic> _$CooperacionToJson(Cooperacion instance) =>
    <String, dynamic>{
      'nombre': instance.nombre,
      'descripcion': instance.descripcion,
      'montoObjetivo': instance.montoObjetivo,
      'numeroCuenta': instance.numeroCuenta,
      'fechaInicio': instance.fechaInicio,
      'fechaFin': instance.fechaFin,
      'estado': instance.estado,
      'createdBy': instance.createdBy,
      'montoActual': instance.montoActual,
      'participantes': instance.participantes,
      'updatedBy': instance.updatedBy,
      'updatedAt': instance.updatedAt,
      'tipoCooperacion': instance.tipoCooperacion,
      'idGrupo': instance.idGrupo,
      'idCategoria': instance.idCategoria,
      'fechaCreacion': instance.fechaCreacion,
    };
