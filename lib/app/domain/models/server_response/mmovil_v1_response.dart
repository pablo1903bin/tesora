

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tesora/app/domain/models/loguin/user_loguin_response.dart';

part 'mmovil_v1_response.freezed.dart';
part 'mmovil_v1_response.g.dart';

@freezed
class MmovilV1Response with _$MmovilV1Response {

  factory MmovilV1Response(
    @JsonKey(name: "cR") String codigo, 
    @JsonKey(name: "m") String mensaje,
    UserLoginResponse? data
  ) = _MmovilV1Response;

  factory MmovilV1Response.fromJson(Map<String, dynamic> json) => _$MmovilV1ResponseFromJson(json);
}