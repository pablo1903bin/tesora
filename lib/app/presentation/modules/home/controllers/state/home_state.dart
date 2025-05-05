import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tesora/app/domain/models/home/model.dart';
import 'package:tesora/app/domain/models/recordatorios/recordatorio_response.dart';
import 'package:tesora/app/presentation/global/controller/boton_cargando_controller.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool? turorialHome,
    @Default(0.0) double? totalCaja,
    @Default(0.0) double? ingresosTotal,
    @Default(0.0) double? gastosTotal,
    //Tabs Ingreso 1 Gasto 0
    @Default(1) int? ingresoGasto,
    BotonCargandoController? botonController,
    int? level,
    @Default("") String? version,
    RecordatorioResponse? recordatorioResponse,
    List<Model>? listaAlarmas,
    @Default(true) bool? mostrarTutorial,
  }) = _HomeState;
}
