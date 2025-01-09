import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:tesora/app/data/http/http_base.dart';
import 'package:tesora/app/data/local/secure_storage_service.dart';
import 'package:tesora/app/data/repositories_impl/cooperacion_repository_impl.dart';
import 'package:tesora/app/data/repositories_impl/recordatorio_repository_impl.dart';
import 'package:tesora/app/data/services/remote/cooperacion_api.dart';
import 'package:tesora/app/data/services/remote/recordatori_api.dart';
import 'package:tesora/app/domain/repositories/cooperacion_repository.dart';
import 'package:tesora/app/domain/repositories/recordatorio_repository.dart';
import 'package:tesora/app/domain/singletons/shared_preferences_service.dart';
import 'package:tesora/app/presentation/singletons/i18n_singleton.dart';

import '../../data/http/http_app_flutter.dart';
import '../../data/http/mock_http_mmovil.dart';
import '../../data/local/http_sesion_service.dart';
import '../../data/repositories_impl/BloqueoRepositoryImpl.dart';
import '../../data/repositories_impl/authentication_repository_impl.dart';
import '../../data/repositories_impl/conectivity_repository_impl.dart';
import '../../data/repositories_impl/native_repository_impl.dart';
import '../../data/services/device/internet_checker.dart';
import '../../data/services/device/native_services.dart';
import '../../data/services/remote/bloqueo_api.dart';
import '../../data/services/remote/sign_in_api.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../../domain/repositories/conectivity_repository.dart';
import '../../presentation/singletons/i18n_commons_singleton.dart';
import '../models/sesion/sesion_state.dart';
import '../repositories/bloqueo_repository.dart';
import '../repositories/native_repository.dart';

class AppDependencies {
  static Future<void> load(
      {String? hostApi,
      SesionState? sesion,
      bool? mocEnabled,
      MethodChannel? platform}) async {


    _loadUtiles();
    _loadApis(hostApi!, sesion!, mocEnabled!, platform);
    _loadRepositorios();
  }

  static void _loadUtiles() async {

        // Registra I18nSingleton si no está registrado
    if (!GetIt.instance.isRegistered<I18nSingleton>()) {
      GetIt.instance.registerSingleton<I18nSingleton>(
        I18nSingleton(null), // Inicializamos con null
      );
    }

    // Registra I18nCommonsSingleton si no está registrado
    if (!GetIt.instance.isRegistered<I18nCommonsSingleton>()) {
      GetIt.instance.registerSingleton<I18nCommonsSingleton>(
        I18nCommonsSingleton(),
      );
    }

    if (!GetIt.instance.isRegistered<FlutterSecureStorage>()) {
      GetIt.instance.registerSingleton<FlutterSecureStorage>(
        const FlutterSecureStorage(),
      );
    }

    if (!GetIt.instance.isRegistered<Connectivity>()) {
      GetIt.instance.registerSingleton<Connectivity>(Connectivity());
    }
    if (!GetIt.instance.isRegistered<InternetChecker>()) {
      GetIt.instance.registerSingleton<InternetChecker>(InternetChecker());
    }
    
    if (!GetIt.instance.isRegistered<SharedPreferencesService>()) {
      // Crea una instancia de SharedPreferencesService
      final sharedPreferencesService = SharedPreferencesService();

      // Inicializa SharedPreferences
      await sharedPreferencesService.init();

      // Registra la instancia inicializada en GetIt
      GetIt.instance.registerSingleton<SharedPreferencesService>(
        sharedPreferencesService,
      );
    }
  }

