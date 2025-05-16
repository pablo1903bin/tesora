
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tesora/firebase_options.dart';

/// Esta función se ejecuta cuando la app está completamente cerrada
Future<void> backgroundMessaging(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Puedes hacer cosas como guardar en BD local o registrar logs
  print('📦 [Background] Mensaje desde el main: ${message.notification?.title}');
}
