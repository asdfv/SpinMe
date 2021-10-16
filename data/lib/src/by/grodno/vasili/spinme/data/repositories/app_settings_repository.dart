import 'package:domain/domain_module.dart';

import '../starter.dart';

/// [SettingsRepository] based on Hive database.
class AppSettingsRepository extends SettingsRepository {
  final _box = settingsBox;
  static const String LANGUAGE_KEY = "LANGUAGE_KEY";
  static const String MODE_KEY = "MODE_KEY";

  @override
  GameMode getGameMode() {
    final stringValue = _getValue(MODE_KEY, defaultValue: GameMode.tasksPerGame.toString());
    return GameMode.values.firstWhere((value) => value.toString() == stringValue);
  }

  @override
  saveGameMode(GameMode mode) {
    _setValue(MODE_KEY, mode.toString());
  }

  @override
  Language? getLanguage() {
    final String? stringValue = _getValue<String>(LANGUAGE_KEY);
    return stringValue?.enumFromString(Language.values);
  }

  @override
  saveLanguage(Language language) {
    _setValue(LANGUAGE_KEY, language.toString().split(".").last);
  }

  T? _getValue<T>(dynamic key, {T? defaultValue}) => _box.get(key, defaultValue: defaultValue) as T?;

  Future<void> _setValue<T>(dynamic key, T value) => _box.put(key, value);
}
