import 'package:flutter/material.dart';
import 'package:tesora/app/domain/models/gasto/combined_model.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';

class BSNumKeyboard extends StatefulWidget {
  const BSNumKeyboard({super.key, required CombinedModel cModel});

  @override
  BSNumKeyboardState createState() => BSNumKeyboardState();
}

class BSNumKeyboardState extends State<BSNumKeyboard> {
  String import = '0.00'; // Variable que almacena la cantidad ingresada

  @override
  Widget build(BuildContext context) {
    // Expresión regular para formatear números con comas cada tres dígitos
    String Function(Match) mathFunc;
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc = (Match match) => '${match[1]},';

    return GestureDetector(
      onTap: () {
        // Abre el teclado numérico al tocar
        _numPad();
      },
      child: Container(
        color: colorAlterno5, // Color de fondo
        width: double.infinity, // Ocupa todo el ancho disponible
        height: 240, // Altura fija del widget
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const Text('Cantidad Ingresada'), // Título del campo
              Text(
                // Muestra la cantidad formateada
                '\$ ${import.replaceAllMapped(reg, mathFunc)}',
                style: const TextStyle(
                  fontSize: 30.0,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Función que muestra el teclado numérico como un modal
  _numPad() {
    // Limpia la cantidad si es "0.00" para empezar a escribir
    if (import == '0.00') import = '';

    // Función que genera botones del teclado numérico
    num(String text, double height) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            import += text; // Agrega el texto del botón al valor ingresado
          });
        },
        child: SizedBox(
          height: height, // Altura del botón
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 35.0, // Tamaño de fuente
              ),
            ),
          ),
        ),
      );
    }

    // Modal que muestra el teclado numérico
    showModalBottomSheet(
      barrierColor: Colors.transparent, // Fondo transparente
      isDismissible: false, // El modal no se puede descartar tocando fuera
      enableDrag: false, // El modal no se puede arrastrar
      isScrollControlled: true, // Control del scroll en el modal
      backgroundColor: colorSueve, // Fondo del modal
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)), // Bordes redondeados en la parte superior
      ),
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          // Prevenir que se cierre el modal al presionar atrás
          onWillPop: () async => false,
          child: SizedBox(
            height: 300.0, // Altura del modal
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                var height = constraints.biggest.height / 5; // Divide el modal en cinco partes iguales
                return Column(
                  children: [
                    // Teclado numérico usando una tabla
                    Table(
                      border: const TableBorder.symmetric(
                        inside: BorderSide(width: 0.1), // Línea entre los botones
                      ),
                      children: [
                        TableRow(children: [num('1', height), num('2', height), num('3', height)]),
                        TableRow(children: [num('4', height), num('5', height), num('6', height)]),
                        TableRow(children: [num('7', height), num('8', height), num('9', height)]),
                        TableRow(
                          children: [
                            num('.', height), // Botón para el punto decimal
                            num('0', height), // Botón para el número 0
                            GestureDetector(
                              // Botón de borrar
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  if (import.isNotEmpty) {
                                    // Borra el último carácter
                                    import = import.substring(0, import.length - 1);
                                  }
                                });
                              },
                              onLongPress: () {
                                // Borra todo el contenido al mantener presionado
                                setState(() {
                                  import = '';
                                });
                              },
                              child: SizedBox(
                                height: height,
                                child: const Icon(
                                  Icons.backspace,
                                  size: 35.0, // Tamaño del ícono
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Botones de "Cancelar" y "Aceptar"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Espaciado uniforme entre los botones
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.transparent, // Fondo transparente
                            side: const BorderSide(color: Colors.red), // Borde rojo
                            fixedSize: const Size(120.0, 50.0), // Tamaño fijo
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0), // Bordes redondeados
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              import = '0.00'; // Restablece el valor a cero
                              Navigator.pop(context); // Cierra el modal
                            });
                          },
                          child: const Text(
                            'CANCELAR',
                            style: TextStyle(color: Colors.red, fontSize: 12), // Texto en rojo
                          ),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.green.withOpacity(0.1), // Fondo verde claro
                            side: const BorderSide(color: Colors.green), // Borde verde
                            fixedSize: const Size(120.0, 50.0), // Tamaño fijo
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0), // Bordes redondeados
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              if (import.isEmpty) import = '0.00'; // Si no hay texto, asigna "0.00"
                              Navigator.pop(context); // Cierra el modal
                            });
                          },
                          child: const Text(
                            'ACEPTAR',
                            style: TextStyle(color: Colors.green, fontSize: 12), // Texto en verde
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
