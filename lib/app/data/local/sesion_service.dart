import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'session_id';

// Clase que maneja la gestión de un identificador de sesión (SessionID) utilizando almacenamiento seguro
class SesionService {
  // Dependencia para manejar el almacenamiento seguro
  final FlutterSecureStorage _secureStorage;

  // Constructor que recibe una instancia de FlutterSecureStorage como dependencia
  SesionService({required FlutterSecureStorage secureStorage}) : _secureStorage = secureStorage;

  // Método para obtener el SessionID almacenado en el almacenamiento seguro
  Future<String?> getSessionID() async {
    // Lee el valor asociado con la clave `_key` desde el almacenamiento seguro
    final sid = await _secureStorage.read(key: _key);
    // Retorna el identificador de sesión (o null si no existe)
    return sid;
  }

  // Método para escribir (guardar) un nuevo SessionID en el almacenamiento seguro
  Future<void> writeSessionID(String sesionID) {
    // Guarda el valor `sesionID` en el almacenamiento seguro asociado con la clave `_key`
    return _secureStorage.write(key: _key, value: sesionID);
  }

  // Método para eliminar el SessionID del almacenamiento seguro
  Future deleteSessionID() {
    // Borra el valor asociado con la clave `_key` del almacenamiento seguro
    return _secureStorage.delete(key: _key);
  }
}
