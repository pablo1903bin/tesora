import 'package:flutter/material.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';

import '../../../mixin/i18n_mixin.dart';
import '../controllers/auth_controller.dart';

class LoginErrorDialog extends StatelessWidget with  I18NMixin {
  final AuthController controller;

  const LoginErrorDialog({
    super.key,
    required this.controller,
  });

  static void mostrar(BuildContext context, AuthController controller) {
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LoginErrorDialog(controller: controller);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: colorSueve,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icono de advertencia
            Container(
              decoration: BoxDecoration(
                color: colroError2,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(16.0),
              child: const Icon(
                Icons.error_outline,
                color: colorError,
                size: 50,
              ),
            ),
            const SizedBox(height: 20),
            // Título
            Text(
              i18n.loguin.unexpected_error.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: colorError,
              ),
            ),
            const SizedBox(height: 10),
            // Mensaje
            Text(
              controller.state.responseGeneral!.mensaje,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            // Botón de acción
            ElevatedButton(
              onPressed: () {
                controller.resetValuesState(); // Resetea el estado
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorPrincipal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: const Text(
                "Aceptar",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: colorBackground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
