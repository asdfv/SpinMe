import 'package:domain/domain_module.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class WelcomeEvent extends Equatable {}

class GameModeRequested extends WelcomeEvent {
  @override
  List<Object?> get props => [];
}

class LanguageChosen extends WelcomeEvent {
  LanguageChosen(this.language);

  final Language language;

  @override
  List<Object?> get props => [language];
}

class ModeChosen extends WelcomeEvent {
  ModeChosen(this.mode);

  final GameMode mode;

  @override
  List<Object?> get props => [mode];
}
