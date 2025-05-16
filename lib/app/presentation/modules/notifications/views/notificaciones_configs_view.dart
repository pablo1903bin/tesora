import 'package:flutter/material.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/mixin/mixin_repositorios_comunes.dart';

class NotificacionesConfiguracionView extends StatelessWidget with RepositoriosComunes {
  const NotificacionesConfiguracionView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = notificacionesController;
    final notis = sharedPreferencesService.obtenerNotificaciones();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración de notificaciones'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _botonMarcarComoLeidas(context, controller),
            const SizedBox(height: 12),
            _botonEliminarTodas(context, controller),
            const SizedBox(height: 24),
            const Divider(),
            _resumen(context, notis),
          ],
        ),
      ),
    );
  }

  /// Botón para marcar todas como leídas
  Widget _botonMarcarComoLeidas(BuildContext context, controller) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.mark_email_read),
      label: const Text('Marcar todas como leídas'),
      onPressed: () {
        sharedPreferencesService.marcarTodasComoLeidas();
        controller.notifica(
          controller.state.copyWith(
            lista: sharedPreferencesService.obtenerNotificaciones(),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Todas marcadas como leídas')),
        );
      },
    );
  }

  /// Botón para eliminar todas con confirmación
  Widget _botonEliminarTodas(BuildContext context, controller) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.delete),
      label: const Text('Eliminar todas las notificaciones'),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
      onPressed: () => _confirmarEliminacion(context, controller),
    );
  }

  /// Diálogo de confirmación para eliminar todas
  void _confirmarEliminacion(BuildContext context, controller) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¿Eliminar todas las notificaciones?' , style: TextStyle(color: colorPrincipal, fontSize: 16),),
        content: const Text(
          'Esta acción no se puede deshacer. ¿Estás seguro de que quieres eliminar todas las notificaciones?',style: TextStyle(color: colorPrincipal, fontSize: 12)
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: colorErrorBoton),
            onPressed: () {

              controller.limpiarTodo();
              
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Todas las notificaciones eliminadas')),
              );
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  /// Widget para mostrar el resumen de notificaciones
  Widget _resumen(BuildContext context, List notis) {
    final noLeidas = notis.where((n) => !n.leida).length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Resumen:', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Text('Total: ${notis.length}'),
        Text('No leídas: $noLeidas'),
      ],
    );
  }
}
