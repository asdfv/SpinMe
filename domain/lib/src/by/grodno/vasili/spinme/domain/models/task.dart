import 'package:equatable/equatable.dart';

class Task extends Equatable {
  Task({required this.id, required this.description, required this.isChecked});

  final int id;
  final String description;
  final bool isChecked;

  @override
  List<Object?> get props => [id, description, isChecked];

  Task copyWith({final String? description, final bool? isChecked}) => Task(
        id: this.id,
        description: description ?? this.description,
        isChecked: isChecked ?? this.isChecked,
      );

  @override
  String toString() => "Task(id: $id, description: ${description.substring(0, 4)}, isChecked: $isChecked)";
}
