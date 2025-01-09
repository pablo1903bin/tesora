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

import '../../../mixin/controllers_mixin.dart';
import '../../../mixin/mixin_repositorios_comunes.dart';
import '../../menu/views/drawer_widget.dart';

class HomePageView extends StatelessWidget with ControllersMixin, RepositoriosComunes, I18NMixin {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = getThemeController(context);
    return Scaffold(
      backgroundColor: colorSueve,
      appBar:  CustomAppBar(
        title: i18n.home.home_titulo,
      ),
      drawer: const AppDrawer(),
      body: _getBody(context, themeController, getHomeController(context)),
      floatingActionButton: const CustomFAB(),
    );
  }

  Widget _getBody(BuildContext context, ThemeController themeController,
      HomeController homeController) {
    //double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 16, right: 16),
      child: RefreshIndicator(
        onRefresh: () async {
          // Llama al método para recargar datos
          await homeController.reloadData(); // Método para recargar los datos
        },
        child: Column(
          children: [
            const SaludoWidget(),
            const SizedBox(height: 12),
            CajaTesoreriaWidget(
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
}
