import 'package:flutter/material.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';

class CardCooperaciones extends StatelessWidget {
  final Widget myWidget;
  final Color backgroundColor; // Nuevo parámetro para el color de fondo

  const CardCooperaciones({
    super.key,
    required this.myWidget,
    this.backgroundColor = colorBackground, // Color por defecto
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 14.0, right: 14.0,),
      child: Column(
        children: [
        
          Container(
             margin: const EdgeInsets.only(top:0.0),
            width: size.width,
           
            decoration: BoxDecoration(
              color: colorSueve, // Utiliza el color recibido
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: myWidget,
          ),
        ],
      ),
    );
  }
}
