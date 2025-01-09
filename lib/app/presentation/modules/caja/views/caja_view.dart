import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/modules/caja/widgets/back_sheet.dart';
import 'package:tesora/app/presentation/modules/caja/widgets/custom_fab.dart';
import 'package:tesora/app/presentation/modules/caja/widgets/front_sheet.dart';

class CajaView extends StatefulWidget {
  const CajaView({super.key}); // Constructor con clave para permitir optimizaciones de Flutter.

  @override
  State<CajaView> createState() => _BalancePageState(); // Crea el estado asociado a este StatefulWidget.
}

class _BalancePageState extends State<CajaView> {
  final _scrollController = ScrollController(); // Controlador para manejar los eventos de desplazamiento.
  double _offset = 0; // Variable para almacenar el desplazamiento actual.

  // Método que escucha los eventos de desplazamiento y actualiza `_offset`.
  void _listener() {
    setState(() {
      _offset = _scrollController.offset / 100; // Calcula un valor basado en el desplazamiento.
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_listener); // Añade el método `_listener` como oyente del controlador de desplazamiento.
    _max; // Inicializa el cálculo de la posición máxima (accesorio `get _max`).
    super.initState(); // Llama al método initState de la clase base.
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listener); // Elimina el oyente del controlador para evitar fugas de memoria.
    _scrollController.dispose(); // Libera los recursos del controlador.
    super.dispose(); // Llama al método dispose de la clase base.
  }

  // Getter para calcular el valor máximo basado en `_offset`.
  double get _max => max(90 - _offset * 90, 0.0); // Limita el valor mínimo a 0.0.

  @override
  Widget build(BuildContext context) {
    // Construye la interfaz de usuario.
    return Scaffold(
      floatingActionButton: const CustomFAB(), // Botón flotante personalizado.
      body: CustomScrollView(
        controller: _scrollController, // Vincula el controlador de desplazamiento al CustomScrollView.
        slivers: [
          // AppBar que se expande con contenido flexible.
          const SliverAppBar(
            backgroundColor: colorAlterno1,
            elevation: 0.0, // Sin sombra para el AppBar.
            expandedHeight: 120.0, // Altura máxima del AppBar expandido.
            flexibleSpace: FlexibleSpaceBar(
              // Contenido dentro del espacio flexible.
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente el contenido.
                children: [
                  // Texto con el saldo.
                  Text(
                    '\$ 2,500.00',
                    style: TextStyle(
                      fontSize: 30.0, // Tamaño grande para el saldo.
                      color: colorPrincipal // Color verde para destacar el saldo.
                    ),
                  ),
                  // Texto con la etiqueta "Caja".
                  Text(
                    'Caja',
                    style: TextStyle(
                      fontSize: 14.0 // Tamaño más pequeño para la etiqueta.
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Lista de contenido deslizable.
          SliverList(
            delegate: SliverChildListDelegate(
              [
                // Usa un Stack para superponer widgets.
                Stack(
                  children: [
                    const BackSheet(), // Widget de fondo (capa inferior).

                    // Widget que se desplaza según `_max`.
                    Padding(
                      padding: EdgeInsets.only(top: _max), // Desplaza el widget hacia abajo.
                      child: const FrontSheet(), // Widget en la capa superior.
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



