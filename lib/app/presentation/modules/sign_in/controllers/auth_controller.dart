import 'package:flutter/widgets.dart';
import 'package:tesora/app/domain/models/loguin/user_loguin_response.dart';
import 'package:tesora/app/presentation/controller/loading_lndicator_controller.dart';
import 'package:tesora/app/presentation/mixin/mmovil_repositorios.dart';

import '../../../../data/providers/auth/state/user_auth_state.dart';
import '../../../../states/state_notifier.dart';

class AuthController extends StateNotifier<UserAuthState>
    with MmovilRepositorios {
  AuthController(super.state);

  void signUserIn(
      TextEditingController user, TextEditingController pass) async {
    loading(true);

    final userResponse = await getAuthenticationRepository.signIn(user.text, pass.text);
    print("[AuthController] Respuesta:  $userResponse ");
    userResponse.when(
      error: (errorUserResponse) {
        loading(false);
        notifica(state.copyWith(codigo: "ERROR"), forzar: true);
      },
      exito: (userLoginResponse) {
        print("Exito al hacer loguin...   🍒 $userLoginResponse");
        guardarDataUser(userLoginResponse);
      },
    );
  }

  void resetValuesState() {
    notifica(state.copyWith(codigo: null));
  }

  // Método para setear los valores del usuario
  void guardarDataUser(UserLoginResponse u) {
    final usuario = UserLoginResponse(
        id: u.id,
        token: u.token!,
        username: u.username!,
        name: u.name,
        apellido: u.apellido,
        telefono: u.telefono,
        email: u.email!,
        role: u.role,
        fechaCreacion: u.fechaCreacion);

    notifica(state.copyWith(userResponse: usuario, codigo: "OK"));
    loading(false);
  }

  // Método para obtener el estado completo
  UserAuthState mostrarDataUser() {
    return state;
  }

  void loading(bool cargar) {
    if (state.loadingIndicatorController != null) {
      if (cargar) {
        state.loadingIndicatorController!.cargando();
      } else {
        state.loadingIndicatorController!.normal();
      }
    }
  }

  void addBotonController(LoadingIndicatorController controller) {
    changeState(state.copyWith(loadingIndicatorController: controller));
  }
}
