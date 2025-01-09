import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:tesora/app/presentation/global/widgets/theme_config.dart';
import 'package:tesora/app/presentation/mixin/controllers_mixin.dart';
import 'package:tesora/app/presentation/mixin/i18n_mixin.dart';
import 'package:tesora/app/presentation/singletons/i18n_commons_singleton.dart';
import 'package:tesora/gen/i18n/translations_mobil.g.dart';

import 'app/presentation/controller/theme_controller.dart';
import 'app/presentation/routes/routes.dart';

class MyApp extends StatelessWidget with ControllersMixin, Routes, I18NMixin {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Actualiza el idioma para la aplicación usando el singleton de i18n
    i18nSingleton.update(TranslationsCommons.of(context));
    GetIt.instance<I18nCommonsSingleton>().update(
        TranslationProvider.of(context).locale.flutterLocale.languageCode);

    // Escucha los cambios en el controlador de temas
    return Consumer<ThemeController>(
      builder: (context, themeController, child) {
        return MaterialApp.router(
          title: "Tesora", // Título de la aplicación
          supportedLocales: const [
            Locale('es', 'ES'), // Soporte para idioma Español
            Locale('en', 'US'), // Soporte para idioma Inglés
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate, // Soporte para material design
            GlobalWidgetsLocalizations.delegate, // Soporte para widgets
            GlobalCupertinoLocalizations.delegate, // Soporte para Cupertino
          ],
          // Define el modo de tema basado en el controlador de estado
          themeMode: themeController.state.themeMode,
          theme: AppThemes.lightTheme, // Tema claro de la aplicación
          darkTheme: AppThemes.darkTheme, // Tema oscuro de la aplicación
          debugShowCheckedModeBanner: false, // Oculta el banner de debug
          routerConfig: router, // Configuración de rutas para navegación
          locale: TranslationProvider.of(context).locale.flutterLocale, // Idioma actual
        );
      },
    );
  }
}
