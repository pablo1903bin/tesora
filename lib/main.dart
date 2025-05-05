import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tesora/firebase_options.dart';
import 'package:tesora/gen/i18n/translations_mobil.g.dart';
import 'package:tesora/mmovil_app.dart';
import 'package:timezone/data/latest_all.dart' as tz;

import 'app/domain/models/sesion/sesion_state.dart';
import 'app/domain/singletons/setup_locator.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔧 Inicializa todo Firebase y notificaciones
  await initializeApp();

  // 🌍 Configura idioma del dispositivo
  LocaleSettings.useDeviceLocale();

  // 🚀 Inicia app con dependencias
  await AppDependencies.load(
    hostApi: const String.fromEnvironment("HOST_API"),
    sesion: SesionState(
      const String.fromEnvironment("S_USER"),
      const String.fromEnvironment("S_SESSION_ID"),
      [const String.fromEnvironment("COOKIES")],
    ),
    mocEnabled: false,
  );

  runApp(const MmovilApp());
}

Future<void> initializeApp() async {
  // 📆 Localización y zonas horarias
  await initializeDateFormatting('es_ES', null);
  tz.initializeTimeZones();

  // 🚀 Inicializa Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 🔔 Pide permiso de notificaciones
  await requestNotificationPermission();

  // 🔧 Inicializa notificaciones locales (para Android)
  const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  const initSettings = InitializationSettings(android: androidInit);
  await flutterLocalNotificationsPlugin.initialize(initSettings);

  // 📩 Escucha mensajes cuando la app está en foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('📥 Mensaje recibido en foreground: ${message.notification?.title}');

    flutterLocalNotificationsPlugin.show(
      message.notification.hashCode,
      message.notification?.title,
      message.notification?.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'canal_id',
          'canal_notificaciones',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  });

  // (Opcional) Obtén el token del dispositivo
  final token = await FirebaseMessaging.instance.getToken();
  print('🔑 Token FCM: $token');
}

Future<void> requestNotificationPermission() async {
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission();

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('✅ Permiso concedido');
  } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
    print('❌ Permiso denegado');
  } else {
    print('🤔 Permiso no determinado');
  }
}
