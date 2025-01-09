import 'dart:convert';

import 'package:http/http.dart';
import 'package:tesora/app/domain/models/cooperacion/cooperacion_response.dart';

import '../../../domain/functional/respuesta.dart';
import '../../http/http.dart';
import '../../http/http_app_flutter.dart';

class CooperacionApi {
  final HttpAppFlutter _http;
  
  // Constructor con dependencias
  CooperacionApi({HttpAppFlutter? http})
      : _http = http ??
            HttpAppFlutter(
                client: Client(),
                hostApi: "http://45.33.13.164:8080/gateway/api");

  // Método para crear cooperación
  Future<Respuesta<HttpFailure, CooperacionResponse>> crearCooperacion({
    required Map<String, dynamic> cooperacionData,
  }) async {
    print("Datos de cooperación: $cooperacionData");
    return await _http.request<CooperacionResponse>(
      "/cooperacion/crear",
      method: HttpMethod.post,
      headers: {
        "Content-Type": "application/json",
      },
      body: cooperacionData,
      procesaExito: (json) {
        return CooperacionResponse.fromJson(jsonDecode(json));
      },
    );
  }
}
