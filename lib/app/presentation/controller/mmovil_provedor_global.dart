import 'package:provider/provider.dart';
import 'package:tesora/app/presentation/controller/i18n_provider.dart';
import 'package:tesora/app/presentation/controller/theme_controller.dart';
import 'package:tesora/app/presentation/modules/caja/controllers/caja_controller.dart';
import 'package:tesora/app/presentation/modules/caja/controllers/state/caja_state.dart';

class MmovilProvedorGlobal extends MultiProvider {
  MmovilProvedorGlobal({super.key, super.child})
      : super(providers: [
  
          ChangeNotifierProvider(create: (_) => CajaController(const CajaState())),
          ChangeNotifierProvider(create: (_) => ThemeController()),
          ChangeNotifierProvider(create: (_) => I18nProvider("")),
        ]);
}
