// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notificaciones_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NotificacionesState {
  List<Notificacion> get lista => throw _privateConstructorUsedError;
  bool get cargando => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NotificacionesStateCopyWith<NotificacionesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificacionesStateCopyWith<$Res> {
  factory $NotificacionesStateCopyWith(
          NotificacionesState value, $Res Function(NotificacionesState) then) =
      _$NotificacionesStateCopyWithImpl<$Res, NotificacionesState>;
  @useResult
  $Res call({List<Notificacion> lista, bool cargando, String? error});
}

/// @nodoc
class _$NotificacionesStateCopyWithImpl<$Res, $Val extends NotificacionesState>
    implements $NotificacionesStateCopyWith<$Res> {
  _$NotificacionesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lista = null,
    Object? cargando = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      lista: null == lista
          ? _value.lista
          : lista // ignore: cast_nullable_to_non_nullable
              as List<Notificacion>,
      cargando: null == cargando
          ? _value.cargando
          : cargando // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificacionesStateImplCopyWith<$Res>
    implements $NotificacionesStateCopyWith<$Res> {
  factory _$$NotificacionesStateImplCopyWith(_$NotificacionesStateImpl value,
          $Res Function(_$NotificacionesStateImpl) then) =
      __$$NotificacionesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Notificacion> lista, bool cargando, String? error});
}

/// @nodoc
class __$$NotificacionesStateImplCopyWithImpl<$Res>
    extends _$NotificacionesStateCopyWithImpl<$Res, _$NotificacionesStateImpl>
    implements _$$NotificacionesStateImplCopyWith<$Res> {
  __$$NotificacionesStateImplCopyWithImpl(_$NotificacionesStateImpl _value,
      $Res Function(_$NotificacionesStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lista = null,
    Object? cargando = null,
    Object? error = freezed,
  }) {
    return _then(_$NotificacionesStateImpl(
      lista: null == lista
          ? _value._lista
          : lista // ignore: cast_nullable_to_non_nullable
              as List<Notificacion>,
      cargando: null == cargando
          ? _value.cargando
          : cargando // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$NotificacionesStateImpl implements _NotificacionesState {
  const _$NotificacionesStateImpl(
      {final List<Notificacion> lista = const [],
      this.cargando = false,
      this.error})
      : _lista = lista;

  final List<Notificacion> _lista;
  @override
  @JsonKey()
  List<Notificacion> get lista {
    if (_lista is EqualUnmodifiableListView) return _lista;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lista);
  }

  @override
  @JsonKey()
  final bool cargando;
  @override
  final String? error;

  @override
  String toString() {
    return 'NotificacionesState(lista: $lista, cargando: $cargando, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificacionesStateImpl &&
            const DeepCollectionEquality().equals(other._lista, _lista) &&
            (identical(other.cargando, cargando) ||
                other.cargando == cargando) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_lista), cargando, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificacionesStateImplCopyWith<_$NotificacionesStateImpl> get copyWith =>
      __$$NotificacionesStateImplCopyWithImpl<_$NotificacionesStateImpl>(
          this, _$identity);
}

abstract class _NotificacionesState implements NotificacionesState {
  const factory _NotificacionesState(
      {final List<Notificacion> lista,
      final bool cargando,
      final String? error}) = _$NotificacionesStateImpl;

  @override
  List<Notificacion> get lista;
  @override
  bool get cargando;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$NotificacionesStateImplCopyWith<_$NotificacionesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
