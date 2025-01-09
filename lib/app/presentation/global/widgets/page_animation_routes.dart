import 'package:flutter/cupertino.dart';

// Clase personalizada que extiende `PageRouteBuilder` para crear una transición animada entre páginas.
class PageAnimationRoutes extends PageRouteBuilder {
  final Widget widget; // Widget que será el destino de la transición.
  final double ejex; // Coordenada X para la alineación del efecto de escala.
  final double ejey; // Coordenada Y para la alineación del efecto de escala.

  // Constructor de la clase, inicializando las propiedades requeridas.
  PageAnimationRoutes({
    required this.widget, // Página destino.
    required this.ejex, // Coordenada X de la animación.
    required this.ejey, // Coordenada Y de la animación.
  }) : super(
          // Duración de la transición entre las páginas.
          transitionDuration: const Duration(milliseconds: 400),

          // Método que construye las transiciones animadas.
          transitionsBuilder: (
            BuildContext context, // Contexto de la aplicación.
            Animation<double> animation, // Animación primaria para la transición.
            Animation<double> secAnimation, // Animación secundaria (por ejemplo, para la página saliente).
            Widget child, // El widget que se está animando.
          ) {
            // Configuración de la curva de la animación (efecto de rebote hacia fuera).
            animation = CurvedAnimation(
              parent: animation, // Animación primaria.
              curve: Curves.easeOutBack, // Curva que define el comportamiento de la animación.
            );

            // Retorna una animación de escala (`ScaleTransition`) para la transición.
            return ScaleTransition(
              alignment: Alignment(ejex, ejey), // Alineación basada en las coordenadas proporcionadas.
              scale: animation, // Animación que controla el tamaño (escala).
              child: child, // El widget de destino que será animado.
            );
          },

          // Método que construye la página destino (sin animación).
          pageBuilder: (
            BuildContext context, // Contexto de la aplicación.
            Animation<double> animation, // Animación primaria.
            Animation<double> secAnimation, // Animación secundaria.
          ) {
            // Retorna la página destino.
            return widget;
          },
        );
}
