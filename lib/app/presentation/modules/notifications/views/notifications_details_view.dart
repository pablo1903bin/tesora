import 'package:flutter/material.dart';
import 'package:tesora/app/domain/models/notifications/notificacion.dart';

class NotificationsDetailsView extends StatelessWidget {
  final Notificacion notificacion;

  const NotificationsDetailsView({super.key, required this.notificacion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notificación")),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notificacion.titulo,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(notificacion.mensaje),
            const SizedBox(height: 20),
            Text("📅 Fecha: ${notificacion.fecha}"),
            Text("📖 Leída: ${notificacion.leida ? 'Sí' : 'No'}"),
          ],
        ),
      ),
    );
  }
}
