import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // Instancia singleton de la clase
  static final SecureStorageService _instance = SecureStorageService._internal();

  // Constructor privado
  SecureStorageService._internal();

  // Factory para obtener la instancia única
  factory SecureStorageService() {
    return _instance;
  }

  // Instancia de FlutterSecureStorage
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Escribe un valor en el almacenamiento seguro
  Future<void> writeValue(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  // Lee un valor del almacenamiento seguro
  Future<String?> readValue(String key) async {
    return await _secureStorage.read(key: key);
  }

  // Elimina un valor del almacenamiento seguro
  Future<void> deleteValue(String key) async {
    await _secureStorage.delete(key: key);
  }

  // Limpia todo el almacenamiento seguro
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }
}
