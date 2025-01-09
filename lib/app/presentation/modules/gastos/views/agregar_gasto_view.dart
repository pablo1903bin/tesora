import 'package:flutter/material.dart';
import 'package:tesora/app/domain/models/gasto/combined_model.dart';
import 'package:tesora/app/presentation/global/widgets/constants.dart';
import 'package:tesora/app/presentation/modules/gastos/widgets/bs_num_keyboard.dart';
import 'package:tesora/app/presentation/modules/gastos/widgets/comment_box.dart';
import 'package:tesora/app/presentation/modules/gastos/widgets/date_picker.dart';
import 'package:tesora/app/presentation/modules/gastos/widgets/save_button.dart';

class GastoView extends StatelessWidget {
  const GastoView({super.key});

  @override
  Widget build(BuildContext context) {
    CombinedModel cModel = CombinedModel();
    bool hasData = false;
    final editCModel = 
      ModalRoute.of(context)!.settings.arguments as CombinedModel?;

      if(editCModel != null){
        cModel = editCModel;
        hasData = true;
      }
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Gasto'),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          BSNumKeyboard(cModel: cModel),  
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: Constants.sheetBoxDecoration(
                Theme.of(context).primaryColorDark
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DatePicker(cModel: cModel),
                  CommentBox(cModel: cModel),
                  Expanded(
                    child: Center(
                      child: SaveButton(
                        cModel: cModel,
                        hasData: hasData,
                      )
                    )
                  ),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}