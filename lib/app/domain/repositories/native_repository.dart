import 'dart:async';

import '../failures/token/token_failure.dart';
import '../functional/respuesta.dart';

abstract class NativeRepository {
  Future<void> mostrarToast({String? msj});

  Future<Respuesta<TokenFailure, String>> getToken();

  Future<int?> obtenerPorcentajeCargaBateria();

  Future<String?> getSOVersion();


}
