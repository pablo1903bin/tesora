

import 'package:flutter/cupertino.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';

class Constants {
  
  static sheetBoxDecoration(Color color){
    return BoxDecoration(
      color: color,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0)
      )
    );
  }

static Widget customButton(Color decoration, Color border, String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: decoration,
        border: Border.all(
          color: border,
        ),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: colorPrincipal, // Color del texto que contrasta con el borde
            fontSize: 16.0, // Tamaño de fuente ajustable
            fontWeight: FontWeight.bold, // Para que el texto sea más destacado
          ),
        ),
      ),
    ),
  );
}

}