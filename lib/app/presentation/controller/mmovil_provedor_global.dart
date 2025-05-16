import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:tesora/app/presentation/controller/i18n_provider.dart';
import 'package:tesora/app/presentation/controller/notificaciones_controller.dart';
import 'package:tesora/app/presentation/controller/theme_controller.dart';

class MmovilProvedorGlobal extends MultiProvider {
  MmovilProvedorGlobal({super.key, super.child}) : super(providers: [

          ChangeNotifierProvider(create: (_) => ThemeController()),
          ChangeNotifierProvider(create: (_) => I18nProvider("")),


          // ✅ Agregamos el controlador de notificaciones
            // 👇 Usamos la instancia global registrada en GetIt
          ChangeNotifierProvider<NotificacionesController>.value(
            value: GetIt.I<NotificacionesController>(),
          ),
        ]);
}
