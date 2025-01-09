// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MenuState {
  int get item =>
      throw _privateConstructorUsedError; // Elemento actual seleccionado en el menú.
  String get currentMenuItem =>
      throw _privateConstructorUsedError; // Indica si el drawer está abierto.
  bool get isDrawerOpen =>
      throw _privateConstructorUsedError; // Lista de elementos del menú.
  List<String> get menuItems =>
      throw _privateConstructorUsedError; // Nombre del usuario para mostrar en el drawer.
  String? get userName =>
      throw _privateConstructorUsedError; // Foto de perfil del usuario.
  String? get userProfilePicture =>
      throw _privateConstructorUsedError; // Contador de notificaciones.
  int get notificationsCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MenuStateCopyWith<MenuState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuStateCopyWith<$Res> {
  factory $MenuStateCopyWith(MenuState value, $Res Function(MenuState) then) =
      _$MenuStateCopyWithImpl<$Res, MenuState>;
  @useResult
  $Res call(
      {int item,
      String currentMenuItem,
      bool isDrawerOpen,
      List<String> menuItems,
      String? userName,
      String? userProfilePicture,
      int notificationsCount});
}

/// @nodoc
class _$MenuStateCopyWithImpl<$Res, $Val extends MenuState>
    implements $MenuStateCopyWith<$Res> {
  _$MenuStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
    Object? currentMenuItem = null,
    Object? isDrawerOpen = null,
    Object? menuItems = null,
    Object? userName = freezed,
    Object? userProfilePicture = freezed,
    Object? notificationsCount = null,
  }) {
    return _then(_value.copyWith(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as int,
      currentMenuItem: null == currentMenuItem
          ? _value.currentMenuItem
          : currentMenuItem // ignore: cast_nullable_to_non_nullable
              as String,
      isDrawerOpen: null == isDrawerOpen
          ? _value.isDrawerOpen
          : isDrawerOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      menuItems: null == menuItems
          ? _value.menuItems
          : menuItems // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      userProfilePicture: freezed == userProfilePicture
          ? _value.userProfilePicture
          : userProfilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationsCount: null == notificationsCount
          ? _value.notificationsCount
          : notificationsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MenuStateImplCopyWith<$Res>
    implements $MenuStateCopyWith<$Res> {
  factory _$$MenuStateImplCopyWith(
          _$MenuStateImpl value, $Res Function(_$MenuStateImpl) then) =
      __$$MenuStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int item,
      String currentMenuItem,
      bool isDrawerOpen,
      List<String> menuItems,
      String? userName,
      String? userProfilePicture,
      int notificationsCount});
}

/// @nodoc
class __$$MenuStateImplCopyWithImpl<$Res>
    extends _$MenuStateCopyWithImpl<$Res, _$MenuStateImpl>
    implements _$$MenuStateImplCopyWith<$Res> {
  __$$MenuStateImplCopyWithImpl(
      _$MenuStateImpl _value, $Res Function(_$MenuStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
    Object? currentMenuItem = null,
    Object? isDrawerOpen = null,
    Object? menuItems = null,
    Object? userName = freezed,
    Object? userProfilePicture = freezed,
    Object? notificationsCount = null,
  }) {
    return _then(_$MenuStateImpl(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as int,
      currentMenuItem: null == currentMenuItem
          ? _value.currentMenuItem
          : currentMenuItem // ignore: cast_nullable_to_non_nullable
              as String,
      isDrawerOpen: null == isDrawerOpen
          ? _value.isDrawerOpen
          : isDrawerOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      menuItems: null == menuItems
          ? _value._menuItems
          : menuItems // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      userProfilePicture: freezed == userProfilePicture
          ? _value.userProfilePicture
          : userProfilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationsCount: null == notificationsCount
          ? _value.notificationsCount
          : notificationsCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$MenuStateImpl implements _MenuState {
  _$MenuStateImpl(
      {this.item = 0,
      this.currentMenuItem = RoutePath.splash,
      this.isDrawerOpen = false,
      final List<String> menuItems = const [],
      this.userName,
      this.userProfilePicture,
      this.notificationsCount = 0})
      : _menuItems = menuItems;

  @override
  @JsonKey()
  final int item;
// Elemento actual seleccionado en el menú.
  @override
  @JsonKey()
  final String currentMenuItem;
// Indica si el drawer está abierto.
  @override
  @JsonKey()
  final bool isDrawerOpen;
// Lista de elementos del menú.
  final List<String> _menuItems;
// Lista de elementos del menú.
  @override
  @JsonKey()
  List<String> get menuItems {
    if (_menuItems is EqualUnmodifiableListView) return _menuItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_menuItems);
  }

// Nombre del usuario para mostrar en el drawer.
  @override
  final String? userName;
// Foto de perfil del usuario.
  @override
  final String? userProfilePicture;
// Contador de notificaciones.
  @override
  @JsonKey()
  final int notificationsCount;

  @override
  String toString() {
    return 'MenuState(item: $item, currentMenuItem: $currentMenuItem, isDrawerOpen: $isDrawerOpen, menuItems: $menuItems, userName: $userName, userProfilePicture: $userProfilePicture, notificationsCount: $notificationsCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenuStateImpl &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.currentMenuItem, currentMenuItem) ||
                other.currentMenuItem == currentMenuItem) &&
            (identical(other.isDrawerOpen, isDrawerOpen) ||
                other.isDrawerOpen == isDrawerOpen) &&
            const DeepCollectionEquality()
                .equals(other._menuItems, _menuItems) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userProfilePicture, userProfilePicture) ||
                other.userProfilePicture == userProfilePicture) &&
            (identical(other.notificationsCount, notificationsCount) ||
                other.notificationsCount == notificationsCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      item,
      currentMenuItem,
      isDrawerOpen,
      const DeepCollectionEquality().hash(_menuItems),
      userName,
      userProfilePicture,
      notificationsCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MenuStateImplCopyWith<_$MenuStateImpl> get copyWith =>
      __$$MenuStateImplCopyWithImpl<_$MenuStateImpl>(this, _$identity);
}

abstract class _MenuState implements MenuState {
  factory _MenuState(
      {final int item,
      final String currentMenuItem,
      final bool isDrawerOpen,
      final List<String> menuItems,
      final String? userName,
      final String? userProfilePicture,
      final int notificationsCount}) = _$MenuStateImpl;

  @override
  int get item;
  @override // Elemento actual seleccionado en el menú.
  String get currentMenuItem;
  @override // Indica si el drawer está abierto.
  bool get isDrawerOpen;
  @override // Lista de elementos del menú.
  List<String> get menuItems;
  @override // Nombre del usuario para mostrar en el drawer.
  String? get userName;
  @override // Foto de perfil del usuario.
  String? get userProfilePicture;
  @override // Contador de notificaciones.
  int get notificationsCount;
  @override
  @JsonKey(ignore: true)
  _$$MenuStateImplCopyWith<_$MenuStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
