import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/global/widgets/text_size.dart';
import 'package:tesora/app/presentation/mixin/controllers_mixin.dart';
import 'package:tesora/app/presentation/modules/home/controllers/home_controller.dart';

class CajaTesoreriaWidget extends StatelessWidget with ControllersMixin {
  final VoidCallback onTap;
  final GlobalKey? cajaTotalActual;
  const CajaTesoreriaWidget({super.key, 
    this.cajaTotalActual,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final homeController = getHomeController(context);
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding:
                  const EdgeInsets.only(right: 12, left: 6, bottom: 2, top: 6),
              decoration: BoxDecoration(
                color: colorAlterno1,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet,
                        color: colorPrincipal,
                        size: 28,
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total disponible",
                            style: TextStyle(
                              color: colorPrincipal,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Caja Tesorería",
                            style: TextStyle(
                              color: colorAlterno4,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  FutureBuilder<double>(
                    future: homeController.getTotalcaja(),
                    builder: (context, snapshot) {
                      return AnimatedSwitcher(
                        duration: const Duration(
                            milliseconds: 400), // Duración de la transición
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(
                            scale: animation, // Transición de escala
                            child: child,
                          );
                        },
                        child: snapshot.connectionState ==
                                ConnectionState.waiting
                            ? const SizedBox(
                                width: 24, // Ancho deseado del indicador
                                height: 24, // Alto deseado del indicador
                                child: CircularProgressIndicator(
                                  key: ValueKey(
                                      "loading"), // Clave única para el indicador de carga
                                  strokeWidth: 2.0, // Grosor del borde
                                ),
                              )
                            : snapshot.hasError
                                ? const Text(
                                    "Error al cargar el total de la caja",
                                    key: ValueKey(
                                        "error"), // Clave única para el mensaje de error
                                  )
                                : !snapshot.hasData
                                    ? const Text(
                                        "No hay datos disponibles",
                                        key: ValueKey(
                                            "noData"), // Clave única para el mensaje sin datos
                                      )
                                    : Row(
                                         key: cajaTotalActual,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const SizedBox(height: 40),
                                          Consumer<HomeController>(
                                            builder:
                                                (context, controller, child) {
                                              double? data =
                                                  controller.state.totalCaja;

                                              // Manejamos el caso donde `data` pueda ser null.
                                              final displayValue = data?.toStringAsFixed(2) ??  "0.00";

                                              return autoSizeTextCards(
                                                key: ValueKey(displayValue), // Clave única para el texto del valor
                                                titulo: "\$$displayValue MX", // Mostramos el valor formateado
                                                fontSize: 24,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
