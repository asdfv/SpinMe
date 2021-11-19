import 'package:domain/domain_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'welcome_event.dart';
import 'welcome_state.dart';

/// [Bloc] for reducing events on Welcome screen to UI states.
class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc(this.coordinator) : super(WelcomeState());

  final WelcomeCoordinator coordinator;

  @override
  Stream<WelcomeState> mapEventToState(WelcomeEvent event) async* {
    if (event is GameModeRequested)
      yield* _mapLoadGameMode();
    else if (event is LanguageChosen)
      yield* _mapLanguageChosen(event.language);
    else if (event is ModeChosen)
      yield* _mapModeChosen(event.mode);
    else
      throw UnimplementedError("Unknown welcome-event: $event");
  }

  Stream<WelcomeState> _mapLanguageChosen(Language language) async* {
    coordinator.setLanguage(language);
    yield state.copyWith(language: language);
  }

  Stream<WelcomeState> _mapModeChosen(GameMode mode) async* {
    coordinator.setGameMode(mode);
    yield state.copyWith(mode: mode);
  }

  Stream<WelcomeState> _mapLoadGameMode() async* {
    final gameMode = coordinator.getGameMode();
    yield state.copyWith(mode: gameMode);
  }
}
