import 'package:data/data_module.dart';
import 'package:domain/domain_module.dart';

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
  String? getLanguage() => _getValue(LANGUAGE_KEY);

  @override
  saveLanguage(String language) {
    _setValue(LANGUAGE_KEY, language);
  }

  T? _getValue<T>(dynamic key, {T? defaultValue}) => _box.get(key, defaultValue: defaultValue) as T?;

  Future<void> _setValue<T>(dynamic key, T value) => _box.put(key, value);
}
