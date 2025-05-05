


import 'package:tesora/app/domain/models/cooperacion/crear_cooperacion_dto.dart';
import 'package:tesora/app/presentation/global/controller/boton_cargando_controller.dart';
import 'package:tesora/app/presentation/mixin/i18n_mixin.dart';
import 'package:tesora/app/presentation/mixin/mixin_repositorios_comunes.dart';
import 'package:tesora/app/presentation/mixin/mmovil_repositorios.dart';
import 'package:tesora/app/presentation/modules/home/controllers/state/crear_cooperacion_state.dart';
import 'package:tesora/app/states/state_notifier.dart';

import '../../../failures/http_failure_unwrap.dart';

class CrearCoperacionController extends StateNotifier<CrearCooperacionState>
    with MmovilRepositorios, HttpFailureUnwrap, I18NMixin, RepositoriosComunes {
  CrearCoperacionController(super.state);

  Future<bool> guardarCooperacion() async {
    _loading(true); // Simula inicio del loading

    final dto = CrearCooperacionDto(
      nombre: state.nombre,
      descripcion:state.descripcion,
      montoObjetivo: state.montoObjetivo, // String según el DTO
      numeroCuenta: state.numeroCuenta,
      fechaInicio: DateTime.parse("2024-06-17T12:45:00Z"),
      fechaFin: DateTime.parse("2024-06-17T12:45:00Z"),
      //estado: "ACTIVO",
      createdBy: 1,
      montoActual: 0.0,
      // participantes: [102, 103, 104],
      updatedBy: 1,
      updatedAt: "2024-06-17T12:45:00Z",
      tipoCooperacion: "infraestructura",
      fechaCreacion: DateTime.parse("2024-12-17T12:12:55.780Z"),
      idGrupo: 3,
      idCategoria: 1,
    );

    final response = await coperacionRepository.guardarCooperacion(dto);

    return response.when(
      exito: (data) {
        _loading(false);
        return true;
      },
      error: (failure) {

        _loading(false);
        return false;
      },
    );
  }

  void addBotonController(BotonCargandoController controller) {
    changeState(state.copyWith(botonController: controller));
  }

  void actualizarNombre(String nombre) {
    notifica(state.copyWith(nombre: nombre));
  }

  void actualizarDescripcion(String descripcion) {
    notifica(state.copyWith(descripcion: descripcion));
  }

  void actualizarMontoObjetivo(String monto) {
    notifica(state.copyWith(montoObjetivo: monto));
  }

  void actualizarNumeroCuenta(String cuenta) {
    notifica(state.copyWith(numeroCuenta: cuenta));
  }

  void actualizarFechaInicio(DateTime fecha) {
    notifica(state.copyWith(fechaInicio: fecha));
  }

  void actualizarFechaFin(DateTime fecha) {
    notifica(state.copyWith(fechaFin: fecha));
  }

  void _loading(bool cargar) {
    if (state.botonController != null) {
      if (cargar) {
        state.botonController!.cargando();
      } else {
        state.botonController!.normal();
      }
    }
  }
}
