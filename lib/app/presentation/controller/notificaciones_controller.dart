import 'package:tesora/app/domain/models/notifications/notificacion.dart';
import 'package:tesora/app/states/state_notifier.dart';
import 'package:uuid/uuid.dart';

import '../mixin/mixin_repositorios_comunes.dart';
import 'states/notificaciones_state.dart';

class NotificacionesController extends StateNotifier<NotificacionesState> with RepositoriosComunes {
  NotificacionesController(super.inicial) {
    _cargarDesdeStorage();
  }

  final _uuid = const Uuid();

  void agregar({required String titulo, required String mensaje}) {
    final actuales = sharedPreferencesService.obtenerNotificaciones();

    final existe = actuales.any((n) => n.titulo == titulo && n.mensaje == mensaje);

    if (existe) {
      print("⛔ Notificación duplicada ignorada");
      return;
    }

    final nueva = Notificacion(
      id: _uuid.v4(),
      titulo: titulo,
      mensaje: mensaje,
      fecha: DateTime.now(),
    );

    final actualizadas = [...actuales, nueva];

    print("✅ Nueva notificación guardada: $titulo");

    notificaccionesRepository.agregar(nueva);
    //sharedPreferencesService.guardarNotificaciones(actualizadas);
    notifica(state.copyWith(lista: actualizadas));
  }

  void _cargarDesdeStorage() async{

   // final notis = sharedPreferencesService.obtenerNotificaciones();
   final notis = notificaccionesRepository.obtenerTodas();
    notifica(state.copyWith(lista: notis));
  }

  Future<void> limpiarTodo() async {
    await sharedPreferencesService.borrarTodasLasNotificaciones();
    notifica(state.copyWith(lista: []));
  }

  void eliminarNotificacion(String id) {
    final nuevas = state.lista.where((n) => n.id != id).toList();
    sharedPreferencesService.guardarNotificaciones(nuevas);
    notifica(state.copyWith(lista: nuevas));
  }

  Future<void> marcarComoLeida(String id) async {
    // ✅ Leer la lista real desde almacenamiento persistente
    final actuales = sharedPreferencesService.obtenerNotificaciones();

    // ✅ Marcar como leída
    final actualizadas = actuales.map((n) {
      return n.id == id ? n.copyWith(leida: true) : n;
    }).toList();

    // ✅ Guardar la nueva lista persistida
    sharedPreferencesService.guardarNotificaciones(actualizadas);

    // ✅ Actualizar el estado
    notifica(state.copyWith(lista: actualizadas));
  }

  void eliminar(String id) {
    final filtradas = state.lista.where((n) => n.id != id).toList();
    notifica(state.copyWith(lista: filtradas));
  }

  void limpiarLeidas() {
    final pendientes = state.lista.where((n) => !n.leida).toList();
    notifica(state.copyWith(lista: pendientes));
  }
}
