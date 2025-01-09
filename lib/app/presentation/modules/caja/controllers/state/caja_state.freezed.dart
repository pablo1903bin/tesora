// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'caja_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CajaState {
  int get bnbIndex => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CajaStateCopyWith<CajaState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CajaStateCopyWith<$Res> {
  factory $CajaStateCopyWith(CajaState value, $Res Function(CajaState) then) =
      _$CajaStateCopyWithImpl<$Res, CajaState>;
  @useResult
  $Res call({int bnbIndex});
}

/// @nodoc
class _$CajaStateCopyWithImpl<$Res, $Val extends CajaState>
    implements $CajaStateCopyWith<$Res> {
  _$CajaStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bnbIndex = null,
  }) {
    return _then(_value.copyWith(
      bnbIndex: null == bnbIndex
          ? _value.bnbIndex
          : bnbIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CajaStateImplCopyWith<$Res>
    implements $CajaStateCopyWith<$Res> {
  factory _$$CajaStateImplCopyWith(
          _$CajaStateImpl value, $Res Function(_$CajaStateImpl) then) =
      __$$CajaStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int bnbIndex});
}

/// @nodoc
class __$$CajaStateImplCopyWithImpl<$Res>
    extends _$CajaStateCopyWithImpl<$Res, _$CajaStateImpl>
    implements _$$CajaStateImplCopyWith<$Res> {
  __$$CajaStateImplCopyWithImpl(
      _$CajaStateImpl _value, $Res Function(_$CajaStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bnbIndex = null,
  }) {
    return _then(_$CajaStateImpl(
      bnbIndex: null == bnbIndex
          ? _value.bnbIndex
          : bnbIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$CajaStateImpl implements _CajaState {
  const _$CajaStateImpl({this.bnbIndex = 0});

  @override
  @JsonKey()
  final int bnbIndex;

  @override
  String toString() {
    return 'CajaState(bnbIndex: $bnbIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CajaStateImpl &&
            (identical(other.bnbIndex, bnbIndex) ||
                other.bnbIndex == bnbIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, bnbIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CajaStateImplCopyWith<_$CajaStateImpl> get copyWith =>
      __$$CajaStateImplCopyWithImpl<_$CajaStateImpl>(this, _$identity);
}

abstract class _CajaState implements CajaState {
  const factory _CajaState({final int bnbIndex}) = _$CajaStateImpl;

  @override
  int get bnbIndex;
  @override
  @JsonKey(ignore: true)
  _$$CajaStateImplCopyWith<_$CajaStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
