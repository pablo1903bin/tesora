import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';
import 'package:tesora/app/presentation/mixin/controllers_mixin.dart';
import 'package:tesora/app/presentation/modules/caja/controllers/caja_controller.dart';

class CustomNavigationBar extends StatelessWidget with ControllersMixin {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CajaController>(
      builder: (context, controller, child) {
        return BottomNavigationBar(
          currentIndex: controller.state.bnbIndex,
          onTap: (int i) {
            // Actualiza el índice en el controlador
            controller.setIndex(i);
          },
          elevation: 0.0,
          items: [
            BottomNavigationBarItem(
              label: 'Balance',
              icon: Icon(
                Icons.account_balance_outlined,
                color:
                    controller.state.bnbIndex == 0 ? colorSecundario : Colors.grey,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Gráficos',
              icon: Icon(
                Icons.bar_chart_outlined,
                color:
                    controller.state.bnbIndex == 1 ? colorSecundario : Colors.grey,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Configuración',
              icon: Icon(
                Icons.settings,
                color:
                    controller.state.bnbIndex == 2 ? colorSecundario : Colors.grey,
              ),
            ),
          ],
        );
      },
    );
  }
}
