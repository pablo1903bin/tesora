
import 'package:go_router/go_router.dart';
import 'package:tesora/app/presentation/routes/caja/caja_routes.dart';
import 'package:tesora/app/presentation/routes/cooperacion/cooperacion_routes.dart';
import 'package:tesora/app/presentation/routes/gastos/gasto_routes.dart';
import 'package:tesora/app/presentation/routes/settings/setting_route.dart';
import 'package:tesora/app/presentation/routes/text_scann/text_route.dart';

import '../modules/usuarios/controllers/state/usuarios_state.dart';
import '../modules/usuarios/controllers/usuarios_controller.dart';
import '../modules/usuarios/views/usuarios_view.dart';
import 'bloqueo/cuenta_bloqueo_routes.dart';
import 'go_route_helper.dart';
import 'home/home_routes.dart';
import 'loguin/loguin_routes.dart';
import 'offline/offline_route.dart';
import 'route_path.dart';
import 'splash/splash_route.dart';
import 'usuarios/usuarios_routes.dart';

mixin Routes {
  final GoRouter _router = GoRouter(
    initialLocation: RoutePath.inicial,
    routes: [
      SplashRoute.splashRoute,
      OfflineRoute.offlineRoute,
      LoguinRoutes.loguin,
      HomeRoutes.home,

      CooperacionRoutes.crearCooperacion,
      CooperacionRoutes.coperaciones,
          CooperacionRoutes.coperacionDetalle,

      UsuariosRoutes.usuarios,
      UsuariosRoutes.userDetails,
      UsuariosRoutes.crearUsuario,
      GastoRoutes.gastos,
            GastoRoutes.gasto,

      SettingRoute.settings,
      CajaRoutes.caja,
      CuentaBloqueoRoutes.bloqueo,
      TextRoute.text,
      GoRouteHelper.goRoute<UsuariosController>(
        RoutePath.listarUsuarios,
        () => const UsuariosView(),
        controller: () => UsuariosController(UsuariosState(
              "Inicial",
              "Algo mas",
              "super",
              permisos: [Permiso(1, "usuario")],
              titulo: "Mr"))),
    ],
  );

  GoRouter get router => _router; // Getter para obtener el enrutador
}
