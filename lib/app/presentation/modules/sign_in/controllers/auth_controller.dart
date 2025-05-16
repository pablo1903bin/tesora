import 'package:tesora/app/domain/models/loguin/user_loguin_response.dart';
import 'package:tesora/app/domain/models/server_response/mmovil_v1_response.dart';
import 'package:tesora/app/presentation/controller/loading_lndicator_controller.dart';
import 'package:tesora/app/presentation/mixin/mixin_repositorios_comunes.dart';
import 'package:tesora/app/presentation/mixin/mmovil_repositorios.dart';

import '../../../../data/providers/auth/state/user_auth_state.dart';
import '../../../../domain/failures/loguin/login_user_failure.dart';
import '../../../../domain/models/usuario/crear_usuario_request.dart';
import '../../../../domain/models/usuario/register_response.dart';
import '../../../../states/state_notifier.dart';
import '../../../failures/http_failure_unwrap.dart';
import '../../../mixin/i18n_mixin.dart';

class AuthController extends StateNotifier<UserAuthState> with MmovilRepositorios, RepositoriosComunes, HttpFailureUnwrap, I18NMixin {
  AuthController(super.state);

  void signUserIn(String user, String pass) async {
    loading(true);

    final userResponse = await getAuthenticationRepository.signIn(user, pass);
    userResponse.when(
      error: (error) {
        // Manejo de errores
        if (error.maybeWhen(sinInternet: () => true, orElse: () => false)) {
            notifica(state.copyWith(codigo: "ERROR", responseGeneral: MmovilV1Response("ERROR", null, mensaje: i18n.http_errors.network),
          ));
        } 
        else if (error.maybeWhen(servidorNoEncontrado: () => true, orElse: () => false)) {
              notifica(state.copyWith(codigo: "ERROR",responseGeneral: MmovilV1Response("ERROR", null, mensaje: i18n.http_errors.not_found)));
        }
        else if (error.maybeWhen(errorDeNegocio: (codigo, mensaje) => true, orElse: () => false)) {
          notifica(state.copyWith(codigo: "ERROR",responseGeneral: MmovilV1Response("ERROR", null, mensaje: i18n.loguin.authentication_error.content), 
          ));
        } else {
          final msj = _handleLoginFailure(error); 
          notifica(state.copyWith( codigo: "ERROR", responseGeneral: MmovilV1Response("ERROR", null, mensaje: msj), ));
        }

        loading(false);
      },
      exito: (userLoginResponse) {
        guardarDataUser(userLoginResponse);
      },
    );
  }

  String _handleLoginFailure(LoginUserFailure failure) {
    return failure.when(
      invalidCredentials: () => "Credenciales inválidas",
      redirectionDetectada: () => "Redirección detectada",
      sinInternet: () => "Sin conexión a Internet",
      servidorNoEncontrado: () => "Servidor no encontrado",
      errorInterno: () => "Error interno del servidor",
      errorDeCliente: () => "Error de cliente",
      errorDesconocido: () => "Error desconocido",
      custom: (codigo, _) => codigo.toString(),
      errorDeNegocio: (codigo, _) => codigo,
      httpFailure: (httpFailure) => "HTTP:",
      unexpected: () => "Error inesperado",
    );
  }

  void resetValuesState() {
    notifica(state.copyWith(codigo: null, responseGeneral: null));
  }

  Future<void> registerUser(CrearUsuarioRequest request) async {
    final result = await getAuthenticationRepository.register(request);

    result.when(
      exito: (response) {
        if (response is Map<String, dynamic>) {
          // Transformar la respuesta en un objeto RegisterResponse
          final registerResponse = RegisterResponse.fromJson(response);
          notifica(state.copyWith(registerResponse: registerResponse));
        }
      },
      error: (failure) {},
    );
  }

  // Método para setear los valores del usuario
  // Método para setear los valores del usuario
  void guardarDataUser(UserLoginResponse u) {
    secureStorageService.writeValue("token", u.token!);
    secureStorageService.writeValue("username", u.username!);
    secureStorageService.writeValue("email", u.email!);
    secureStorageService.writeValue("name", u.name!);
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
