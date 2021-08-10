import 'package:data/data_module.dart';
import 'package:data/src/by/grodno/vasili/spinme/data/models/member_entity.dart';
import 'package:domain/domain_module.dart';

/// Repository to store member data.
/// Currently it is user language only, but can be extended in the future.
class LocaleDataRepository extends LocaleRepository {
  final _memberBox = memberBox;
  final log = getLogger();
  static const LANGUAGE_KEY = 1;

  /// Save [language].
  Future saveLanguage(String language) async {
    await _memberBox.put(LANGUAGE_KEY, MemberEntity(language));
    log.i(message: "Language saved: $language");
  }

  /// Get current language.
  /// Returns null if it does not stored yet in [saveLanguage].
  String? getCurrentLanguage() {
    return _memberBox.get(LANGUAGE_KEY)?.locale;
  }
}
