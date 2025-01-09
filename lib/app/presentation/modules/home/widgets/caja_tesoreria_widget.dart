import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/global/widgets/text_size.dart';
import 'package:tesora/app/presentation/mixin/controllers_mixin.dart';
import 'package:tesora/app/presentation/modules/home/controllers/home_controller.dart';

class CajaTesoreriaWidget extends StatelessWidget with ControllersMixin {
  final VoidCallback onTap;

  const CajaTesoreriaWidget({
    super.key,
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
                      // Verifica el estado del Future
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Mientras se resuelve el Future, muestra un indicador de carga
                        return const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Center(
                              child: SizedBox(
                                width: 20, // Ajusta el ancho del indicador
                                height: 20, // Ajusta el alto del indicador
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        // Si ocurre un error, muestra un mensaje de error
                        return const Center(
                          child: Text("Error al cargar el total de la caja"),
                        );
                      } else if (!snapshot.hasData) {
                        // Si no hay datos, muestra un mensaje vacío
                        return const Center(
                          child: Text("No hay datos disponibles"),
                        );
                      } else {
                        // Si se resuelve correctamente, muestra el contenido
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            Consumer<HomeController>(
                              builder: (context, controller, child) {
                                double? data = controller.state.totalCaja; // Obtén los datos del estado
                                return autoSizeTextCards(
                                  titulo: "  \$${data!.toStringAsFixed(2)} MX", // Asegúrate de que `data` sea un número
                                  fontSize: 24,
                                );
                              },
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
