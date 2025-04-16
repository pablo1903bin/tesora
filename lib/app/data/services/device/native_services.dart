import 'package:flutter/services.dart';
import 'package:tesora/app/domain/models/home/model.dart';

class NativeService {
  final MethodChannel? platform;

  NativeService({required this.platform});

  checkPermision() {}

  requestPermision() {}

  start() {}
  stop() {}

Future<void> programarAlarmaMedica({required Model model}) async {

  if (platform == null) {
    return;
  }

    // Convertir `Model` a un `Map<String, dynamic>`
    Map<String, dynamic> alarmaMap = model.toJson();

    await platform!.invokeMethod('crearAlarma', {'alarma': alarmaMap});

}


  Future<void> mostrarToastNativo({String? msj}) async {
    msj = msj ?? "Hola desde flutter!";

    if (platform == null) {
      return; // Manejo en caso de que no haya plataforma configurada
    }
  
      await platform!.invokeMethod('mostrarToast', {'message': msj});
  
  }

  // Método para obtener el nivel de batería
  Future<String?> getSOVersion() async {
    if (platform == null) {
      return null; // Manejo en caso de que no haya plataforma configurada
    }

      // Llama al método nativo para obtener el nivel de batería
      final String soVersion = await platform!.invokeMethod("getOSVersion");

      return soVersion;
  
  }

  // Método para obtener el nivel de batería
  Future<int?> getBatteryLevel() async {
    if (platform == null) {
      return null; // Manejo en caso de que no haya plataforma configurada
    }

  
      // Llama al método nativo para obtener el nivel de batería
      final int batteryLevel = await platform!.invokeMethod("getBatteryLevel");

      return batteryLevel;
  
  }

  Future<String?> getToken() async {
    if (platform == null) {
      return "valido";
      //return "cancelo";
      //return null;
    }

    final Map<dynamic, dynamic> params =
        await platform!.invokeMethod("getToken");

    if (params.containsKey("token")) {
      return params["token"];
    }

    return null;
  }
}
