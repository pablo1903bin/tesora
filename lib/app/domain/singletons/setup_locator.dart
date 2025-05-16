import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:tesora/app/data/http/http_base.dart';
import 'package:tesora/app/data/http/mock_http_app_flutter.dart';
import 'package:tesora/app/data/local/secure_storage_service.dart';
import 'package:tesora/app/data/local/shared_preferences_service.dart';
import 'package:tesora/app/data/repositories_impl/cooperacion_repository_impl.dart';
import 'package:tesora/app/data/repositories_impl/notificaciones_repository_impl_local.dart';
import 'package:tesora/app/data/services/remote/cooperacion_api.dart';
import 'package:tesora/app/data/services/remote/recordatori_api.dart';
import 'package:tesora/app/domain/repositories/cooperacion_repository.dart';
import 'package:tesora/app/domain/repositories/notificaciones_repository.dart';
import 'package:tesora/app/presentation/controller/notificaciones_controller.dart';
import 'package:tesora/app/presentation/controller/states/notificaciones_state.dart';
import 'package:tesora/app/presentation/singletons/i18n_singleton.dart';

import '../../data/http/http_app_flutter.dart';
import '../../data/http/mock_http_mmovil.dart';
import '../../data/local/http_sesion_service.dart';
import '../../data/repositories_impl/authentication_repository_impl.dart';
import '../../data/repositories_impl/conectivity_repository_impl.dart';
import '../../data/repositories_impl/native_repository_impl.dart';
import '../../data/services/device/internet_checker.dart';
import '../../data/services/device/native_services.dart';
import '../../data/services/remote/sign_in_api.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../../domain/repositories/conectivity_repository.dart';
import '../../presentation/singletons/i18n_commons_singleton.dart';
import '../models/sesion/sesion_state.dart';
import '../repositories/native_repository.dart';

class AppDependencies {
  /// Método principal para inicializar todas las dependencias necesarias en la aplicación.
  /// Registra servicios, APIs y repositorios en el contenedor GetIt.
  static Future<void> load({
    String? hostApi,
    SesionState? sesion,
    bool? mocEnabled,
  }) async {
    await _loadUtiles();
    await _loadApis(hostApi!, sesion!,
        mocEnabled!); // Registra servicios API (mock o reales)
    await _loadRepositorios(); // Registra los repositorios usados por la app
  }

  /// Registra servicios comunes y utilitarios como localización, almacenamiento seguro y conectividad.
  static Future<void> _loadUtiles() async {
    // Registro de localización personalizada (texto traducido en la app)
    if (!GetIt.instance.isRegistered<I18nSingleton>()) {
      GetIt.instance.registerSingleton<I18nSingleton>(
        I18nSingleton(null),
      );
    }

    // Registro de localización común para mensajes compartidos
    if (!GetIt.instance.isRegistered<I18nCommonsSingleton>()) {
      GetIt.instance.registerSingleton<I18nCommonsSingleton>(
        I18nCommonsSingleton(),
      );
    }

    // Registro del almacenamiento seguro (para guardar tokens, etc.)
    if (!GetIt.instance.isRegistered<FlutterSecureStorage>()) {
      GetIt.instance.registerSingleton<FlutterSecureStorage>(
        const FlutterSecureStorage(),
      );
    }

    // Registro del estado de conectividad de red
    if (!GetIt.instance.isRegistered<Connectivity>()) {
      GetIt.instance.registerSingleton<Connectivity>(Connectivity());
    }

    // Registro de checker para verificar acceso real a internet
    if (!GetIt.instance.isRegistered<InternetChecker>()) {
      GetIt.instance.registerSingleton<InternetChecker>(InternetChecker());
    }

    // Registro de preferencias locales compartidas (SharedPreferences)
    if (!GetIt.instance.isRegistered<SharedPreferencesService>()) {
      final sharedPreferencesService = SharedPreferencesService();
      await sharedPreferencesService.init();
      GetIt.instance.registerSingleton<SharedPreferencesService>(
        sharedPreferencesService,
      );
    }

  
  }

