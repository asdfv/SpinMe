import 'package:data/data_module.dart';
import 'package:domain/domain_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  String? _language;
  final log = getLogger();

  /// Get current app locale.
  /// Can be null in case locale is not stored yet
  /// that can only happen short moment when app is starting very first time.
  String? getLanguage() => _language;

  /// Set and save [language].
  void setLanguage(String language) {
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
        locale: _language != null ? Locale(_language!) : null,
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
            widget._settings.language = localeToLoad.languageCode;
          } else {
            localeToLoad = Locale(storedLanguage);
          }
          _language = localeToLoad.languageCode;
          return localeToLoad;
        });
  }

  @override
  void dispose() {
    stopDataLayer();
    super.dispose();
  }
}
