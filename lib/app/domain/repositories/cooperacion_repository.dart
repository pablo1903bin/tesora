import 'package:tesora/app/domain/failures/cooperacion/cooperacion_failure.dart';
import 'package:tesora/app/domain/functional/respuesta.dart';
import 'package:tesora/app/domain/models/cooperacion/cooperacion_response.dart';
import 'package:tesora/app/domain/models/cooperacion/crear_cooperacion_dto.dart';

 abstract class CooperacionRepository {

  Future<Respuesta<CooperacionFailure, CooperacionResponse>> guardarCooperacion(CrearCooperacionDto cooperacionDto);


}