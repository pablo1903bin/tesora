

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tesora/app/domain/models/gasto/combined_model.dart';
import 'package:tesora/app/presentation/global/widgets/constants.dart';


class SaveButton extends StatelessWidget {
  final CombinedModel cModel;
  final bool hasData;
  const SaveButton({
    super.key, 
    required this.cModel,
    required this.hasData
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){

   
          Fluttertoast.showToast(
            msg: 'No olvides seleccionar una categoría',
            backgroundColor: Colors.red
          );
      
        
        
      },
      child: SizedBox(
        height: 70.0,
        width: 150.0,
        child: Constants.customButton(
         Colors.green, 
         Colors.white, 
         (hasData) ? 'EDITAR' : 'GUARDAR'
        ),
      )
    );
  }
}