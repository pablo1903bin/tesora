import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'app/data/providers/global/provedor_global.dart';
import 'app/presentation/controller/native_channel_controller.dart';
import 'app/presentation/controller/states/native_channel_state.dart';

class AppFlutterModule extends StatelessWidget {
  const AppFlutterModule({super.key});

  @override
  Widget build(BuildContext context) {
    const platform = MethodChannel('mobil/channel');
    return ProvedorGlobal(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<NativeChannelController>(
            create: (context) => NativeChannelController(NativeChannelState(platform: platform)),
          ),
        ],
        child: MyApp(),
      ),
    );
  }

}
