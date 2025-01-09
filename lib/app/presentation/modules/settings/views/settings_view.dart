// lib/modules/settings/views/settings_view.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/routes/route_path.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: colorSueve,
        title: const Text("Configuraciones"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).push(
              RoutePath.programaMed,
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Configuraciones",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.go(RoutePath.home);
              },
              child: const Text("Ir a Inicio"),
            ),
          ],
        ),
      ),
    );
  }
}
