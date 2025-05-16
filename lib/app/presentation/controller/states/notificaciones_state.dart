

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/notifications/notificacion.dart';

part 'notificaciones_state.freezed.dart';

@freezed
class NotificacionesState with _$NotificacionesState {

  const factory NotificacionesState({
    @Default([]) List<Notificacion> lista,
    @Default(false) bool cargando,
    String? error,
  }) = _NotificacionesState;
  
}
