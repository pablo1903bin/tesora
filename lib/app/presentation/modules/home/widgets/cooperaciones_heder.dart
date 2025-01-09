import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/mixin/controllers_mixin.dart';
import 'package:tesora/app/presentation/routes/route_path.dart';

class CooperacionesHeder extends StatelessWidget with ControllersMixin {
  const CooperacionesHeder({super.key});

  @override
  Widget build(BuildContext context) {
       final homeController = getHomeController(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding:
              const EdgeInsets.only(left: 16, top: 16, bottom: 8, right: 16),
          child: const Text(
            "Cooperaciones",
            style: TextStyle(
                color: colorPrincipal,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ),
        FutureBuilder<List<dynamic>>(
          future: homeController.getCooperaciones(), // Llama al método que obtiene la lista de gastos
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Mientras se carga, muestra un indicador de carga o nada
              return const SizedBox(); // Opcional: puedes mostrar un CircularProgressIndicator si prefieres
            } else if (snapshot.hasError) {
              // Manejo de errores (puedes ajustar el contenido según tus necesidades)
              return const SizedBox(); // O muestra un texto indicando el error
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              // Si la lista está vacía, no muestra nada
              return const SizedBox();
            } else if (snapshot.hasData) {
              // Si hay datos, muestra el GestureDetector
              return GestureDetector(
                onTap: () {
                  context.push(RoutePath.coperaciones);
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
    );
  }
}
