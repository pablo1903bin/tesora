import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_state.freezed.dart';

@freezed
class ThemeState with _$ThemeState {
  // Constructor que define las propiedades del estado.
  factory ThemeState({
    // Propiedad para el modo de tema (por defecto es el modo del sistema).
    @Default(ThemeMode.system) ThemeMode themeMode,
    // Propiedad para identificar si el tema actual es oscuro.
    @Default(false) bool isDarkMode,
  }) = _ThemeState;
}
