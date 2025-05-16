import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tesora/app/domain/models/notifications/notificacion.dart';

class SharedPreferencesService {
  // 🔑 Clave para la lista de notificaciones
  static const String _notificacionesKey = 'notificaciones';

  // Variable privada para manejar las preferencias compartidas.
  SharedPreferences? _prefs;

  // Método para inicializar SharedPreferences. Debe llamarse al iniciar la app.
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Método privado para inicializar el valor de tutorialHome si no existe.
  Future<void> initializeTutorialHome() async {
    final exists = _prefs?.containsKey('tutorialHome') ?? false;
    if (!exists) {
      await _prefs?.setBool('tutorialHome', false);
    }
  }

  // Método para guardar si el usuario ya vio el tutorial de Home.
  Future<void> setTutorialHomeSeen(bool hasSeen) async {
    await _prefs?.setBool('tutorialHome', hasSeen);
  }

  // Método para verificar si el usuario ya vio el tutorial de Home.
  bool hasSeenTutorialHome() {
    //return _prefs!.getBool('tutorialHome')!; // Usa el operador `!` para indicar que nunca será null
    return true;
  }

  Future<void> insertarNotificacion(Notificacion nueva) async {
    final notis = obtenerNotificaciones();
    final actualizadas = [...notis, nueva];
    await guardarNotificaciones(actualizadas);
  }

  Future<void> guardarNotificaciones(List<Notificacion> lista) async {
    final jsonList = lista.map((n) => n.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await _prefs?.setString(_notificacionesKey, jsonString);
  }

  List<Notificacion> obtenerNotificaciones() {
    final jsonString = _prefs?.getString(_notificacionesKey);
    if (jsonString == null) return [];

    final decoded = jsonDecode(jsonString) as List<dynamic>;
    return decoded
        .map((e) => Notificacion.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> borrarTodasLasNotificaciones() async {
    await _prefs?.remove(_notificacionesKey);
  }

  /// Elimina una notificación por su ID
  Future<void> borrarNotificacionPorId(String id) async {
    final notis = obtenerNotificaciones();
    final filtradas = notis.where((n) => n.id != id).toList();
    await guardarNotificaciones(filtradas);
  }

  /// Marca una notificación como leída por su ID
  Future<void> marcarComoLeida(String id) async {
    final notis = obtenerNotificaciones();
    final actualizadas = notis.map((n) {
      return n.id == id ? n.copyWith(leida: true) : n;
    }).toList();
    await guardarNotificaciones(actualizadas);
  }

  /// Marca todas como leídas
  Future<void> marcarTodasComoLeidas() async {
    final notis = obtenerNotificaciones();
    final actualizadas = notis.map((n) => n.copyWith(leida: true)).toList();
    await guardarNotificaciones(actualizadas);
  }

  int contarNoLeidas() {
    return obtenerNotificaciones().where((n) => !n.leida).length;
  }

  Future<void> guardarTokenFCM(String token) async {
    await _prefs?.setString('token_fcm', token);
  }

  String? obtenerTokenFCM() {
    return _prefs?.getString('token_fcm');
  }
}
