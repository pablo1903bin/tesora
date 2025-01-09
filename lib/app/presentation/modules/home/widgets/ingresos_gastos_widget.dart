import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/mixin/controllers_mixin.dart';
import 'package:tesora/app/presentation/modules/home/controllers/home_controller.dart';
import 'package:tesora/app/presentation/modules/home/widgets/resume_card.dart';

class ResumenColumn extends StatelessWidget with ControllersMixin {
  const ResumenColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = getHomeController(context);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: FutureBuilder<double>(
                future: homeController.getIngresos(),
                builder: (context, snapshot) {
                  // Verifica el estado del Future
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SizedBox(
                        width: 20, // Ajusta el ancho del indicador
                        height: 20, // Ajusta el alto del indicador
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                        ),
                      ),
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
                    return Consumer<HomeController>(
                      builder: (context, controller, child) {
                        double? data = controller
                            .state.ingresosTotal; // Obtén los datos del estado
                        return ResumenCard(
                          titulo: "Ingresos",
                          monto: "+\$${data!} MXN",
                          colorFondo: colorAlterno1,
                          colorTexto: colorError,
                          onTap: () {
                            homeController.cambioTab(1);
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: FutureBuilder<double>(
                future: homeController.getGasto(),
                builder: (context, snapshot) {
                  // Verifica el estado del Future
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SizedBox(
                        width: 20, // Ajusta el ancho del indicador
                        height: 20, // Ajusta el alto del indicador
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                        ),
                      ),
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
                    return ResumenCard(
                      titulo: "Gastos",
                      monto: "-\$${snapshot.data!} MXN",
                      colorFondo: colorAlterno1,
                      colorTexto: colorError,
                      onTap: () {
                        homeController.cambioTab(0);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
