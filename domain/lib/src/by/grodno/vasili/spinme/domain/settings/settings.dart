import 'package:domain/domain_module.dart';

/// Application settings.
class Settings {
  final SettingsRepository _repository;
  final log = getLogger();

  Settings(this._repository);

  Language? get language => _repository.getLanguage();

  set language(Language? value) {
    if (value == null) return;
    log.d(message: "Storing language $value");
    _repository.saveLanguage(value);
  }

  GameMode get gameMode => _repository.getGameMode();

  set gameMode(GameMode? value) {
    if (value == null) return;
    log.d(message: "Storing game mode $value");
    _repository.saveGameMode(value);
  }
}
