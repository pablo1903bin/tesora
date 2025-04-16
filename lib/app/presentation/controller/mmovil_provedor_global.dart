import 'package:provider/provider.dart';
import 'package:tesora/app/presentation/controller/i18n_provider.dart';
import 'package:tesora/app/presentation/controller/theme_controller.dart';

class MmovilProvedorGlobal extends MultiProvider {
  MmovilProvedorGlobal({super.key, super.child}) : super(providers: [

          ChangeNotifierProvider(create: (_) => ThemeController()),
          ChangeNotifierProvider(create: (_) => I18nProvider("")),

          
        ]);
}
