import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesora/app/presentation/controller/theme_controller.dart';
import 'package:tesora/app/presentation/global/controller/validador_field_controller.dart';
import 'package:tesora/app/presentation/modules/caja/controllers/caja_controller.dart';
import 'package:tesora/app/presentation/modules/home/controllers/crear_coperacion_controller.dart';

import '../modules/home/controllers/home_controller.dart';
import '../modules/sign_in/controllers/auth_controller.dart';
import '../modules/usuarios/controllers/usuarios_controller.dart';

mixin ControllersMixin on StatelessWidget {
  ThemeController getThemeController(BuildContext context) {
    return Provider.of<ThemeController>(context, listen: false);
  }

  HomeController getHomeController(BuildContext context) {
    return Provider.of<HomeController>(context, listen: false);
  }
  MenuController getMenuController(BuildContext context) {
    return Provider.of<MenuController>(context, listen: false);
  }
//

  CajaController getCajaController(BuildContext context) {
    return Provider.of<CajaController>(context, listen: false);
  }

  CrearCoperacionController getCrearCooperacionController(
      BuildContext context) {
    return Provider.of<CrearCoperacionController>(context, listen: false);
  }

  UsuariosController getUsuariosController(BuildContext context) {
    return Provider.of<UsuariosController>(context, listen: false);
  }

  AuthController getAuthController(BuildContext context) {
    return Provider.of<AuthController>(context, listen: false);
  }

  ValidadorFieldController getValidadorFild(BuildContext context) {
    return Provider.of<ValidadorFieldController>(context, listen: false);
  }

  bool checkIfProviderExists<P>(BuildContext context) {
    try {
      Provider.of<P>(context, listen: false);
      return true;
    } catch (e) {
      if (e is ProviderNotFoundException) {
        return false;
      }
      rethrow;
    }
  }
}
