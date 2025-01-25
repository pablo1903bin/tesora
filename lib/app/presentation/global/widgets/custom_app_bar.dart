// custom_app_bar.dart

import 'package:flutter/material.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/global/widgets/text_size.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final GlobalKey? cajaTotalDisponible;
  const CustomAppBar({this.cajaTotalDisponible, super.key, this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    print("Construir el AppBar...");
    return AppBar(
      title: autoSizeTextCards(titulo:title, fontSize: 24, align: TextAlign.start),
      backgroundColor: colorSueve,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          color: colorPrincipal,
          onPressed: () {
            Scaffold.of(context).openDrawer(); // Abre el Drawer
          },
        ),
      ),
      actions: [
        IconButton(
          color: colorPrincipal,
          icon: const Icon(Icons.notifications),
          onPressed: () {
            print('Notificaciones presionadas');
          },
        ),
        IconButton(
          color: colorPrincipal,
          icon: const Icon(Icons.qr_code),
          onPressed: () {
            print('Search presionadas');
          },
        ),
        IconButton(
          key: cajaTotalDisponible,
          color: colorPrincipal,
          icon: const Icon(Icons.group),
          onPressed: () {
            print('Grupo presionado');
          },
        ),
      ],
      elevation: 0.0,
      centerTitle: true,
    );
  }

  String _formatTitle(String title) {
    return title.replaceAll('/', ' '); // Elimina el prefijo `/`
  }
}
