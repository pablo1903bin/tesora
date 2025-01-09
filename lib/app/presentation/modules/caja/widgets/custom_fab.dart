import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/global/widgets/page_animation_routes.dart';
import 'package:tesora/app/presentation/modules/gastos/views/agregar_gasto_view.dart';
import 'package:tesora/app/presentation/modules/ingresos/views/ingreso_view.dart';
import 'package:tesora/app/presentation/routes/route_path.dart';

// Clase para un botón flotante personalizado con submenús (FAB).
class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key}); // Constructor estándar.

  @override
  Widget build(BuildContext context) {
    // Lista de botones secundarios del FAB.
    List<SpeedDialChild> childButtons = [];

    // Botón secundario para registrar un gasto.
    childButtons.add(
      SpeedDialChild(
        backgroundColor: Colors.red, // Color de fondo del botón.
        child: const Icon(Icons.remove), // Ícono del botón.
        label: 'Gasto', // Etiqueta del botón.
        labelStyle: const TextStyle(fontSize: 18.0), // Estilo de la etiqueta.
        onTap: () {
          // Navega a la vista de gastos con una animación personalizada.
          Navigator.push(
            context,
            PageAnimationRoutes(
              widget: const GastoView(), // Página de destino.
              ejex: 0.8, // Coordenada X de la animación.
              ejey: 0.8, // Coordenada Y de la animación.
            ),
          );
        },
      ),
    );

    // Botón secundario para registrar un ingreso.
    childButtons.add(
      SpeedDialChild(
        backgroundColor: colorExito1, // Color de fondo del botón.
        child: const Icon(Icons.add), // Ícono del botón.
        label: 'Ingreso', // Etiqueta del botón.
        labelStyle: const TextStyle(fontSize: 18.0), // Estilo de la etiqueta.
        onTap: () {
          // Navega a la vista de ingresos con una animación personalizada.
          Navigator.push(
            context,
            PageAnimationRoutes(
              widget: const IngresoView(), // Página de destino.
              ejex: 0.8, // Coordenada X de la animación.
              ejey: 0.8, // Coordenada Y de la animación.
            ),
          );
        },
      ),
    );

    // Botón secundario para crear una cooperación.
    childButtons.add(
      SpeedDialChild(
        backgroundColor: colorExito, // Color principal de la aplicación.
        child: const Icon(Icons.attach_money), // Ícono del botón.
        label: 'Cooperación', // Etiqueta del botón.
        labelStyle: const TextStyle(fontSize: 18.0), // Estilo de la etiqueta.
        onTap: () {
          // Agregar la ruta a la pila de navegación
          context.push(RoutePath.crearCooperacion);
        },
      ),
    );

    // Devuelve el botón flotante principal con los submenús.
    return SpeedDial(
      icon: Icons.add, // Ícono cuando el FAB está inactivo.
      activeIcon: Icons.close, // Ícono cuando el FAB está expandido.
      children: childButtons, // Lista de botones secundarios.
      spacing: 10.0, // Espaciado entre los botones secundarios.
      childMargin: const EdgeInsets.symmetric(horizontal: 6.0), // Margen del FAB principal.
      childrenButtonSize: 60.0, // Tamaño de los botones secundarios.
    );
  }
}
