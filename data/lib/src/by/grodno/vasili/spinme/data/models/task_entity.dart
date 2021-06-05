import 'package:domain/domain_module.dart';
import 'package:hive/hive.dart';

part 'task_entity.g.dart';

@HiveType(typeId: 0)
class TaskEntity {
  TaskEntity(this.id, this.description, this.isChecked);

  TaskEntity.fromDomainModel(Task task)
      : this.id = task.id,
        this.description = task.description,
        this.isChecked = task.isChecked;

  @HiveField(0)
  int id;

  @HiveField(1)
  String description;

  @HiveField(2)
  bool isChecked;
}

extension TaskEntityConverter on TaskEntity {
  Task toDomainModel() => Task(id: this.id, description: this.description, isChecked: this.isChecked);
}
