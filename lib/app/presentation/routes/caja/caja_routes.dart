import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tesora/app/presentation/modules/caja/views/caja_view.dart';
import 'package:tesora/app/presentation/routes/route_path.dart';

class CajaRoutes {
  static GoRoute get caja {
    return GoRoute(
      path: RoutePath.caja,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const CajaView(),
          transitionDuration: const Duration(milliseconds: 500), // Más lento
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            );

            return FadeTransition(
              opacity: curvedAnimation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(curvedAnimation),
                child: child,
              ),
            );
          },
        );
      },
      routes: const [
        // Define rutas hijas aquí si es necesario
      ],
    );
  }
}
