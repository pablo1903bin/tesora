import 'package:go_router/go_router.dart';
import 'package:tesora/app/domain/models/notifications/notificacion.dart';
import 'package:tesora/app/presentation/modules/notifications/views/notificaciones_configs_view.dart';
import 'package:tesora/app/presentation/modules/notifications/views/notifications_view.dart';
import 'package:tesora/app/presentation/routes/route_path.dart';

import '../../modules/notifications/views/notifications_details_view.dart';

class NotificationRoutes {



static GoRoute get notificationsList {
  return GoRoute(
    path: RoutePath.notifications,
    builder: (context, state) => const NotificacionesView(),
  );
}


static GoRoute get notificationDetail {
  return GoRoute(
    path: RoutePath.notificationDetails,
    builder: (context, state) {
      final noti = state.extra as Notificacion;
      return NotificationsDetailsView(notificacion: noti);
    },
  );
}

static GoRoute get notificationsConfig {
  return GoRoute(
    path: RoutePath.notificationsConfigs,
    builder: (context, state) => const NotificacionesConfiguracionView(),
  );
}


}
