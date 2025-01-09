


import 'package:tesora/app/presentation/global/controller/state/boton_cargando_state.dart';
import 'package:tesora/app/states/state_notifier.dart';

class BotonGuardarCoopController extends StateNotifier<BotonCargandoState> {
  BotonGuardarCoopController(super.state);


  void cargando(){

    notifica(state.copyWith(cargando: true));
  }

  void normal(){

    notifica(state.copyWith(cargando: false));
  }

  void activa(){
    notifica(state.copyWith(activo: true));
  }

  void desactiva(){
    notifica(state.copyWith(activo: false));
  }

  void mostrar() {
    notifica(state.copyWith(visible: true));
  }

  void ocultar() {
    notifica(state.copyWith(visible: false));
  }
}
