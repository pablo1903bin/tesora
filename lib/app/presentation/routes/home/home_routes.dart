import 'package:go_router/go_router.dart';
import 'package:tesora/app/presentation/controller/loading_lndicator_controller.dart';
import 'package:tesora/app/presentation/controller/states/loading_indicator_state.dart';
import 'package:tesora/app/presentation/modules/home/controllers/home_controller.dart';
import 'package:tesora/app/presentation/modules/home/controllers/state/home_state.dart';
import 'package:tesora/app/presentation/routes/go_route_helper.dart';

import '../../modules/home/views/home_page_view.dart';
import '../route_path.dart';

class HomeRoutes {
  static GoRoute get home {
    return GoRouteHelper.goRouteMulti(
      RoutePath.home,
      () => const HomePageView(),
      [
        GoRouteHelper.c<HomeController>(() => HomeController(const HomeState(level: 0))),
        GoRouteHelper.c<LoadingIndicatorController>(() => LoadingIndicatorController(LoadingIndicatorState())),

      ],
    );
  }
}
