// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gastos_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$GastosState {
// Lista de gastos
  List<dynamic>? get gastos => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GastosStateCopyWith<GastosState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GastosStateCopyWith<$Res> {
  factory $GastosStateCopyWith(
          GastosState value, $Res Function(GastosState) then) =
      _$GastosStateCopyWithImpl<$Res, GastosState>;
  @useResult
  $Res call({List<dynamic>? gastos});
}

/// @nodoc
class _$GastosStateCopyWithImpl<$Res, $Val extends GastosState>
    implements $GastosStateCopyWith<$Res> {
  _$GastosStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gastos = freezed,
  }) {
    return _then(_value.copyWith(
      gastos: freezed == gastos
          ? _value.gastos
          : gastos // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GastosStateImplCopyWith<$Res>
    implements $GastosStateCopyWith<$Res> {
  factory _$$GastosStateImplCopyWith(
          _$GastosStateImpl value, $Res Function(_$GastosStateImpl) then) =
      __$$GastosStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<dynamic>? gastos});
}

/// @nodoc
class __$$GastosStateImplCopyWithImpl<$Res>
    extends _$GastosStateCopyWithImpl<$Res, _$GastosStateImpl>
    implements _$$GastosStateImplCopyWith<$Res> {
  __$$GastosStateImplCopyWithImpl(
      _$GastosStateImpl _value, $Res Function(_$GastosStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gastos = freezed,
  }) {
    return _then(_$GastosStateImpl(
      gastos: freezed == gastos
          ? _value._gastos
          : gastos // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc

class _$GastosStateImpl implements _GastosState {
  const _$GastosStateImpl({final List<dynamic>? gastos = const []})
      : _gastos = gastos;

// Lista de gastos
  final List<dynamic>? _gastos;
// Lista de gastos
  @override
  @JsonKey()
  List<dynamic>? get gastos {
    final value = _gastos;
    if (value == null) return null;
    if (_gastos is EqualUnmodifiableListView) return _gastos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'GastosState(gastos: $gastos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GastosStateImpl &&
            const DeepCollectionEquality().equals(other._gastos, _gastos));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_gastos));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GastosStateImplCopyWith<_$GastosStateImpl> get copyWith =>
      __$$GastosStateImplCopyWithImpl<_$GastosStateImpl>(this, _$identity);
}

abstract class _GastosState implements GastosState {
  const factory _GastosState({final List<dynamic>? gastos}) = _$GastosStateImpl;

  @override // Lista de gastos
  List<dynamic>? get gastos;
  @override
  @JsonKey(ignore: true)
  _$$GastosStateImplCopyWith<_$GastosStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
