import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../domain/failures/token/token_failure.dart';
import '../../domain/functional/respuesta.dart';
import '../../domain/repositories/native_repository.dart';
import '../services/device/native_services.dart';


class NativeRepositoryImpl implements NativeRepository {
  NativeService service;

  NativeRepositoryImpl(this.service);


  static Future<void> initNotifications() async {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  Future<void> mostrarToast({String? msj}) async {
    await service.mostrarToastNativo(msj: msj);
  }

  @override
  Future<Respuesta<TokenFailure, String>> getToken() async {
    String? token = await service.getToken();
    if (token != null) {
      if (token == "cancelo") {
        return Respuesta.error(TokenFailure.cancelo());
      }

      return Respuesta.exito(token);
    }

    return Respuesta.error(TokenFailure.notFound());
  }

  @override
  Future<int?> obtenerPorcentajeCargaBateria() {
    final batPor = service.getBatteryLevel();
    return batPor;
  }

  @override
  Future<String?> getSOVersion() {
    final batPor = service.getSOVersion();
    return batPor;
  }
}
