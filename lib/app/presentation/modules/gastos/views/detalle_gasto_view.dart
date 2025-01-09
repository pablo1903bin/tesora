import 'package:flutter/material.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';


class DetalleGastoView extends StatelessWidget {
  const DetalleGastoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text( "Detalle de Gasto"),
        backgroundColor: colorPrincipal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nombre del gasto
            const Text( "Sin nombre",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: colorPrincipal,
              ),
            ),
            const SizedBox(height: 16.0),

            // Descripción del gasto
            const Text( "Sin descripción",
              style: TextStyle(
                fontSize: 16.0,
                color: colorAlterno4,
              ),
            ),
            const SizedBox(height: 16.0),

            // Fecha del gasto
            const Row(
              children: [
                Icon(Icons.calendar_today, color: colorAlterno1),
                SizedBox(width: 8.0),
                Text(
                  "Fecha: ",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: colorAlterno4,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Monto del gasto
            const Row(
              children: [
                Icon(Icons.attach_money, color: colorPrincipal),
                SizedBox(width: 8.0),
                Text(
                  "Monto: \$60.50",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: colorPrincipal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Categoría del gasto
            const Row(
              children: [
                Icon(Icons.category, color: colorAlterno1),
                SizedBox(width: 8.0),
                Text(
                  "Categoría:Sin categoría",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: colorAlterno4,
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Botón de acción
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorPrincipal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Volver",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
