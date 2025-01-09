import 'package:flutter/material.dart';
import 'package:tesora/app/presentation/controller/states/theme_state.dart';
import 'package:tesora/app/states/state_notifier.dart';

class ThemeController extends StateNotifier<ThemeState> {
  // Inicializa el estado con valores predeterminados.
  ThemeController() : super(ThemeState());

  // Método para cambiar el modo de tema.
  void setThemeMode(ThemeMode mode) {
    notifica(state.copyWith(
      themeMode: mode,
      isDarkMode: mode == ThemeMode.dark,
    ));
  }


  void cambiarModoTema() {
    final isCurrentlyDark = state.isDarkMode;
    setThemeMode(isCurrentlyDark ? ThemeMode.light : ThemeMode.dark);
  }
}
