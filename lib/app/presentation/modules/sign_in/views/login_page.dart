import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tesora/app/presentation/controller/loading_lndicator_controller.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/global/widgets/fields/input_fields/user_field.dart';
import 'package:tesora/app/presentation/global/widgets/password_field.dart';
import 'package:tesora/app/presentation/mixin/i18n_mixin.dart';
import 'package:tesora/app/presentation/modules/sign_in/controllers/auth_controller.dart';
import 'package:tesora/app/presentation/modules/sign_in/widgets/loguin_error_dialog.dart';
import 'package:tesora/app/presentation/modules/sign_in/widgets/new_user.dart';
import 'package:tesora/app/presentation/modules/sign_in/widgets/titulo.dart';
import 'package:tesora/app/presentation/routes/route_path.dart';
import 'package:tesora/gen/i18n/translations_mobil.g.dart';

import '../../../mixin/controllers_mixin.dart';
import '../widgets/my_button.dart';

class LoginPage extends StatelessWidget with ControllersMixin, I18NMixin {
  /* _ */
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorSueve,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Center(
              child: Consumer<AuthController>(
                builder: (context, authController, child) {
                  // print("🙌  Estado:  ${authController.state}");
                  final state = authController.state;

                  if (state.codigo != null && state.codigo! == "ERROR") {
  
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      LoginErrorDialog.mostrar(
                        context,
                        mensaje:
                            'El usuario o la contraseña son incorrectos. Inténtalo de nuevo.',
                      );
                    });
                    authController.resetValuesState();
                  }

                  if (state.userResponse == null) {
                    return _getColumn(context, authController);
                  }

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    context.go(RoutePath.home);
                  });

                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getColumn(BuildContext context, AuthController controller) {
    return Consumer<LoadingIndicatorController>(
      builder: (context, loadingController, child) {
        getAuthController(context).addBotonController(loadingController);

        return Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Image.asset(
                  'lib/app/images/logo_tesoreria.png',
                  width: 150,
                  height: 150,
                ),
                Titulo(
                    titulo: TranslationsCommons.of(context).loguin.app_title),
                const SizedBox(height: 30),
                Text(
                  TranslationsCommons.of(context).loguin.welcome_back,
                  style: const TextStyle(
                    color: colorPrincipal,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 25),
                UserTextField(
                  controller: usernameController,
                  onChanged: (value) {
                    // print('Usuario: $value');
                  },
                ),
                const SizedBox(height: 15),
                PasswordField(
                  label: 'Contraseña',
                  onChanged: (value) {
                    passwordController.text = value;
                  },
                  validacionEnabled: true,
                  onValidacion: (value, controller) {
                    if (value.isEmpty) {
                      controller.state.copyWith(forzarError: true);
                    }
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      TranslationsCommons.of(context).loguin.forgot_password,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                MyButton(onTap: () {
                  controller.signUserIn(usernameController, passwordController);
                }),
                const SizedBox(height: 60),
                RegisterRow(
                  text: TranslationsCommons.of(context),
                ),
                const SizedBox(height: 40),
              ],
            ),
            if (loadingController.state.cargando) ...[
              Positioned.fill(
                child: Container(
                  color: colorAlterno5.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: colorPrincipal,
                    ),
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
