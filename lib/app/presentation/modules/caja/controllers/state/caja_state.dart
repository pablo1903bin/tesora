import 'package:freezed_annotation/freezed_annotation.dart';

part 'caja_state.freezed.dart';

@freezed
class CajaState with _$CajaState {
  const factory CajaState({
    @Default(0) int bnbIndex, // Índice predeterminado
  }) = _CajaState;
}
