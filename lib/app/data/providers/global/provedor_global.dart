import 'package:provider/provider.dart';
import 'package:tesora/app/data/providers/auth/state/user_auth_state.dart';
import 'package:tesora/app/presentation/modules/caja/controllers/caja_controller.dart';
import 'package:tesora/app/presentation/modules/caja/controllers/state/caja_state.dart';

import '../../../presentation/modules/sign_in/controllers/auth_controller.dart';

class ProvedorGlobal extends MultiProvider {
  ProvedorGlobal({super.key, super.child})
      : super(providers: [
          ChangeNotifierProvider(
              create: (_) => AuthController(UserAuthState())),
          ChangeNotifierProvider(
              create: (_) => CajaController(const CajaState())),
        ]);
}
