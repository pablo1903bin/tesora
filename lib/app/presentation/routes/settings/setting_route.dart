
import 'package:go_router/go_router.dart';
import 'package:tesora/app/presentation/controller/loading_lndicator_controller.dart';
import 'package:tesora/app/presentation/controller/states/loading_indicator_state.dart';
import 'package:tesora/app/presentation/modules/settings/views/settings_view.dart';
import 'package:tesora/app/presentation/routes/go_route_helper.dart';

import '../route_path.dart';

class SettingRoute {

  static GoRoute get settings {

    return GoRouteHelper.goRouteMulti(
      RoutePath.setting,
      () => const SettingsView(),
      [
        GoRouteHelper.c<LoadingIndicatorController>( () => LoadingIndicatorController(LoadingIndicatorState())),
        //
      ],
    );
  }
}
