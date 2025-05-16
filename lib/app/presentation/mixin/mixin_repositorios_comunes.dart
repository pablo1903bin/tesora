import 'package:get_it/get_it.dart';
import 'package:tesora/app/data/local/secure_storage_service.dart';
import 'package:tesora/app/data/local/shared_preferences_service.dart';
import 'package:tesora/app/domain/repositories/cooperacion_repository.dart';
import 'package:tesora/app/domain/repositories/notificaciones_repository.dart';
import 'package:tesora/app/presentation/controller/notificaciones_controller.dart';

import '../../domain/repositories/conectivity_repository.dart';
import '../../domain/repositories/native_repository.dart';
import '../../domain/repositories/sesion_repository.dart';

mixin RepositoriosComunes {
  ConectivityRepository get connectivityRepository {
    return GetIt.instance<ConectivityRepository>();
  }

  NotificacionesController get notificacionesController {
    return GetIt.instance<NotificacionesController>();
  }

  CooperacionRepository get coperacionRepository {
    return GetIt.instance<CooperacionRepository>();
  }

  NativeRepository get nativeRepository {
    return GetIt.instance<NativeRepository>();
  }

  SesionRepository get sesionRepository {
    return GetIt.instance<SesionRepository>();
  }

  SecureStorageService get secureStorageService {
    return GetIt.instance<SecureStorageService>();
  }

  SharedPreferencesService get sharedPreferencesService {
    return GetIt.instance<SharedPreferencesService>();
  }

  NotificacionesRepository get notificaccionesRepository {
    return GetIt.instance<NotificacionesRepository>();
  }
}
