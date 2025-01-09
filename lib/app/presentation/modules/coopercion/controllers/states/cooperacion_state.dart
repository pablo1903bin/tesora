import 'package:freezed_annotation/freezed_annotation.dart';

part 'cooperacion_state.freezed.dart';

@freezed
class CooperacionState with _$CooperacionState {
  const factory CooperacionState({
    @Default([]) List<dynamic>? cooperaciones, // Lista de cooperaciones inicializada como vacía
  }) = _CooperacionState;
}
