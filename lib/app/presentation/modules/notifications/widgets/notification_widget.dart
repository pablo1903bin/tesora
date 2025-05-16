import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tesora/app/presentation/mixin/i18n_mixin.dart';
import 'package:tesora/app/presentation/mixin/mixin_repositorios_comunes.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationWidget extends StatefulWidget {
  final Widget child;

  const NotificationWidget({required this.child, super.key});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget>  with RepositoriosComunes, I18NMixin {
  @override
  void initState() {
    super.initState();
    _firebaseMessaging();
  }

  Future<void> initializeNotifications() async {
    await FirebaseMessaging.instance.requestPermission();

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  void _firebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    final token = await messaging.getToken();
    print("🔑 FCM Token: $token");
   
    //await notificacionesController.limpiarTodo();

    // 👇 Notificación en primer plano
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final title = message.notification?.title ?? message.data['title'] ?? "Sin título";
      final body = message.notification?.body ?? message.data['body'] ?? "Sin contenido";

      notificacionesController.agregar(
        titulo: title,
        mensaje: body,
      );
    });

    // 👇 Notificación al abrir app desde cerrada
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final title =
            message.notification?.title ?? message.data['title'] ?? "N/A";
        final body =
            message.notification?.body ?? message.data['body'] ?? "N/A";

        print('📦 Notificación recibida al abrir app (cerrada): $title');

        notificacionesController.agregar(
          titulo: title,
          mensaje: body,
        );
      }
    });

    // 👇 Notificación cuando app está en segundo plano y se toca
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final title = message.notification?.title ?? message.data['title'] ?? "N/A";
      final body = message.notification?.body ?? message.data['body'] ?? "N/A";

      print('📦 Notificación tocada desde segundo plano: $title');

      notificacionesController.agregar(
        titulo: title,
        mensaje: body,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
