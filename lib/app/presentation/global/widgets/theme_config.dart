import 'package:flutter/material.dart';
import 'package:tesora/app/presentation/global/widgets/colores.dart';

class AppThemes {
  // Tema claro de la aplicación
  static ThemeData lightTheme = ThemeData.light().copyWith(
    // Esquema de colores para el tema claro
    colorScheme: const ColorScheme.light(
      primary: colorPrincipal, // Color primario del tema
      secondary: colorAlterno2, // Color secundario (usado en botones o acentos)
      error: colorError, // Color para errores
      surface: colorAlterno5, // Color para superficies como tarjetas
    ),
    // Estilo de texto para el tema claro
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 18, color: Colors.black), // Texto principal
      bodyMedium: TextStyle(fontSize: 16, color: Colors.black54), // Texto secundario
    ),
    // Estilo del AppBar para el tema claro
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue, // Fondo del AppBar
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20), // Estilo del título
    ),
  );

  // Tema oscuro de la aplicación
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    // Esquema de colores para el tema oscuro
    colorScheme: const ColorScheme.dark(
      primary: colorBackground, // Color primario del tema
      secondary: colorSueve, // Color secundario
    ),
    // Estilo de texto para el tema oscuro
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 18, color: Colors.white), // Texto principal
      bodyMedium: TextStyle(fontSize: 16, color: Colors.white70), // Texto secundario
    ),
    // Estilo del AppBar para el tema oscuro
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.lightBlueAccent, // Fondo del AppBar
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20), // Estilo del título
    ),
  );
}
