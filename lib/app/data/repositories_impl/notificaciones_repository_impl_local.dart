


import 'package:tesora/app/data/local/shared_preferences_service.dart';
import 'package:tesora/app/domain/models/notifications/notificacion.dart';
import 'package:tesora/app/domain/repositories/notificaciones_repository.dart';

class NotificacionesRepositoryImplLocal implements NotificacionesRepository {
  final SharedPreferencesService _prefs;

  NotificacionesRepositoryImplLocal(this._prefs);

  @override
  List<Notificacion> obtenerTodas() => _prefs.obtenerNotificaciones();

  @override
  Future<void> guardarTodas(List<Notificacion> lista) async =>
      _prefs.guardarNotificaciones(lista);

  @override
  Future<void> eliminar(String id) async {
    final actual = _prefs.obtenerNotificaciones();
    final nuevas = actual.where((n) => n.id != id).toList();
    await _prefs.guardarNotificaciones(nuevas);
  }

  @override
  Future<void> agregar(Notificacion notificacion) async {
    final actual = _prefs.obtenerNotificaciones();
    await _prefs.guardarNotificaciones([...actual, notificacion]);
  }

  @override
  Future<void> marcarComoLeida(String id) async {
    final actual = _prefs.obtenerNotificaciones();
    final actualizadas = actual.map((n) {
      return n.id == id ? n.copyWith(leida: true) : n;
    }).toList();
    await _prefs.guardarNotificaciones(actualizadas);
  }
  
  @override
  Future<void> agregarTokenFCM(String token) {
    // TODO: implement agregarTokenFCM
    throw UnimplementedError();
  }
}
  