import 'package:domain/domain_module.dart';

/// Coordinator to handle interactions with welcome screen.
class WelcomeCoordinator {
  WelcomeCoordinator(this._settings);

  final Settings _settings;

  void setLanguage(Language language) {
    _settings.language = language;
  }

  void setGameMode(GameMode mode) {
    _settings.gameMode = mode;
  }

  GameMode getGameMode() => _settings.gameMode;
}
