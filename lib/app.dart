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
    // Actualiza idioma
    i18nSingleton.update(TranslationsCommons.of(context));

    GetIt.instance<I18nCommonsSingleton>().update(
      TranslationProvider.of(context).locale.flutterLocale.languageCode,
    );

    return Consumer<ThemeController>(
      builder: (context, themeController, child) {
        return MaterialApp.router(
          title: "Tesora",
          supportedLocales: const [
            Locale('es', 'ES'),
            Locale('en', 'US'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          themeMode: themeController.state.themeMode,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          locale: TranslationProvider.of(context).locale.flutterLocale,


        );
      },
    );
  }
}
