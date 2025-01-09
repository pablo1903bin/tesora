import 'package:flutter/material.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/global/widgets/constants.dart';

class BackSheet extends StatelessWidget {
  const BackSheet({super.key}); // Constructor para permitir optimizaciones de Flutter con claves únicas.

  @override
  Widget build(BuildContext context) {


    // Contenedor principal que define la hoja trasera (BackSheet).
    return Container(
      height: 250.0, // Altura de la hoja trasera.
      decoration: Constants.sheetBoxDecoration(
        colorSueveAzul, // Decora el fondo con el color oscuro del tema.
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Espacia los widgets de manera uniforme.
        children: [
          // Llama al método headers para crear el encabezado de "Ingresos".
          headers('Ingresos', '\$ 3,500.00', colorExito),
          const VerticalDivider(
            thickness: 0.1, // Línea vertical divisoria entre "Ingresos" y "Gastos".
          ),
          // Llama al método headers para crear el encabezado de "Gastos".
          headers('Gastos', '\$ 1,500.00', colorError1),
        ],
      ),
    );
  }

      // Método local que crea un encabezado con un nombre, una cantidad y un color.
    headers(String name, String amount, Color color) {
      return Column(
        children: [
          // Nombre del encabezado (ej., "Ingresos" o "Gastos").
          Padding(
            padding: const EdgeInsets.only(top: 13.0, bottom: 5.0), // Espaciado superior e inferior.
            child: Text(
              name, // Texto del encabezado.
              style: const TextStyle(
                color: colorPrincipal,
                fontSize: 18.0, // Tamaño de fuente del encabezado.
                letterSpacing: 1.5, // Espaciado entre letras.
              ),
            ),
          ),
          // Cantidad asociada al encabezado con un estilo dinámico basado en el color.
          Text(
            amount, // Muestra el monto (ej., "\$ 3,500.00").
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0, // Tamaño de fuente de la cantidad.
              letterSpacing: 1.5, // Espaciado entre letras.
              color: color, // Color (ej., verde para ingresos, rojo para gastos).
            ),
          ),
        ],
      );
    }
}
