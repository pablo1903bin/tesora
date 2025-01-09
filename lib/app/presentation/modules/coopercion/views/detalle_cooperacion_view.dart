import 'package:flutter/material.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';

class DetalleCooperacionView extends StatelessWidget {


  const DetalleCooperacionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle Cooperación"),
        backgroundColor: colorPrincipal,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nombre
            Text("Sin nombre",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colorPrincipal,
              ),
            ),
            SizedBox(height: 16),

            // Descripción
            Text( "Sin descripción",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 16),

            // Monto objetivo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Monto objetivo:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text("0.00",
                  style: TextStyle(fontSize: 16, color: colorExito),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Monto actual
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Monto actual:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "0.00",
                  style: TextStyle(fontSize: 16, color: colorExito),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Estado
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Estado:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Desconocido",
                  style: TextStyle(fontSize: 16, color: colorAlterno4),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Fecha de creación
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Fecha de creación:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                 "fecha",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
