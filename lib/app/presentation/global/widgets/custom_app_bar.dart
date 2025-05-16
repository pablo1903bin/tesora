import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/global/widgets/text_size.dart';
import 'package:tesora/app/presentation/routes/route_path.dart';

import '../../controller/notificaciones_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final GlobalKey? cajaTotalDisponible;

  const CustomAppBar({this.cajaTotalDisponible, super.key, this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: autoSizeTextCards(
        titulo: title,
        fontSize: 24,
        align: TextAlign.start,
        color: colorSueve,
      ),
      backgroundColor: colorPrincipal,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          color: colorSueve,
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      actions: [
        // 👇 Botón de notificaciones con badge reactivo
        Consumer<NotificacionesController>(
          builder: (context, controller, _) {
            // Contar las notificaciones no leídas
            final sinLeer =
                controller.state.lista.where((n) => !n.leida).length;

            return Stack(
              alignment: Alignment.topRight,
              children: [
                SizedBox(
                  width: 48, // ← Área más grande para tocar
                  height: 48,
                  child: IconButton(
                    icon: const Icon(Icons.notifications),
                    color: colorSueve,
                    onPressed: () {
                      context.push(RoutePath.notifications);
                    },
                  ),
                ),
                if (sinLeer > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints:
                          const BoxConstraints(minWidth: 18, minHeight: 18),
                      child: Text(
                        '$sinLeer',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),

        IconButton(
          key: cajaTotalDisponible,
          color: colorSueve,
          icon: const Icon(Icons.group),
          onPressed: () {
            context.go(RoutePath.dialog);
          },
        ),
      ],
      elevation: 0.0,
      centerTitle: true,
    );
  }
}
