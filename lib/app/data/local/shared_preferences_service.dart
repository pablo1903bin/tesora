import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  // Instancia estática única de esta clase (Singleton Pattern).
  static final SharedPreferencesService _instance = SharedPreferencesService._internal();

  // Constructor de fábrica que retorna siempre la misma instancia de la clase.
  factory SharedPreferencesService() {
    return _instance;
  }

  // Variable privada para manejar las preferencias compartidas.
  SharedPreferences? _prefs;

  // Constructor privado, solo accesible dentro de esta clase, para garantizar el patrón Singleton.
  SharedPreferencesService._internal() {
    initializeTutorialHome(); // Llamar al método de inicialización automáticamente
  }

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
}
