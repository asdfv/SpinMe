import 'package:domain/domain_module.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class PrepareState extends Equatable {
  final bool isLoading;
  final List<Task>? tasks;
  final List<Player>? players;

  PrepareState({this.isLoading = true, this.tasks, this.players});

  PrepareState copyWith({
    final List<Task>? tasks,
    final List<Player>? players,
    final bool? isLoading,
  }) =>
      PrepareState(
        tasks: tasks ?? this.tasks,
        players: players ?? this.players,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [tasks, players, isLoading];
}
