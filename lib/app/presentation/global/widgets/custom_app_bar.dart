// custom_app_bar.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/global/widgets/text_size.dart';
import 'package:tesora/app/presentation/routes/route_path.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final GlobalKey? cajaTotalDisponible;
  const CustomAppBar({this.cajaTotalDisponible, super.key, this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: autoSizeTextCards(titulo:title, fontSize: 24, align: TextAlign.start, color: colorSueve),
      backgroundColor: colorPrincipal,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu),
          color: colorSueve,
          onPressed: () {
            Scaffold.of(context).openDrawer(); // Abre el Drawer
          },
        ),
      ),
      actions: [
        IconButton(
          color: colorSueve,
          icon: const Icon(Icons.notifications),
          onPressed: () {
     
          },
        ),
        IconButton(
          color: colorSueve,
          icon: const Icon(Icons.qr_code),
          onPressed: () {
    
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
