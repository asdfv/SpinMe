import 'package:domain/domain_module.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class PrepareState extends Equatable {
  final bool isLoading;
  final List<Task>? tasks;

  PrepareState({this.isLoading = true, this.tasks});

  PrepareState copyWith({final List<Task>? tasks, final bool? isLoading}) => PrepareState(
        tasks: tasks ?? this.tasks,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object?> get props => [tasks, isLoading];
}
