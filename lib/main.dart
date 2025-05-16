import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tesora/app/domain/models/sesion/sesion_state.dart';
import 'package:tesora/app/domain/singletons/setup_locator.dart'; // ← aquí está AppDependencies
import 'package:tesora/background_messaging.dart';
import 'package:tesora/firebase_options.dart';
import 'package:tesora/gen/i18n/translations_mobil.g.dart';
import 'package:tesora/mmovil_app.dart';
import 'package:timezone/data/latest_all.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar zona horaria y formato regional
  await initializeDateFormatting('es_ES', null);
  tz.initializeTimeZones();

  // Inicializar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Registrar función que manejará notificaciones en segundo plano
  FirebaseMessaging.onBackgroundMessage(backgroundMessaging);

  // Configurar idioma del dispositivo
  LocaleSettings.useDeviceLocale();

  // ⚠️ Cargar todas las dependencias necesarias (incluye GetIt)
  await AppDependencies.load (
    hostApi: const String.fromEnvironment("API_HOST_PROD"),
    sesion: SesionState(
      const String.fromEnvironment("S_USER"),
      const String.fromEnvironment("S_SESSION_ID"),
      "",
      [const String.fromEnvironment("COOKIES")],
    ),
    mocEnabled: false,
  );

  // ✅ Ya se registró todo en GetIt y estás listo para correr la app
  runApp(const MmovilApp());
}
