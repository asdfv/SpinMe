import 'package:data/data_module.dart';
import 'package:domain/domain_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/welcome/welcome_page.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/localization/app_localization.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/main.dart';

import 'navigation/main_router_generator.dart';

final mainNavigatorKey = GlobalKey<NavigatorState>();

class SpinMeApp extends StatefulWidget {
  final Settings _settings = getIt<Settings>();

  static _SpinMeAppState? of(BuildContext context) => context.findAncestorStateOfType<_SpinMeAppState>();

  @override
  _SpinMeAppState createState() => _SpinMeAppState();
}

class _SpinMeAppState extends State<SpinMeApp> {
  Language? _language;
  final log = getLogger();

  /// Get current app language.
  /// Can be null in case language is not stored yet
  /// that can only happen short moment when app is starting very first time.
  Language? getLanguage() => _language;

  /// Set and save [language].
  void setLanguage(Language language) {
    setState(() {
      _language = language;
    });
    widget._settings.language = language;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "SpinMe",
        initialRoute: routeWelcome,
        locale: _language == null ? null : _languageToLocale(_language!),
        navigatorKey: mainNavigatorKey,
        onGenerateRoute: MainRouteGenerator.generateRoute,
        supportedLocales: [Locale('en', 'EN'), Locale('ru', 'RU')],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        localeResolutionCallback: (systemLocale, supportedLocales) {
          final storedLanguage = widget._settings.language;
          log.i(message: "System language: ${systemLocale?.languageCode}, stored language: $storedLanguage");
          final Locale localeToLoad;
          if (storedLanguage == null) {
            localeToLoad =
                supportedLocales.contains(systemLocale) && systemLocale != null ? systemLocale : supportedLocales.first;
            widget._settings.language = _localeToLanguage(localeToLoad);
          } else {
            localeToLoad = _languageToLocale(storedLanguage);
          }
          _language = _localeToLanguage(localeToLoad);
          return localeToLoad;
        });
  }

  Locale _languageToLocale(Language language) => Locale(language.toString().split(".").last.toLowerCase());

  Language _localeToLanguage(Locale locale) => locale.languageCode.enumFromString(Language.values)!;

  @override
  void dispose() {
    stopDataLayer();
    super.dispose();
  }
}
