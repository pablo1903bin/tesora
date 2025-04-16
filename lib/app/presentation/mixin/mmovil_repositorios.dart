import 'package:get_it/get_it.dart';
import 'package:tesora/app/domain/repositories/authentication_repository.dart';


mixin MmovilRepositorios {


    AuthenticationRepository get getAuthenticationRepository {
    return GetIt.instance<AuthenticationRepository>();
  }


}
