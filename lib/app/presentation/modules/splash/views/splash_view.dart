import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/modules/splash/widgets/background_image_widget.dart';
import 'package:tesora/app/presentation/modules/splash/widgets/loading_animations_widget.dart';

import '../../../../domain/repositories/authentication_repository.dart';
import '../../../../domain/repositories/conectivity_repository.dart';
import '../../../routes/route_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState(); // Llama al método inicial del padre.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init(); // Llama al método privado `_init` después de que el cuadro actual se haya renderizado.
    });
  }

  // Método privado que maneja la lógica inicial del SplashScreen
  Future<void> _init() async {
    
    //await Future.delayed(const Duration(seconds: 3));

    final conectivityRepository = GetIt.instance<ConectivityRepository>();
    final hayInternet = await conectivityRepository.hasInternet;

    if (!mounted) return; // 🔒 Verificamos antes de usar context

    if (hayInternet) {
      final authenticationRepository =
          GetIt.instance<AuthenticationRepository>();
      final isSignedIn = await authenticationRepository.isSignedIn;

      if (!mounted) return; // 🔒 Verificamos otra vez luego del await

      if (isSignedIn) {
        GoRouter.of(context).pushReplacement(RoutePath.home);
      } else {
        GoRouter.of(context).pushReplacement(RoutePath.loguin);
      }
    } else {
      context.go(RoutePath.offline, extra: () {
        // mensaje de depuración
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Crea la estructura principal de la pantalla.
      body: Stack(
        // Usa un Stack para superponer widgets.
        children: [
          // Imagen de fondo personalizada
          const BackgroundImage(
            assetPath:
                'lib/app/images/icon_splash.png', // Ruta de la imagen de fondo.
            backgroundColor: colorSueveAzul, // Color de fondo personalizado.
          ),
          // Animación de carga en la parte inferior
          Positioned(
            bottom: MediaQuery.of(context).size.height /
                20, // Posiciona el widget a una fracción de la altura de la pantalla.
            left: 0,
            right: 0,
            child: const Center(
              // Centra el widget de animación horizontalmente.
              child: LoadingAnimation(
                animationPath:
                    'lib/app/images/loading_splash2.json', // Ruta de la animación de carga.
              ),
            ),
          ),
        ],
      ),
    );
  }
}
