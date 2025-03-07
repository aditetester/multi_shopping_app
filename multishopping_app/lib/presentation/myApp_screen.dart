import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:multishopping_app/constants/app_theme.dart';
import 'package:multishopping_app/presentation/profile/store/language/language_store.dart';
import 'package:multishopping_app/utils/locale/app_localization.dart';
import 'package:multishopping_app/di/theme_module.dart';
import 'package:multishopping_app/presentation/tabView_screen.dart';
import 'package:multishopping_app/presentation/profile/store/theme/theme_store.dart';
import '../utils/routes/routes.dart';

class MyAppScreen extends StatelessWidget {
  const MyAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeStore _themeStore = getIt<ThemeStore>();
    final LanguageStore _languageStore = getIt<LanguageStore>();

    return Observer(
      builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MultiShopping App',
          theme: _themeStore.darkMode
              ? AppThemeData.darkTheme
              : AppThemeData.lightTheme,
          locale: Locale(_languageStore.locale),
          supportedLocales: _languageStore.supportedLanguages
              .map((language) => Locale(language.locale, language.code))
              .toList(),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          initialRoute: TabViewScreen.routeName,
          routes: appRoutes,
        );
      },
    );
  }
}
