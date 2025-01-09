import 'package:json_annotation/json_annotation.dart';

part 'cooperacion_response.g.dart';

@JsonSerializable()
class CooperacionResponse {
  final String codigo;
  final String mensaje;
  final Map<String, dynamic> data;

  CooperacionResponse({
    required this.codigo,
    required this.mensaje,
    required this.data,
  });

  factory CooperacionResponse.fromJson(Map<String, dynamic> json) =>
      _$CooperacionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CooperacionResponseToJson(this);
}
