import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tesora/app/presentation/controller/notificaciones_controller.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/mixin/mixin_repositorios_comunes.dart';
import 'package:tesora/app/presentation/routes/route_path.dart';

class NotificacionesView extends StatelessWidget with RepositoriosComunes {
  const NotificacionesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Consumer<NotificacionesController>(
        builder: (context, controller, _) {
          final listaOrdenada = [
            ...controller.state.lista
          ]..sort((a, b) => b.fecha.compareTo(a.fecha)); 

          if (listaOrdenada.isEmpty) {
            return const Center(child: Text('No hay notificaciones.'));
          }

          return ListView.builder(
            itemCount: listaOrdenada.length,
            itemBuilder: (context, index) {
              final noti = listaOrdenada[index];
              return _buildNotificacionItem(context, controller, noti);
            },
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: colorPrincipal,
      foregroundColor: colorBlanco,
      title: const Text('Notificaciones'),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          color: colorBlanco,
          onPressed: () {
            context.push(RoutePath.notificationsConfigs);
          },
        )
      ],
    );
  }

  Widget _buildNotificacionItem(
    BuildContext context,
    NotificacionesController controller,
    dynamic noti,
  ) {
    return Dismissible(
      key: Key(noti.id.toString()),
      direction: DismissDirection.endToStart,
      background: _buildDeleteBackground(),
      onDismissed: (_) {
        controller.eliminarNotificacion(noti.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.delete, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  'Notificación eliminada',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.blue.shade600,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            duration: const Duration(seconds: 2),
            elevation: 6,
          ),
        );
      },
      child: _buildNotificationCard(context, controller, noti),
    );
  }

  Widget _buildDeleteBackground() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        color: Colors.red.shade400,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.delete, color: colorSueve),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context,
    NotificacionesController controller,
    dynamic noti,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: noti.leida ? Colors.transparent : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: noti.leida ? Colors.grey.shade300 : Colors.blue.shade100,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        title: Text(
          noti.titulo,
          maxLines: 2,
          style: TextStyle(
            fontSize: 14,
            color: colorPrincipal,
            fontWeight: noti.leida ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Text(
          noti.mensaje,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 11,
            color: noti.leida ? colorAlterno2 : colorPrincipal,
            fontWeight: noti.leida ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        onTap: () {
          controller.marcarComoLeida(noti.id);
          context.push(
            RoutePath.notificationDetails,
            extra: noti,
          );
        },
      ),
    );
  }
}
