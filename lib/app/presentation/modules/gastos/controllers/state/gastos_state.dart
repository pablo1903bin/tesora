import 'package:freezed_annotation/freezed_annotation.dart';

part 'gastos_state.freezed.dart';

@freezed
class GastosState with _$GastosState {
  const factory GastosState({
    // Lista de gastos
    @Default([]) List<dynamic>? gastos,
  }) = _GastosState;
}
