import 'package:shared_preferences/shared_preferences.dart';

// Clase que gestiona el acceso y uso de SharedPreferences en toda la aplicación
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
    SharedPreferencesService._internal();

    // Método para inicializar SharedPreferences. Debe llamarse al iniciar la app.
    Future<void> init() async {
        _prefs = await SharedPreferences.getInstance();
    }

    // Método para guardar si el modo oscuro está habilitado o no.
    Future<void> setDarkMode(bool isDarkMode) async {
        await _prefs?.setBool('darkMode', isDarkMode); // Almacena un booleano con clave 'darkMode'.
    }

    // Método para recuperar el valor de 'darkMode'. Devuelve `false` si no existe el valor.
    bool getDarkMode() {
        return _prefs?.getBool('darkMode') ?? false; // Retorna `false` como valor predeterminado.
    }

    // Método para guardar datos del usuario (nombre y correo electrónico).
    Future<void> saveUserData(String username, String email) async {
        await _prefs?.setString('username', username); // Almacena el nombre de usuario con clave 'username'.
        await _prefs?.setString('email', email); // Almacena el email con clave 'email'.
    }

    // Método para recuperar los datos del usuario (nombre y correo electrónico).
    // Devuelve un mapa con las claves 'username' y 'email'.
    Map<String, String?> getUserData() {
        return {
            'username': _prefs?.getString('username'), // Obtiene el nombre de usuario.
            'email': _prefs?.getString('email'), // Obtiene el email.
        };
    }
}
