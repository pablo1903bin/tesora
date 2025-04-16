import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesora/app/presentation/global/controller/boton_cargando_controller.dart';
import 'package:tesora/app/presentation/global/controller/state/boton_cargando_state.dart';
import 'package:tesora/app/presentation/global/widgets/boton_continuar.dart';
import 'package:tesora/app/presentation/modules/home/controllers/crear_coperacion_controller.dart';

class BotonCrearCoopWidget extends StatelessWidget {
  final String botonTitulo;
  final CrearCoperacionController crearCooperacionController;

  const BotonCrearCoopWidget({
    super.key,
    required this.botonTitulo,
    required this.crearCooperacionController,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BotonCargandoController>(
      create: (BuildContext context) {
        final btnController =
            BotonCargandoController(BotonCargandoState(activo: true));
        crearCooperacionController.addBotonController(btnController);
        return btnController;
      },
      child: Consumer<BotonCargandoController>(
        builder: (context, botonCargandoController, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: BotonContinuar(
                  titulo: botonTitulo,
                  onPressed: (botonCargandoController) {
    
                    //
                    crearCooperacionController.guardarCooperacion();
                  },
                ),
              ),
              const SizedBox(width: 20),
            ],
          );
        },
      ),
    );
  }
}
