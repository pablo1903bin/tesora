import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tesora/app/presentation/global/controller/boton_cargando_controller.dart';

part 'crear_cooperacion_state.freezed.dart';
@freezed
class CrearCooperacionState with _$CrearCooperacionState {
  factory CrearCooperacionState({
    @Default(null) DateTime? fechaFin,
    BotonCargandoController? botonController,
    String? nombre,
    String? descripcion,
    String? montoObjetivo,
    String? numeroCuenta,
    // Inicialización manual
    DateTime? fechaInicio,
  }) {
    return CrearCooperacionState._internal(
      fechaInicio: fechaInicio ?? DateTime.now(), // Fecha actual por defecto
      fechaFin: fechaFin,
      botonController: botonController,
      nombre: nombre,
      descripcion: descripcion,
      montoObjetivo: montoObjetivo,
      numeroCuenta: numeroCuenta,
    );
  }

  const factory CrearCooperacionState._internal({
    required DateTime? fechaInicio,
    DateTime? fechaFin,
    BotonCargandoController? botonController,
    String? nombre,
    String? descripcion,
    String? montoObjetivo,
    String? numeroCuenta,
  }) = _CrearCooperacionState;
}
