import 'package:domain/domain_module.dart';

class LocaleDataRepository extends LocaleRepository {
  String? language;
  final log = getLogger();

  @override
  String? getCurrentLanguage() {
    return language;
  }

  @override
  void saveLanguage(String language) {
    this.language = language;
    log.i(message: "Language saved: $language");
  }
}