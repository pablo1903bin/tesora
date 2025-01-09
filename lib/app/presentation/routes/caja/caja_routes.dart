import 'package:go_router/go_router.dart';
import 'package:tesora/app/presentation/controller/loading_lndicator_controller.dart';
import 'package:tesora/app/presentation/controller/states/loading_indicator_state.dart';
import 'package:tesora/app/presentation/modules/caja/views/caja_view.dart';
import 'package:tesora/app/presentation/routes/go_route_helper.dart';
import 'package:tesora/app/presentation/routes/route_path.dart';

class CajaRoutes {
  static GoRoute get caja {
    return GoRouteHelper.goRouteMulti(
      RoutePath.caja,
      () => const CajaView(),
      [ // CajaController

        GoRouteHelper.c<LoadingIndicatorController>(
            () => LoadingIndicatorController(LoadingIndicatorState())),
      ],
    );
  }
}
