import 'package:go_router/go_router.dart';
import 'package:tesora/app/presentation/modules/gastos/controllers/gasto_controllers.dart';
import 'package:tesora/app/presentation/modules/gastos/controllers/state/gastos_state.dart';
import 'package:tesora/app/presentation/modules/gastos/views/detalle_gasto_view.dart';
import 'package:tesora/app/presentation/modules/gastos/views/gastos_view.dart';
import 'package:tesora/app/presentation/routes/go_route_helper.dart';
import 'package:tesora/app/presentation/routes/route_path.dart';

class GastoRoutes {
  static GoRoute get gastos {
    return GoRouteHelper.goRouteMulti(
      RoutePath.gastos,
      () => const GastosView(),
      [
        //

        GoRouteHelper.c<GastoControllers>(
            () => GastoControllers(const GastosState())),
      ],
    );
  }

    static GoRoute get gasto {
    return GoRouteHelper.goRouteMulti(
      RoutePath.detalleGasto,
      () => const DetalleGastoView(),
      [
        //

        GoRouteHelper.c<GastoControllers>(
            () => GastoControllers(const GastosState())),
      ],
    );
  }

}