  static void _loadApis(String? hostApi, SesionState sesion, bool mocEnabled,
      MethodChannel? platform) async {
    if (!GetIt.instance.isRegistered<SecureStorageService>()) {
      GetIt.instance.registerSingleton<SecureStorageService>(
        SecureStorageService(),
      );
    }

    print("Es es mi url que estoy registrando en GetIt:   -😃  $hostApi");
    //aqui esta mi MethodChannel para, mi puente de comunicacion con android
    const MethodChannel methodChannel = MethodChannel('pablo_app/channel');

    if (!GetIt.instance.isRegistered<NativeService>()) {
      GetIt.instance.registerSingleton<NativeService>(
        NativeService(platform: methodChannel),
      );
    }

    if (!GetIt.instance.isRegistered<HttpAppFlutter>()) {
      GetIt.instance.registerSingleton<HttpAppFlutter>(
        HttpAppFlutter(
          client: Client(),
          hostApi: hostApi,
        ),
      );
    }

    if (!GetIt.instance.isRegistered<HttpSesionService>()) {
      GetIt.instance.registerSingleton<HttpSesionService>(HttpSesionService(
          sesionState: sesion, nativeService: GetIt.instance<NativeService>()));
    }

    if (!GetIt.instance.isRegistered<SignInApi>()) {
      GetIt.instance.registerSingleton<SignInApi>(
        SignInApi(
          GetIt.instance<FlutterSecureStorage>(),
          http: GetIt.instance<HttpAppFlutter>(),
        ),
      );
    }

    if (!GetIt.instance.isRegistered<CooperacionApi>()) {
      GetIt.instance.registerSingleton<CooperacionApi>(
        CooperacionApi(
          http: GetIt.instance<HttpAppFlutter>(),
        ),
      );
    }

    // Validación de `hostApi` antes de registrar `HttpMmovil`
    if (mocEnabled) {
      if (!GetIt.instance.isRegistered<HttpMmovil>()) {
        GetIt.instance.registerSingleton<HttpMmovil>(MockHttpMmovil(
            client: Client(),
            hostApi: hostApi,
            httpSesionService: GetIt.instance<HttpSesionService>()));
      }
    } else {
      if (!GetIt.instance.isRegistered<HttpMmovil>()) {
        // Si `hostApi` es `null`, se usa un valor predeterminado
        final effectiveHostApi = hostApi;
        GetIt.instance.registerSingleton<HttpMmovil>(HttpMmovil(
            client: Client(),
            hostApi: effectiveHostApi,
            httpSesionService: GetIt.instance<HttpSesionService>()));
      }
    }

    //Registro para la inyeccion de dependencias mi api de recordatorio
    if (!GetIt.instance.isRegistered<RecordatoriApi>()) {
      GetIt.instance.registerSingleton<RecordatoriApi>(
          RecordatoriApi(http: GetIt.instance<HttpAppFlutter>()));
    }

    if (!GetIt.instance.isRegistered<BloqueoApi>()) {
      GetIt.instance.registerSingleton<BloqueoApi>(
        BloqueoApi(http: GetIt.instance<HttpMmovil>()),
      );
    }
  }

  static void _loadRepositorios() {
    if (!GetIt.instance.isRegistered<ConectivityRepository>()) {
      GetIt.instance.registerSingleton<ConectivityRepository>(
        ConectivityRepositoryImpl(
          GetIt.instance<Connectivity>(),
          GetIt.instance<InternetChecker>(),
        ),
      );
    }

    if (!GetIt.instance.isRegistered<AuthenticationRepository>()) {
      GetIt.instance.registerSingleton<AuthenticationRepository>(
        AuthenticationRepositoryImpl(
          GetIt.instance<FlutterSecureStorage>(),
          GetIt.instance<SignInApi>(),
          GetIt.instance<SecureStorageService>(),
        ),
      );
    }

    if (!GetIt.instance.isRegistered<CooperacionRepository>()) {
      GetIt.instance.registerSingleton<CooperacionRepository>(
        CooperacionRepositoryImpl(
          GetIt.instance<CooperacionApi>(),
        ),
      );
    }

    if (!GetIt.instance.isRegistered<NativeRepository>()) {
      GetIt.instance.registerSingleton<NativeRepository>(
        NativeRepositoryImpl(GetIt.instance<NativeService>()),
      );
    }

    if (!GetIt.instance.isRegistered<BloqueoRepository>()) {
      GetIt.instance.registerSingleton<BloqueoRepository>(
          BloqueoRepositoryImpl(api: GetIt.instance<BloqueoApi>()));
    }

    //

    if (!GetIt.instance.isRegistered<RecordatorioRepository>()) {
      GetIt.instance.registerSingleton<RecordatorioRepository>(
          RecordatorioRepositoryImpl(api: GetIt.instance<RecordatoriApi>()));
    }
  }
}
