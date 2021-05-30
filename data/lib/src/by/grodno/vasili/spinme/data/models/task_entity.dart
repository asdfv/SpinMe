import 'package:domain/domain_module.dart';

class TaskEntity {
  TaskEntity(this.id, this.description, this.isChecked);

  final int id;
  final String description;
  final bool isChecked;
}

extension TaskEntityConverter on TaskEntity {
  Task toDomainModel() => Task(this.id, this.description, this.isChecked);
}