  /// Registra todos los servicios remotos (APIs y HTTP), considerando si usar mocks o no.
  static Future<void> _loadApis(
      String? hostApi, SesionState sesion, bool mocEnabled) async {
    // Registro del canal nativo para comunicación con Android/iOS
    if (!GetIt.instance.isRegistered<MethodChannel>()) {
      GetIt.instance.registerSingleton<MethodChannel>(
        const MethodChannel('tesora_app/channel'),
      );
    }

    // Servicio nativo para acceder a funcionalidades del dispositivo
    if (!GetIt.instance.isRegistered<NativeService>()) {
      GetIt.instance.registerSingleton<NativeService>(
        NativeService(platform: GetIt.instance<MethodChannel>()),
      );
    }

    // Servicio de almacenamiento seguro personalizado
    if (!GetIt.instance.isRegistered<SecureStorageService>()) {
      GetIt.instance.registerSingleton<SecureStorageService>(
        SecureStorageService(),
      );
    }

    // Registro del cliente HTTP (mock o real)
    if (!GetIt.instance.isRegistered<HttpAppFlutter>()) {
      final http = mocEnabled
          ? MockHttpAppFlutter(client: Client(), hostApi: hostApi)
          : HttpAppFlutter(client: Client(), hostApi: hostApi);

      GetIt.instance.registerSingleton<HttpAppFlutter>(http);
    }

    // Servicio de sesión del usuario
    if (!GetIt.instance.isRegistered<HttpSesionService>()) {
      GetIt.instance.registerSingleton<HttpSesionService>(
        HttpSesionService(
          sesionState: sesion,
          nativeService: GetIt.instance<NativeService>(),
        ),
      );
    }

    // API para login y registro
    if (!GetIt.instance.isRegistered<SignInApi>()) {
      GetIt.instance.registerSingleton<SignInApi>(
        SignInApi(
          http: GetIt.instance<HttpAppFlutter>(),
        ),
      );
    }

    // API para operaciones de cooperaciones
    if (!GetIt.instance.isRegistered<CooperacionApi>()) {
      GetIt.instance.registerSingleton<CooperacionApi>(
        CooperacionApi(http: GetIt.instance<HttpAppFlutter>()),
      );
    }

    // Cliente HTTP alternativo (mock o real) para servicios protegidos (como bloqueo)
    if (mocEnabled) {
      if (!GetIt.instance.isRegistered<HttpMmovil>()) {
        GetIt.instance.registerSingleton<HttpMmovil>(
          MockHttpMmovil(
            client: Client(),
            hostApi: hostApi,
            httpSesionService: GetIt.instance<HttpSesionService>(),
          ),
        );
      }
    } else {
      if (!GetIt.instance.isRegistered<HttpMmovil>()) {
        GetIt.instance.registerSingleton<HttpMmovil>(
          HttpMmovil(
            client: Client(),
            hostApi: hostApi,
            httpSesionService: GetIt.instance<HttpSesionService>(),
          ),
        );
      }
    }

    // API para recordatorios de medicamentos
    if (!GetIt.instance.isRegistered<RecordatoriApi>()) {
      GetIt.instance.registerSingleton<RecordatoriApi>(
        RecordatoriApi(http: GetIt.instance<HttpAppFlutter>()),
      );
    }
  }

  /// Registra los repositorios que contienen la lógica de negocio y consumen APIs.
  static Future<void> _loadRepositorios() async {
    // Repositorio para verificación de conectividad
    if (!GetIt.instance.isRegistered<ConectivityRepository>()) {
      GetIt.instance.registerSingleton<ConectivityRepository>(
        ConectivityRepositoryImpl(
          GetIt.instance<Connectivity>(),
          GetIt.instance<InternetChecker>(),
        ),
      );
    }

    // Repositorio de autenticación (login, registro)
    if (!GetIt.instance.isRegistered<AuthenticationRepository>()) {
      GetIt.instance.registerSingleton<AuthenticationRepository>(
        AuthenticationRepositoryImpl(
          GetIt.instance<FlutterSecureStorage>(),
          GetIt.instance<SignInApi>(),
        ),
      );
    }

    // Repositorio de operaciones de cooperaciones
    if (!GetIt.instance.isRegistered<CooperacionRepository>()) {
      GetIt.instance.registerSingleton<CooperacionRepository>(
        CooperacionRepositoryImpl(GetIt.instance<CooperacionApi>()),
      );
    }

    // Repositorio para acceder a funcionalidades nativas
    if (!GetIt.instance.isRegistered<NativeRepository>()) {
      GetIt.instance.registerSingleton<NativeRepository>(
        NativeRepositoryImpl(GetIt.instance<NativeService>()),
      );
    }

    // Repositorio de notificaciones (local por ahora)
    if (!GetIt.instance.isRegistered<NotificacionesRepository>()) {
      GetIt.instance.registerSingleton<NotificacionesRepository>(
        NotificacionesRepositoryImplLocal(GetIt.instance<SharedPreferencesService>()),
      );
    }


      // Controlador de notificaciones 📢 (para uso sin context)
    if (!GetIt.instance.isRegistered<NotificacionesController>()) {
      GetIt.instance.registerSingleton<NotificacionesController>(
          NotificacionesController(const NotificacionesState()));
    }
    
  }
}
