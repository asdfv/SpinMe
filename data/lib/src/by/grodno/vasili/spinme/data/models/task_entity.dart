import 'package:domain/domain_module.dart';
import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  TaskEntity(this.id, this.description, this.isChecked);

  TaskEntity.fromDomainModel(Task task)
      : this.id = task.id,
        this.description = task.description,
        this.isChecked = task.isChecked;

  final int id;
  final String description;
  final bool isChecked;

  @override
  List<Object?> get props => [id];
}

extension TaskEntityConverter on TaskEntity {
  Task toDomainModel() => Task(id: this.id, description: this.description, isChecked: this.isChecked);
}
