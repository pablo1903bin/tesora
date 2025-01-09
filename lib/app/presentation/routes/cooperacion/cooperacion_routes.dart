



import 'package:go_router/go_router.dart';
import 'package:tesora/app/presentation/controller/loading_lndicator_controller.dart';
import 'package:tesora/app/presentation/controller/states/loading_indicator_state.dart';
import 'package:tesora/app/presentation/modules/coopercion/controllers/cooperacion_controller.dart';
import 'package:tesora/app/presentation/modules/coopercion/controllers/states/cooperacion_state.dart';
import 'package:tesora/app/presentation/modules/coopercion/views/coperaciones_view.dart';
import 'package:tesora/app/presentation/modules/coopercion/views/crear_cooperacion_wiew.dart';
import 'package:tesora/app/presentation/modules/coopercion/views/detalle_cooperacion_view.dart';
import 'package:tesora/app/presentation/modules/home/controllers/crear_coperacion_controller.dart';
import 'package:tesora/app/presentation/modules/home/controllers/state/crear_cooperacion_state.dart';
import 'package:tesora/app/presentation/routes/go_route_helper.dart';
import 'package:tesora/app/presentation/routes/route_path.dart';

class CooperacionRoutes {

    static GoRoute get coperacionDetalle {
    return GoRouteHelper.goRouteMulti(
      RoutePath.coperacionDetalle,
      () => const DetalleCooperacionView(),
      [
        GoRouteHelper.c<CooperacionController>( () => CooperacionController(const CooperacionState())),
      ],
    );
  }

  static GoRoute get coperaciones {
    return GoRouteHelper.goRouteMulti(
      RoutePath.coperaciones,
      () => CooperacionesView(),
      [
        GoRouteHelper.c<CooperacionController>( () => CooperacionController(const CooperacionState())),
        GoRouteHelper.c<LoadingIndicatorController>( () => LoadingIndicatorController(LoadingIndicatorState())),
      ],
    );
  }

    static GoRoute get crearCooperacion {

      return GoRouteHelper.goRouteMulti(
      RoutePath.crearCooperacion,
      () => CrearCooperacionWiew(),
      [
        GoRouteHelper.c<CrearCoperacionController>( () => CrearCoperacionController(CrearCooperacionState())),
     //   GoRouteHelper.c<BotonCargandoController>( () => BotonCargandoController(BotonCargandoState())),

      ],
    );
  }
}
