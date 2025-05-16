import 'package:freezed_annotation/freezed_annotation.dart';

part 'sesion_state.freezed.dart';

@freezed
class SesionState with _$SesionState {

  factory SesionState(
    String usuario,
    String sessionID,
        String token,
    List<String> cookies
  ) = _SesionState;

}