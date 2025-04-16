import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../data/providers/auth/state/user_auth_state.dart';
import '../../modules/sign_in/controllers/auth_controller.dart';
import '../../modules/usuarios/views/crear_usuario_view.dart';
import '../../modules/usuarios/views/user_details_view.dart';
import '../../modules/usuarios/views/usuarios_view.dart';
import '../go_route_helper.dart';
import '../route_path.dart';

class UsuariosRoutes {
  //
  static GoRoute get usuarios {
    return GoRoute(
      path: RoutePath.listarUsuarios,
      builder: (context, state) {
        return const UsuariosView();
      },
    );
  }

//
  static GoRoute get userDetails {
    return GoRoute(
        path: RoutePath.userDetails,
        builder: (context, state) {
          return const UserDetailsScreen();
        });
  }

  static GoRoute get crearUsuario {
    return GoRouteHelper.goRouteMulti(
      RoutePath.crearUsuarios,
      () => const CrearUsuarioView(),
      [
        GoRouteHelper.c<AuthController>(
          () => AuthController( UserAuthState()),
        ),
      ],
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        );

        return FadeTransition(
          opacity: curvedAnimation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(curvedAnimation),
            child: child,
          ),
        );
      },
    );
  }
}
