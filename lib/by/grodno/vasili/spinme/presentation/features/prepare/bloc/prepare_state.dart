import 'package:domain/domain_module.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class PrepareState extends Equatable {
  const PrepareState();
}

class TasksLoadingState extends PrepareState {

  @override
  List<Object?> get props => [];
}

class TasksLoadedState extends PrepareState {
  final List<Task> tasks;

  TasksLoadedState(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

class TaskLoadErrorState extends PrepareState {
  final String message;

  TaskLoadErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
