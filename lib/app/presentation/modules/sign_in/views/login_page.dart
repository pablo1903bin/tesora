import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tesora/app/presentation/controller/loading_lndicator_controller.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/global/widgets/fields/input_fields/user_field.dart';
import 'package:tesora/app/presentation/global/widgets/password_field.dart';
import 'package:tesora/app/presentation/mixin/i18n_mixin.dart';
import 'package:tesora/app/presentation/modules/sign_in/controllers/auth_controller.dart';
import 'package:tesora/app/presentation/modules/sign_in/widgets/new_user.dart';
import 'package:tesora/app/presentation/modules/sign_in/widgets/titulo.dart';
import 'package:tesora/app/presentation/routes/route_path.dart';
import 'package:tesora/gen/i18n/translations_mobil.g.dart';

import '../../../mixin/controllers_mixin.dart';
import '../widgets/loguin_error_dialog.dart';
import '../widgets/my_button.dart';

class LoginPage extends StatelessWidget with ControllersMixin, I18NMixin {

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

                  final state = authController.state;

                  if (state.codigo != null && state.codigo! != "OK") {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      LoginErrorDialog.mostrar(
                        context, authController,
                      );
                      //authController.resetValuesState();
                    });
                  }

                  if (state.userResponse == null) {
                    return _buildLoginForm(context, authController);
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

  Widget _buildLoginForm(BuildContext context, AuthController controller) {
    return Consumer<LoadingIndicatorController>(
      builder: (context, loadingController, child) {
        
        getAuthController(context).addBotonController(loadingController);

        return Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                _buildLogo(),
                _buildTitulo(),
                const SizedBox(height: 50),
                _buildBienvenida(),
                const SizedBox(height: 45),
                _buildUsuarioField(),
                const SizedBox(height: 15),
                _buildPasswordField(),
                const SizedBox(height: 40),
                _buildOlvidoContrasena(context),
                const SizedBox(height: 20),
                _buildBotonLogin(controller),
                const SizedBox(height: 60),
                _buildRegisterRow(context),
                const SizedBox(height: 70),
              ],
            ),
            if (loadingController.state.cargando) _buildCargandoOverlay(),
          ],
        );
      },
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'lib/app/images/logo_tesoreria.png',
      width: 150,
      height: 150,
    );
  }

  Widget _buildTitulo() {
    return Titulo(titulo: i18n.loguin.app_title);
  }

  Widget _buildBienvenida() {
    return Text(
      i18n.loguin.welcome_back,
      style: const TextStyle(
        color: colorPrincipal,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildUsuarioField() {
    return UserTextField(
      controller: usernameController,
      onChanged: (value) {},
    );
  }

  Widget _buildPasswordField() {
    return PasswordField(
      label: i18n.loguin.sign_in_button,
      onChanged: (value) {
        passwordController.text = value;
      },
      validacionEnabled: false,
      onValidacion: (value, controller) {
        if (value.isEmpty) {}
      },
    );
  }

  Widget _buildOlvidoContrasena(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          TranslationsCommons.of(context).loguin.forgot_password,
          style: const TextStyle(color: colorAlterno4),
        ),
      ),
    );
  }

  Widget _buildBotonLogin(AuthController controller) {
    return MyButton(
      onTap: () {
        controller.signUserIn(
          usernameController.text,
          passwordController.text,
        );
      },
    );
  }

  Widget _buildRegisterRow(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Align(
        alignment: Alignment.center,
        child: RegisterRow(),
      ),
    );
  }

  Widget _buildCargandoOverlay() {
    return Positioned.fill(
      child: Container(
        color: colorAlterno5.withOpacity(0.5),
        child: const Center(
          child: CircularProgressIndicator(
            color: colorPrincipal,
          ),
        ),
      ),
    );
  }
}
