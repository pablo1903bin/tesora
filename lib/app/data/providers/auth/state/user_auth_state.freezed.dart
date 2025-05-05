// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserAuthState {
  UserLoginResponse? get userResponse => throw _privateConstructorUsedError;
  RegisterResponse? get registerResponse => throw _privateConstructorUsedError;
  MmovilV1Response? get responseGeneral => throw _privateConstructorUsedError;
  String? get codigo => throw _privateConstructorUsedError;
  LoadingIndicatorController? get loadingIndicatorController =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserAuthStateCopyWith<UserAuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserAuthStateCopyWith<$Res> {
  factory $UserAuthStateCopyWith(
          UserAuthState value, $Res Function(UserAuthState) then) =
      _$UserAuthStateCopyWithImpl<$Res, UserAuthState>;
  @useResult
  $Res call(
      {UserLoginResponse? userResponse,
      RegisterResponse? registerResponse,
      MmovilV1Response? responseGeneral,
      String? codigo,
      LoadingIndicatorController? loadingIndicatorController});

  $UserLoginResponseCopyWith<$Res>? get userResponse;
  $MmovilV1ResponseCopyWith<$Res>? get responseGeneral;
}

/// @nodoc
class _$UserAuthStateCopyWithImpl<$Res, $Val extends UserAuthState>
    implements $UserAuthStateCopyWith<$Res> {
  _$UserAuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userResponse = freezed,
    Object? registerResponse = freezed,
    Object? responseGeneral = freezed,
    Object? codigo = freezed,
    Object? loadingIndicatorController = freezed,
  }) {
    return _then(_value.copyWith(
      userResponse: freezed == userResponse
          ? _value.userResponse
          : userResponse // ignore: cast_nullable_to_non_nullable
              as UserLoginResponse?,
      registerResponse: freezed == registerResponse
          ? _value.registerResponse
          : registerResponse // ignore: cast_nullable_to_non_nullable
              as RegisterResponse?,
      responseGeneral: freezed == responseGeneral
          ? _value.responseGeneral
          : responseGeneral // ignore: cast_nullable_to_non_nullable
              as MmovilV1Response?,
      codigo: freezed == codigo
          ? _value.codigo
          : codigo // ignore: cast_nullable_to_non_nullable
              as String?,
      loadingIndicatorController: freezed == loadingIndicatorController
          ? _value.loadingIndicatorController
          : loadingIndicatorController // ignore: cast_nullable_to_non_nullable
              as LoadingIndicatorController?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserLoginResponseCopyWith<$Res>? get userResponse {
    if (_value.userResponse == null) {
      return null;
    }

    return $UserLoginResponseCopyWith<$Res>(_value.userResponse!, (value) {
      return _then(_value.copyWith(userResponse: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MmovilV1ResponseCopyWith<$Res>? get responseGeneral {
    if (_value.responseGeneral == null) {
      return null;
    }

    return $MmovilV1ResponseCopyWith<$Res>(_value.responseGeneral!, (value) {
      return _then(_value.copyWith(responseGeneral: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserAuthStateImplCopyWith<$Res>
    implements $UserAuthStateCopyWith<$Res> {
  factory _$$UserAuthStateImplCopyWith(
          _$UserAuthStateImpl value, $Res Function(_$UserAuthStateImpl) then) =
      __$$UserAuthStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UserLoginResponse? userResponse,
      RegisterResponse? registerResponse,
      MmovilV1Response? responseGeneral,
      String? codigo,
      LoadingIndicatorController? loadingIndicatorController});

  @override
  $UserLoginResponseCopyWith<$Res>? get userResponse;
  @override
  $MmovilV1ResponseCopyWith<$Res>? get responseGeneral;
}

/// @nodoc
class __$$UserAuthStateImplCopyWithImpl<$Res>
    extends _$UserAuthStateCopyWithImpl<$Res, _$UserAuthStateImpl>
    implements _$$UserAuthStateImplCopyWith<$Res> {
  __$$UserAuthStateImplCopyWithImpl(
      _$UserAuthStateImpl _value, $Res Function(_$UserAuthStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userResponse = freezed,
    Object? registerResponse = freezed,
    Object? responseGeneral = freezed,
    Object? codigo = freezed,
    Object? loadingIndicatorController = freezed,
  }) {
    return _then(_$UserAuthStateImpl(
      userResponse: freezed == userResponse
          ? _value.userResponse
          : userResponse // ignore: cast_nullable_to_non_nullable
              as UserLoginResponse?,
      registerResponse: freezed == registerResponse
          ? _value.registerResponse
          : registerResponse // ignore: cast_nullable_to_non_nullable
              as RegisterResponse?,
      responseGeneral: freezed == responseGeneral
          ? _value.responseGeneral
          : responseGeneral // ignore: cast_nullable_to_non_nullable
              as MmovilV1Response?,
      codigo: freezed == codigo
          ? _value.codigo
          : codigo // ignore: cast_nullable_to_non_nullable
              as String?,
      loadingIndicatorController: freezed == loadingIndicatorController
          ? _value.loadingIndicatorController
          : loadingIndicatorController // ignore: cast_nullable_to_non_nullable
              as LoadingIndicatorController?,
    ));
  }
}

/// @nodoc

class _$UserAuthStateImpl implements _UserAuthState {
  _$UserAuthStateImpl(
      {this.userResponse,
      this.registerResponse,
      this.responseGeneral,
      this.codigo = null,
      this.loadingIndicatorController});

  @override
  final UserLoginResponse? userResponse;
  @override
  final RegisterResponse? registerResponse;
  @override
  final MmovilV1Response? responseGeneral;
  @override
  @JsonKey()
  final String? codigo;
  @override
  final LoadingIndicatorController? loadingIndicatorController;

  @override
  String toString() {
    return 'UserAuthState(userResponse: $userResponse, registerResponse: $registerResponse, responseGeneral: $responseGeneral, codigo: $codigo, loadingIndicatorController: $loadingIndicatorController)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserAuthStateImpl &&
            (identical(other.userResponse, userResponse) ||
                other.userResponse == userResponse) &&
            (identical(other.registerResponse, registerResponse) ||
                other.registerResponse == registerResponse) &&
            (identical(other.responseGeneral, responseGeneral) ||
                other.responseGeneral == responseGeneral) &&
            (identical(other.codigo, codigo) || other.codigo == codigo) &&
            (identical(other.loadingIndicatorController,
                    loadingIndicatorController) ||
                other.loadingIndicatorController ==
                    loadingIndicatorController));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userResponse, registerResponse,
      responseGeneral, codigo, loadingIndicatorController);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserAuthStateImplCopyWith<_$UserAuthStateImpl> get copyWith =>
      __$$UserAuthStateImplCopyWithImpl<_$UserAuthStateImpl>(this, _$identity);
}

abstract class _UserAuthState implements UserAuthState {
  factory _UserAuthState(
          {final UserLoginResponse? userResponse,
          final RegisterResponse? registerResponse,
          final MmovilV1Response? responseGeneral,
          final String? codigo,
          final LoadingIndicatorController? loadingIndicatorController}) =
      _$UserAuthStateImpl;

  @override
  UserLoginResponse? get userResponse;
  @override
  RegisterResponse? get registerResponse;
  @override
  MmovilV1Response? get responseGeneral;
  @override
  String? get codigo;
  @override
  LoadingIndicatorController? get loadingIndicatorController;
  @override
  @JsonKey(ignore: true)
  _$$UserAuthStateImplCopyWith<_$UserAuthStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
