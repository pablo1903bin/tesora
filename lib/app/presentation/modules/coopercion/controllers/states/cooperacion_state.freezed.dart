// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cooperacion_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CooperacionState {
  List<dynamic>? get cooperaciones => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CooperacionStateCopyWith<CooperacionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CooperacionStateCopyWith<$Res> {
  factory $CooperacionStateCopyWith(
          CooperacionState value, $Res Function(CooperacionState) then) =
      _$CooperacionStateCopyWithImpl<$Res, CooperacionState>;
  @useResult
  $Res call({List<dynamic>? cooperaciones});
}

/// @nodoc
class _$CooperacionStateCopyWithImpl<$Res, $Val extends CooperacionState>
    implements $CooperacionStateCopyWith<$Res> {
  _$CooperacionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cooperaciones = freezed,
  }) {
    return _then(_value.copyWith(
      cooperaciones: freezed == cooperaciones
          ? _value.cooperaciones
          : cooperaciones // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CooperacionStateImplCopyWith<$Res>
    implements $CooperacionStateCopyWith<$Res> {
  factory _$$CooperacionStateImplCopyWith(_$CooperacionStateImpl value,
          $Res Function(_$CooperacionStateImpl) then) =
      __$$CooperacionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<dynamic>? cooperaciones});
}

/// @nodoc
class __$$CooperacionStateImplCopyWithImpl<$Res>
    extends _$CooperacionStateCopyWithImpl<$Res, _$CooperacionStateImpl>
    implements _$$CooperacionStateImplCopyWith<$Res> {
  __$$CooperacionStateImplCopyWithImpl(_$CooperacionStateImpl _value,
      $Res Function(_$CooperacionStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cooperaciones = freezed,
  }) {
    return _then(_$CooperacionStateImpl(
      cooperaciones: freezed == cooperaciones
          ? _value._cooperaciones
          : cooperaciones // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc

class _$CooperacionStateImpl implements _CooperacionState {
  const _$CooperacionStateImpl({final List<dynamic>? cooperaciones = const []})
      : _cooperaciones = cooperaciones;

  final List<dynamic>? _cooperaciones;
  @override
  @JsonKey()
  List<dynamic>? get cooperaciones {
    final value = _cooperaciones;
    if (value == null) return null;
    if (_cooperaciones is EqualUnmodifiableListView) return _cooperaciones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CooperacionState(cooperaciones: $cooperaciones)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CooperacionStateImpl &&
            const DeepCollectionEquality()
                .equals(other._cooperaciones, _cooperaciones));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_cooperaciones));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CooperacionStateImplCopyWith<_$CooperacionStateImpl> get copyWith =>
      __$$CooperacionStateImplCopyWithImpl<_$CooperacionStateImpl>(
          this, _$identity);
}

abstract class _CooperacionState implements CooperacionState {
  const factory _CooperacionState({final List<dynamic>? cooperaciones}) =
      _$CooperacionStateImpl;

  @override
  List<dynamic>? get cooperaciones;
  @override
  @JsonKey(ignore: true)
  _$$CooperacionStateImplCopyWith<_$CooperacionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
