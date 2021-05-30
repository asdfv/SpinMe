import 'package:domain/domain_module.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class PrepareEvent extends Equatable {
  const PrepareEvent();
}

class LoadTasks extends PrepareEvent {
  @override
  List<Object?> get props => [];
}

class NamesChosen extends PrepareEvent {
  NamesChosen(this.names);

  final List<String> names;

  @override
  List<Object?> get props => [names];
}

class TasksChosen extends PrepareEvent {
  TasksChosen(this.tasks);

  final List<Task> tasks;

  @override
  List<Object?> get props => [tasks];
}
