import 'package:tesora/app/data/http/http.dart';
import 'package:tesora/app/data/services/remote/cooperacion_api.dart';
import 'package:tesora/app/domain/failures/cooperacion/cooperacion_failure.dart';
import 'package:tesora/app/domain/failures/http/http_failure_mapper.dart';
import 'package:tesora/app/domain/failures/http/http_request_failure.dart';
import 'package:tesora/app/domain/functional/respuesta.dart';
import 'package:tesora/app/domain/models/cooperacion/cooperacion_response.dart';
import 'package:tesora/app/domain/models/cooperacion/crear_cooperacion_dto.dart';
import 'package:tesora/app/domain/repositories/cooperacion_repository.dart';

class CooperacionRepositoryImpl with HttpFailureMapper implements CooperacionRepository {

  final CooperacionApi _cooperacionApi;

  // Constructor
  CooperacionRepositoryImpl( this._cooperacionApi);

  @override
  Future<Respuesta<CooperacionFailure, CooperacionResponse>> guardarCooperacion(
      CrearCooperacionDto cooperacionDto) async {
    final result = await _cooperacionApi.crearCooperacion(
      cooperacionData: cooperacionDto.toJson(),
    );

    return result.when(
      error: _onRequestError,
      exito: (response) {
       return Respuesta.exito(response);
      },
    );
  }

  // Manejo de errores utilizando HttpFailureMapper
  Respuesta<CooperacionFailure, T> _onRequestError<T>(HttpFailure error) {
    return mapFailure<Respuesta<CooperacionFailure, T>>(
        error, _failureWithCooperacion);
  }

  Respuesta<CooperacionFailure, T> _failureWithCooperacion<T>(
      HttpRequestFailure failure) {
    return Respuesta.error(CooperacionFailure.httpFailure(failure));
  }
}
