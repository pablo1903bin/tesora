// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cooperacion_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CooperacionResponse _$CooperacionResponseFromJson(Map<String, dynamic> json) =>
    CooperacionResponse(
      codigo: json['codigo'] as String,
      mensaje: json['mensaje'] as String,
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$CooperacionResponseToJson(
        CooperacionResponse instance) =>
    <String, dynamic>{
      'codigo': instance.codigo,
      'mensaje': instance.mensaje,
      'data': instance.data,
    };
