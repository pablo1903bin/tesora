


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tesora/app/domain/models/loguin/user_loguin_response.dart';
import 'package:tesora/app/presentation/controller/loading_lndicator_controller.dart';

import '../../../../domain/models/server_response/mmovil_v1_response.dart';
import '../../../../domain/models/usuario/register_response.dart';

part 'user_auth_state.freezed.dart';


@freezed
class UserAuthState with _$UserAuthState {
  factory UserAuthState({

  UserLoginResponse? userResponse,
  RegisterResponse? registerResponse,
  MmovilV1Response? responseGeneral,
  @Default(null)  String? codigo,
  LoadingIndicatorController?  loadingIndicatorController,
  }) = _UserAuthState;
}
