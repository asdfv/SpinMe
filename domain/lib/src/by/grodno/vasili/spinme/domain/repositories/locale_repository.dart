/// Repository for work with localization.
abstract class LocaleRepository {

  /// Save [language].
  Future saveLanguage(String language);

  /// Return current stored language.
  /// Can be null if it is not stored in [saveLanguage] yet.
  String? getCurrentLanguage();
}