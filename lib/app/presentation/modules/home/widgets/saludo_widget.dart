import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/mixin/controllers_mixin.dart';
import 'package:tesora/app/presentation/mixin/i18n_mixin.dart';
import 'package:tesora/app/presentation/modules/home/controllers/home_controller.dart';

class SaludoWidget extends StatelessWidget with ControllersMixin, I18NMixin {
  const SaludoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Acceder al controlador del usuario
    final controller = context.read<HomeController>();
    final isDarkMode = getThemeController(context).state.isDarkMode;
    // Acceder al tema actual
    

    return FutureBuilder<String?>(
      future: controller.getUserName(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return  Center(
            child: Text(i18n.home.home_error),
          );
        }

        final userName = capitalizeFirstLetter(snapshot.data ?? i18n.home.home_text_default);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              // Envuelve la columna en Flexible
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:i18n.home.home_saludo,
                          style: TextStyle(
                            fontSize: 24,
                            color: isDarkMode ? colorCuarto : colorPrincipal, // Dinámico
                            fontFamily: 'SansSerif',
                          ),
                        ),
                        TextSpan(
                          text: "  $userName",
                          style: TextStyle(
                            fontSize: 24,
                            color: isDarkMode ? colorCuarto : colorPrincipal, // Dinámico
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SansSerif',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  String capitalizeFirstLetter(String name) {
    if (name.isEmpty) return name;
    return name[0].toUpperCase() + name.substring(1).toLowerCase();
  }
}
