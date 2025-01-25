import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tesora/app/presentation/controller/theme_controller.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/global/widgets/custom_app_bar.dart';
import 'package:tesora/app/presentation/mixin/i18n_mixin.dart';
import 'package:tesora/app/presentation/modules/caja/widgets/custom_fab.dart';
import 'package:tesora/app/presentation/modules/home/controllers/home_controller.dart';
import 'package:tesora/app/presentation/modules/home/widgets/caja_tesoreria_widget.dart';
import 'package:tesora/app/presentation/modules/home/widgets/cooperacion_list_view_widget.dart';
import 'package:tesora/app/presentation/modules/home/widgets/cooperaciones_heder.dart';
import 'package:tesora/app/presentation/modules/home/widgets/cooperaciones_vacias.dart';
import 'package:tesora/app/presentation/modules/home/widgets/flayer_skin.dart';
import 'package:tesora/app/presentation/modules/home/widgets/ingresos_gastos_widget.dart';
import 'package:tesora/app/presentation/modules/home/widgets/saludo_widget.dart';
import 'package:tesora/app/presentation/routes/route_path.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../mixin/controllers_mixin.dart';
import '../../../mixin/mixin_repositorios_comunes.dart';
import '../../menu/views/drawer_widget.dart';

class HomePageView extends StatelessWidget
    with ControllersMixin, RepositoriosComunes, I18NMixin {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    print("Construir el widget inicial...");
    final themeController = getThemeController(context);
    // Definimos las GlobalKeys
    final GlobalKey cajaTotalDisponible = GlobalKey();
    final GlobalKey cajaTotalActual = GlobalKey();

    List<TargetFocus> targets = [];
    _createTargets(targets, cajaTotalDisponible, cajaTotalActual,
        getHomeController(context)); // Crea los objetivos del tutorial.

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("Despues de construir todos los widgets mostrar esto...");

      print("Despues esto...");
      _showTutorial(targets,
          context); // Muestra el tutorial después de garantizar que todo esté listo.
    });
    return Scaffold(
      backgroundColor: colorSueve,
      appBar: CustomAppBar(
        title: i18n.home.home_titulo,
        cajaTotalDisponible: cajaTotalDisponible,
      ),
      drawer: const AppDrawer(),
      //body: _getBody(context, cajaTotalActual, themeController,getHomeController(context)),
      body: RefreshIndicator(
        onRefresh: () async {
          final homeController = getHomeController(context);
          await homeController.reloadData(); // Método para recargar los datos
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: _getBody(context, cajaTotalActual, themeController,
              getHomeController(context)),
        ),
      ),
      floatingActionButton: const CustomFAB(),
    );
  }

  Widget _getBody(BuildContext context, GlobalKey cajaTotalActual,
      ThemeController themeController, HomeController homeController) {
    //double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 16, right: 16),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const SaludoWidget(),
            const SizedBox(height: 12),
            CajaTesoreriaWidget(
              cajaTotalActual: cajaTotalActual,
              onTap: () {
                // Navegación con GoRouter
                GoRouter.of(context).push(
                  RoutePath.caja,
                );
              },
            ),
            const SizedBox(height: 12),
            const ResumenColumn(),
            const SizedBox(height: 12),
            Consumer<HomeController>(
              builder: (build, controller, child) {
                double screenWeight = MediaQuery.of(context).size.height;
                final controllerState = controller.state;
                final tabActual = controllerState.ingresoGasto;

                if (tabActual == 1) {
                  return Container(
                    alignment: Alignment.center,
                    height: screenWeight * 0.50,
                    decoration: BoxDecoration(
                      color: colorAlterno1,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Column(
                      children: [
                        //Titulo y arrow ir a todas las cooperaciones
                        const CooperacionesHeder(),
                        Expanded(
                          child: FutureBuilder<List<dynamic>>(
                            future: controller.getCooperaciones(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                // Muestra un indicador de carga mientras se resuelve el Future
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                // Manejo de errores
                                return const Center(
                                  child: Text('Error al cargar cooperaciones'),
                                );
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                // Si no hay datos
                                return const CooperacionesVacias();
                              } else {
                                return CooperacionListView(
                                  cooperaciones: snapshot.data!,
                                  // ignore: void_checks
                                  onItemTap: (_) {
                                    context.push(RoutePath.coperacionDetalle);
                                    return SizedBox.shrink;
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Container(
                  alignment: Alignment.center,
                  height: screenWeight * 0.50,
                  decoration: BoxDecoration(
                    color: colorAlterno1,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                left: 16, top: 16, bottom: 8, right: 16),
                            child: const Text(
                              "Gastos",
                              style: TextStyle(
                                  color: colorPrincipal,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          FutureBuilder<List<dynamic>>(
                            future: controller
                                .getGastos(), // Llama al método que obtiene la lista de gastos
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                // Mientras se carga, muestra un indicador de carga o nada
                                return const SizedBox(); // Opcional: puedes mostrar un CircularProgressIndicator si prefieres
                              } else if (snapshot.hasError) {
                                // Manejo de errores (puedes ajustar el contenido según tus necesidades)
                                return const SizedBox(); // O muestra un texto indicando el error
                              } else if (snapshot.hasData &&
                                  snapshot.data!.isEmpty) {
                                // Si la lista está vacía, no muestra nada
                                return const SizedBox();
                              } else if (snapshot.hasData) {
                                // Si hay datos, muestra el GestureDetector
                                return GestureDetector(
                                  onTap: () {
                                    context.push(RoutePath.gastos);
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 50,
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      size: 24,
                                      color: colorPrincipal,
                                    ),
                                  ),
                                );
                              }

                              // Caso predeterminado para evitar errores inesperados
                              return const SizedBox();
                            },
                          ),
                        ],
                      ),
                      Expanded(
                        child: FutureBuilder<List<dynamic>>(
                          future: controller
                              .getGastos(), // Llama al método para obtener los gastos
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // Muestra un indicador de carga mientras se resuelve el Future
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              // Manejo de errores
                              return const Center(
                                child: Text('Error al cargar los gastos'),
                              );
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              // Si no hay datos
                              return const Center(
                                child: Text('No hay gastos disponibles'),
                              );
                            } else {
                              // Construye la lista de FlayerSkin cuando hay datos
                              final gastos = snapshot.data!;
                              return SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  children: gastos.map((gasto) {
                                    return GestureDetector(
                                      onTap: () {
                                        print("Ir a este Gasto.... ");
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 18.0,
                                        ),
                                        child: CardCooperaciones(
                                          myWidget: Container(
                                            height: 200,
                                            padding: const EdgeInsets.only(
                                                top: 12,
                                                right: 16.0,
                                                left: 16,
                                                bottom: 22),
                                            decoration: BoxDecoration(
                                              color: colorSueve,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  blurRadius: 6,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                //Fila de la fecha ir a detalle de Gasto
                                                Row(
                                                  children: [
                                                    // Primer elemento con ancho fijo (70% del total)
                                                    Expanded(
                                                      flex:
                                                          7, // Representa el 70%
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 0),
                                                        child: Text(
                                                          gasto.nombre ??
                                                              gasto.estado ??
                                                              "Sin nombre",
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                colorPrincipal,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis, // Muestra puntos suspensivos si el texto es muy largo
                                                        ),
                                                      ),
                                                    ),

                                                    // Espaciado entre los elementos
                                                    const SizedBox(
                                                        width:
                                                            16), // Ajusta el tamaño según sea necesario

                                                    // Tercer elemento: GestureDetector
                                                    GestureDetector(
                                                      onTap: () {
                                                        context.push(RoutePath
                                                            .detalleGasto);
                                                      },
                                                      child: Container(
                                                        height: 25,
                                                        width: 45,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .transparent, // Agrega color si es necesario
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  8), // Borde opcional
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: const Icon(
                                                          Icons.arrow_forward,
                                                          size: 20,
                                                          color: colorPrincipal,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                const SizedBox(height: 8.0),
                                                // Subtítulo: Descripción o estado
                                                Text(
                                                  gasto.descripcion ??
                                                      gasto.estado ??
                                                      "Sin descripción",
                                                  style: const TextStyle(
                                                    fontSize: 13.0,
                                                    color: colorAlterno4,
                                                  ),
                                                  maxLines:
                                                      3, // Limita a 3 líneas
                                                  overflow: TextOverflow
                                                      .ellipsis, // Agrega "..." si es muy largo
                                                ),
                                                const Spacer(),
                                                // Fecha del gasto
                                                Text(
                                                  "Fecha: ${gasto.fecha.toString().split(' ')[0]}",
                                                  style: const TextStyle(
                                                    fontSize: 12.0,
                                                    color: colorAlterno4,
                                                  ),
                                                ),

                                                // Monto del gasto
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "Monto:",
                                                          style: TextStyle(
                                                              fontSize: 12.0),
                                                        ),
                                                        Text(
                                                          " \$${gasto.monto.toStringAsFixed(2)}",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12.0,
                                                            color:
                                                                colorPrincipal,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      gasto.categoria ??
                                                          "Sin categoría",
                                                      style: const TextStyle(
                                                        fontSize: 12.0,
                                                        color: colorAlterno4,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _showTutorial(List<TargetFocus> targets, BuildContext context) {
    late TutorialCoachMark tutorialCoachMark;
    Future.delayed(const Duration(milliseconds: 300), () {
      tutorialCoachMark = TutorialCoachMark(
        targets: targets,
        colorShadow: const Color.fromARGB(255, 154, 3, 3).withOpacity(0.3),
        textSkip: "Saltar tutorial",
        paddingFocus: 1.5,
        opacityShadow: 0.8,
        alignSkip: Alignment.bottomRight,
        showSkipInLastTarget: false,
        onClickTarget: (target) {
          print("Target clickeado: ${target.identify}");
        },
        onClickOverlay: (target) {
          print("Click en la sombra...");
        },
        onSkip: () {
          print("Tutorial saltado");
          return true; // Ensure a boolean value is returned
        },
        imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        onFinish: () {
          print("Tutorial finalizado");
        },
      );

      tutorialCoachMark.show(
          context: context); // Proporciona el contexto aquí también
    });
  }
}

void _createTargets(List<TargetFocus> targets, GlobalKey cajaTotalDisponible,
    GlobalKey cajaTotalActual, HomeController homeController) {
  final isChecked = homeController
      .state.mostrarTutorial; // Muestra el tutorial al cargar la página
  print("Mostrar tutorial: $isChecked");
  bool noMostrarTutorial = false;

  targets.add(TargetFocus(
    identify: "Target 1",
    keyTarget: cajaTotalDisponible,
    color: const Color.fromARGB(255, 1, 42, 94),
    contents: [
      TargetContent(
        align: ContentAlign.bottom,
        builder: (context, controller) {
          return const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 100),
              Text(
                "Gestiona tu Grupo de Trabajo",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Desde este icono puedes cambiar de grupo de trabajo, crear un nuevo grupo o administrar los existentes. Pulsa aquí para gestionar tus grupos de manera fácil y rápida.",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ],
          );
        },
      )
    ],
    shape: ShapeLightFocus.RRect,
    radius: 5,
  ));

  targets.add(TargetFocus(
    identify: "Target 2",
    keyTarget: cajaTotalActual,
    color: const Color.fromARGB(255, 1, 42, 94),
    contents: [
      TargetContent(
        align: ContentAlign.bottom,
        builder: (context, controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Saldo Total Actual",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Este es el monto total disponible actualmente en la caja. "
                  "Puedes interactuar con este apartado para explorar más detalles sobre los movimientos y el historial de la caja.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.previous(); // Navega al target o focus anterior
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Cambia el color de fondo
                  foregroundColor: Colors.white, // Cambia el color del texto
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20), // Esquinas redondeadas
                  ),
                  elevation: 4, // Añade una sombra
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ), // Ajusta el tamaño interno del botón
                ),
                child: const Icon(
                  Icons.chevron_left,
                  size: 24, // Cambia el tamaño del icono
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      noMostrarTutorial = value ?? false;
                      // Esto asegura que se reconstruya el widget
                      (context as Element).markNeedsBuild();
                    },
                  ),
                  const Text(
                    "No volver a mostrar",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      controller.skip(); // Finaliza el tutorial
                      print("Tutorial finalizado por el usuario");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Cambia el color de fondo
                      foregroundColor:
                          Colors.white, // Cambia el color del texto
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Esquinas redondeadas
                      ),
                      elevation: 4, // Añade una sombra
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ), // Ajusta el tamaño interno del botón
                    ),
                    child: const Text("Entendido"), // Texto del botón
                  ),
                ],
              ),
            ],
          );
        },
      )
    ],
    shape: ShapeLightFocus.RRect,
    radius: 5,
  ));
}
