


import 'package:tesora/app/presentation/global/controller/state/mask_field_state.dart';
import 'package:tesora/app/presentation/global/mixin/validador_field_mixin.dart';
import 'package:tesora/app/states/state_notifier.dart';


class MaskFieldController extends StateNotifier<MaskFieldState> with ValidadorFieldMixin {
  MaskFieldController(super.state);

  void onPress() {
    notifica(
      state.copyWith(enmascarar: false)
    );
  }

  void onRelease(){
    notifica(
      state.copyWith(enmascarar: true)
    );
  }

  @override
  String? validaPassword(String? value) {
    value ??= "";

    if(state.forzarError || value.isEmpty){
      return "Error";
    }

    return null;
  }

}

