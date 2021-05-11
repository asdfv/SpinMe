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
