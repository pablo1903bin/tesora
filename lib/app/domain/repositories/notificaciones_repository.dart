


import 'package:tesora/app/domain/models/notifications/notificacion.dart';

abstract class NotificacionesRepository {

  List<Notificacion> obtenerTodas();
  Future<void> guardarTodas(List<Notificacion> lista);
  Future<void> eliminar(String id);
  Future<void> agregar(Notificacion notificacion);
  Future<void> marcarComoLeida(String id);

    Future<void> agregarTokenFCM(String token);
  
}
