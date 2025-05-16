import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tesora/app/presentation/controller/theme_controller.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/global/widgets/text_size.dart';
import 'package:tesora/app/presentation/mixin/controllers_mixin.dart';

import '../../../../domain/models/user.dart';
import '../../../../domain/repositories/authentication_repository.dart';
import '../../../routes/route_path.dart';
import '../../home/controllers/home_controller.dart';

class AppDrawer extends StatelessWidget with ControllersMixin {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Drawer(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const Drawer(
            child: Center(child: Text('Error al cargar datos de usuario')),
          );
        }

        final user = snapshot.data;

        return Consumer<ThemeController>(
          builder: (context, themeController, child) {
            final esDark = themeController.state.isDarkMode;
            final textColor = esDark ? colorCuarto : colorPrincipal;

            return Drawer(
              backgroundColor: esDark ? darkColorLive : colorSueve,
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(top: 60.0, left: 16, bottom: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: esDark ? darkColor : colorSecundarioAlterno,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const CircleAvatar(
                            radius: 40,
                            backgroundColor: colorAlterno4,
                            backgroundImage:
                                AssetImage('lib/app/images/usuario.png'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    (user?.name ?? 'Desconocido').toUpperCase(),
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: esDark
                                          ? colorPrincipal
                                          : colorAlterno1,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      user?.role ?? "", // Mostrar el rol
                                      style: TextStyle(
                                        color: textColor.withOpacity(0.7),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: () {
                                  // Acción al tocar el texto
                                  context.go(RoutePath
                                      .userDetails); // Navega a la pantalla de perfil
                                },
                                child: Text(
                                  "Ir a mi perfil",
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home, color: colorAlterno2),
                    title: autoSizeText(
                        titulo: "Inicio",
                        color: esDark ? colorAlterno5 : colorAlterno2,
                        fontSize: 18,
                        align: TextAlign.start),
                    onTap: () {
                      Navigator.pop(context);
                      context.go(RoutePath.home);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings, color: colorAlterno2),
                    title: autoSizeText(
                        titulo: "Configuración",
                        color: esDark ? colorAlterno5 : colorAlterno2,
                        fontSize: 18,
                        align: TextAlign.start),
                    onTap: () {
                      Navigator.pop(context);
                      context.go(RoutePath.setting);
                    },
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.notifications, color: colorAlterno2),
                    title: autoSizeText(
                        titulo: "Notificaciones",
                        color: esDark ? colorAlterno5 : colorAlterno2,
                        fontSize: 18,
                        align: TextAlign.start),
                    onTap: () {
                      Navigator.pop(context);
                      context.go(RoutePath.notifications);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.group, color: colorAlterno2),
                    title: autoSizeText(
                        titulo: "Grupos",
                        color: esDark ? colorAlterno5 : colorAlterno2,
                        fontSize: 18,
                        align: TextAlign.start),
                    onTap: () {
                      Navigator.pop(context);
                      context.go(RoutePath.home);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.folder),
                    title: autoSizeText(
                        titulo: "Expedientes",
                        color: esDark ? colorAlterno5 : colorAlterno2,
                        fontSize: 18,
                        align: TextAlign.start),
                    onTap: () {
                      Navigator.pop(context);
                      context.go(RoutePath.setting);
                    },
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: esDark ? darkColor : colorSecundarioAlterno,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        /********************************** */
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Selector<HomeController, bool>(
                            selector: (_, controller) =>
                                controller.state.turorialHome!,
                            builder: (_, tutorialHome, __) {
                              return ListTile(
                                leading: Icon(
                                  tutorialHome
                                      ? Icons.check_circle
                                      : Icons.remove_red_eye_rounded,
                                  color: tutorialHome
                                      ? colorAlterno4
                                      : colorAlterno4,
                                ),
                                title: autoSizeText(
                                  titulo: tutorialHome
                                      ? 'Tutorial visto'
                                      : 'Ver tutorial',
                                  color: tutorialHome
                                      ? colorAlterno2
                                      : colorAlterno2,
                                  fontSize: 18,
                                  align: TextAlign.start,
                                ),
                                trailing: Checkbox(
                                  value: tutorialHome,
                                  onChanged: (value) {
                                    // Cambiar el estado del tutorial usando el controlador
                                    getHomeController(context)
                                        .cambiarEstadoTutorial();
                                    Navigator.of(context).pop();

                                    // Mostrar SnackBar con mensaje de confirmación
                                    final snackBar = SnackBar(
                                      backgroundColor: esDark
                                          ? colorAlterno4
                                          : colorAlterno4,
                                      content: Text(
                                        value == true
                                            ? 'El tutorial se marcará como visto.'
                                            : 'El tutorial se marcará como no visto.',
                                      ),
                                      duration: const Duration(
                                          seconds: 3), // Duración del SnackBar
                                    );

                                    // Mostrar el SnackBar en el Scaffold actual
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                ),
                              );
                            },
                          ),
                        ),

                        //*********************************** */
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: ListTile(
                            leading: Icon(
                              esDark ? Icons.light_mode : Icons.dark_mode,
                              color: esDark ? colorAlterno4 : colorAlterno4,
                            ),
                            title: autoSizeText(
                              titulo: esDark ? 'Light Mode' : 'Dark Mode',
                              color: esDark ? colorAlterno5 : colorAlterno2,
                              fontSize: 18,
                              align: TextAlign.start,
                            ),
                            trailing: Transform.scale(
                              scale:
                                  0.8, // Ajusta el tamaño del Switch (1.0 es el tamaño normal)
                              child: Switch(
                                value: esDark,
                                onChanged: (value) {
                                  themeController.cambiarModoTema();
                                },
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                            leading:
                                const Icon(Icons.logout, color: colorAlterno2),
                            title: autoSizeText(
                                titulo: "Cerrar Sesion",
                                color: esDark ? colorAlterno5 : colorAlterno2,
                                fontSize: 18,
                                align: TextAlign.start),
                            onTap: () async {
                              // Cierra el modal inmediatamente
                              Navigator.pop(context);

                              // Cierra sesión después
                              final authenticationRepository =
                                  GetIt.instance<AuthenticationRepository>();
                              await authenticationRepository.signOut();

                              // Usa un Future.microtask para postergar el uso del context al siguiente ciclo
                              Future.microtask(() {
                                if (context.mounted) {
                                  GoRouter.of(context)
                                      .pushReplacement(RoutePath.loguin);
                                }
                              });
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Método para obtener los datos del usuario desde GetIt
  Future<User?> _getUserData() async {
    final authenticationRepository = GetIt.instance<AuthenticationRepository>();
    return authenticationRepository.getUseDta();
  }
}
