import 'package:domain/src/by/grodno/vasili/spinme/domain/settings/game_mode.dart';
import 'package:domain/src/by/grodno/vasili/spinme/domain/settings/language.dart';

/// Repository for work with app settings.
abstract class SettingsRepository {
  /// Save [language].
  saveLanguage(Language language);

  /// Return current stored language.
  /// Can be null if it is not stored in [saveLanguage] yet.
  Language? getLanguage();

  /// Persist [GameMode].
  saveGameMode(GameMode mode);

  /// Get stored [GameMode] or default if it was not stored yet.
  GameMode getGameMode();
}
