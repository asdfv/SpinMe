import 'package:equatable/equatable.dart';

/// Task domain model.
class Task extends Equatable {
  const Task(this.id, this.description, this.isChecked);

  final int id;
  final String description;
  final bool isChecked;

  @override
  List<Object?> get props => [id, description, isChecked];

  Task copyWith({final String? description, final bool? isChecked}) => Task(
        this.id,
        description ?? this.description,
        isChecked ?? this.isChecked,
      );

  @override
  String toString() => "Task(id: $id, description: ${description.substring(0, 3)}, isChecked: $isChecked)";
}
