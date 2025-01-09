import 'package:tesora/app/presentation/mixin/mixin_repositorios_comunes.dart';
import 'package:tesora/app/presentation/mixin/mmovil_repositorios.dart';
import 'package:tesora/app/presentation/modules/caja/controllers/state/caja_state.dart';

import '../../../../states/state_notifier.dart';

class CajaController extends StateNotifier<CajaState>
    with RepositoriosComunes, MmovilRepositorios {
  CajaController(super.state);

  int getIndex() {
    return state.bnbIndex;
  }

  void setIndex(int index) {
    notifica(state.copyWith(bnbIndex: index));
  }
}
