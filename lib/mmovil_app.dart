
import 'package:flutter/material.dart';
import 'package:tesora/app/presentation/controller/mmovil_provedor_global.dart';
import 'package:tesora/app_flutter.dart';
import 'package:tesora/gen/i18n/translations_mobil.g.dart';


class MmovilApp extends StatelessWidget {
  const MmovilApp({super.key});

  @override
  Widget build(BuildContext context) {

    //Activar para usar lenguaje del dispositivo
    //LocaleSettings.useDeviceLocale();

    return MmovilProvedorGlobal(
      child: TranslationProvider(child:const AppFlutterModule())
    );
  }

}
