import 'dart:async';
import 'dart:convert';

import 'package:domain/domain_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Class to hold delegate with localizations and provide access to localized strings via [getLocalizedString].
class AppLocalizations {
  final log = getLogger();

  static AppLocalizations of(BuildContext context) => Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  late Map<String, String> _localizedStrings;

  Future<AppLocalizations> use(Locale locale) async {
    String jsonString = await rootBundle.loadString('assets/localizations/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    log.i(message: "Locale loaded: $locale");
    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
    return this;
  }

  /// Method to retrieve localized string.
  String? getLocalizedString(String key) {
    return _localizedStrings[key];
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ru'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async => await AppLocalizations().use(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
