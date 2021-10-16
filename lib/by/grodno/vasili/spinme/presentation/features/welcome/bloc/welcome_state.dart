import 'package:domain/domain_module.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

@immutable
class WelcomeState extends Equatable {
  WelcomeState({this.language, this.mode});

  final Language? language;
  final GameMode? mode;

  WelcomeState copyWith({language, mode}) => WelcomeState(
        language: language ?? this.language,
        mode: mode ?? this.mode,
      );

  @override
  List<Object?> get props => [language, mode];
}
