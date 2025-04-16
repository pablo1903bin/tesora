import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/modules/caja/widgets/back_sheet.dart';
import 'package:tesora/app/presentation/modules/caja/widgets/custom_fab.dart';
import 'package:tesora/app/presentation/modules/caja/widgets/front_sheet.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class CajaView extends StatefulWidget {
  const CajaView(
      {super.key}); // Constructor con clave para permitir optimizaciones de Flutter.

  @override
  State<CajaView> createState() =>
      _BalancePageState(); // Crea el estado asociado a este StatefulWidget.
}

class _BalancePageState extends State<CajaView> {
  final _scrollController =
      ScrollController(); // Controlador para manejar los eventos de desplazamiento.
  double _offset = 0; // Variable para almacenar el desplazamiento actual.

  // Definimos las GlobalKeys
  final GlobalKey cajaTotal = GlobalKey();
  final GlobalKey textotest = GlobalKey();
  final GlobalKey keyTextoCaja = GlobalKey();

  List<TargetFocus> targets = [];
  late TutorialCoachMark tutorialCoachMark;

  // Método que escucha los eventos de desplazamiento y actualiza `_offset`.
  void _listener() {
    setState(() {
      _offset = _scrollController.offset /
          100; // Calcula un valor basado en el desplazamiento.
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_listener);

    // Usa addPostFrameCallback para esperar a que el árbol de widgets se renderice completamente.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _createTargets(); // Crea los objetivos del tutorial.

      Future.delayed(const Duration(milliseconds: 100), () {
        _showTutorial(); // Muestra el tutorial después de garantizar que todo esté listo.
      });
    });
  }

  void _showTutorial() {
    Future.delayed(const Duration(milliseconds: 300), () {
      tutorialCoachMark = TutorialCoachMark(
        targets: targets,
        colorShadow: Colors.black.withOpacity(0.6),
        textSkip: "Saltar tutorial",
        onFinish: () {
  
        },
        onClickTarget: (target) {
     
        },
        onSkip: () {
    
          return true; // Ensure a boolean value is returned
        },
      );

      tutorialCoachMark.show(
          context: context); // Proporciona el contexto aquí también
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(
        _listener); // Elimina el oyente del controlador para evitar fugas de memoria.
    _scrollController.dispose(); // Libera los recursos del controlador.
    super.dispose(); // Llama al método dispose de la clase base.
  }

  // Getter para calcular el valor máximo basado en `_offset`.
  double get _max =>
      max(90 - _offset * 90, 0.0); // Limita el valor mínimo a 0.0.

  @override
  Widget build(BuildContext context) {
    // Construye la interfaz de usuario.
    return Scaffold(
      floatingActionButton: const CustomFAB(), // Botón flotante personalizado.
      body: CustomScrollView(
        controller:
            _scrollController, // Vincula el controlador de desplazamiento al CustomScrollView.
        slivers: [
          // AppBar que se expande con contenido flexible.
          SliverAppBar(
            backgroundColor: colorAlterno1,
            elevation: 0.0, // Sin sombra para el AppBar.
            expandedHeight: 120.0, // Altura máxima del AppBar expandido.
            flexibleSpace: FlexibleSpaceBar(
              // Contenido dentro del espacio flexible.
              background: Column(
                mainAxisAlignment: MainAxisAlignment
                    .center, // Centra verticalmente el contenido.
                children: [
                  // Texto con el saldo.
                  _mostrarCaja(),
                  // Texto con la etiqueta "Caja".
                  _mostrarCajaText(),

                  const SizedBox(height: 10),
                  _mostrarTextoTest(),
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
                      padding: EdgeInsets.only(
                          top: _max), // Desplaza el widget hacia abajo.
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

  void _createTargets() {
    targets = [
      TargetFocus(
        identify: "Target 1",
        keyTarget: cajaTotal,
        color: const Color.fromARGB(255, 9, 115, 254),
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Titulo lorem ipsum",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 5,
      ),
      TargetFocus(
        identify: "Target 1",
        keyTarget: keyTextoCaja,
        color: const Color.fromARGB(255, 9, 115, 254),
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Titulo lorem ipsum",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.previous();
                    },
                    child: const Icon(Icons.chevron_left),
                  ),
                ],
              );
            },
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 5,
      ),
      TargetFocus(
        identify: "Target 1",
        keyTarget: textotest,
        color: const Color.fromARGB(255, 9, 115, 254),
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Titulo lorem ipsum",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.previous();
                    },
                    child: const Icon(Icons.chevron_left),
                  ),
                ],
              );
            },
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 5,
      )
    ];
  }

  Widget _mostrarCaja() {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 81,
        padding:
            const EdgeInsets.all(16), // Agrega espacio alrededor del contenido
        child: Text(
          key: cajaTotal,
          '\$ 2,500.00',
          style: const TextStyle(
            fontSize: 30.0,
            color: colorPrincipal,
          ),
        ),
      ),
    );
  }

  Widget _mostrarTextoTest() {
    return Text(
      key: textotest,
      '\$ 2,500.00',
      style: const TextStyle(
        fontSize: 14.0,
        color: colorPrincipal,
      ),
    );
  }

  Widget _mostrarCajaText() {
    return Text(
      key: keyTextoCaja,
      'Caja',
      style:
          const TextStyle(fontSize: 14.0 // Tamaño más pequeño para la etiqueta.
              ),
    );
  }
}
