import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tesora/app/data/repositories_impl/native_repository_impl.dart';
import 'package:tesora/gen/i18n/translations_mobil.g.dart';
import 'package:tesora/mmovil_app.dart';
import 'package:timezone/data/latest_all.dart' as tz;

import 'app/domain/models/sesion/sesion_state.dart';
import 'app/domain/singletons/setup_locator.dart';

void main() async {
  // Inicializa la localización para el idioma español
  initializeApp();

  //Activar para usar lenguaje del dispositivo
  LocaleSettings.useDeviceLocale();
  // String hostLocal = "http://192.168.100.5:8080/gateway/api";
  String webServer = "http://45.33.13.164:8080/gateway/api";
  // Configura GetIt al inicio
  await AppDependencies.load(
    hostApi: webServer,
    sesion: SesionState(
        const String.fromEnvironment("S_USER"),
        const String.fromEnvironment("S_SESSION_ID"),
        [const String.fromEnvironment("COOKIES")]),
    mocEnabled: true,
  );

  runApp(const MmovilApp());
}

Future<void> initializeApp() async {

  NativeRepositoryImpl.initNotifications();
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_ES', null);
  tz.initializeTimeZones();
}

void appModuleFlutter() {
  runApp(const MmovilApp());
}
