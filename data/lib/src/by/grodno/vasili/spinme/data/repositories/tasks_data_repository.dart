import 'package:data/src/by/grodno/vasili/spinme/data/datasources/tasks/tasks_datasource.dart';
import 'package:data/src/by/grodno/vasili/spinme/data/models/task_entity.dart';
import 'package:domain/domain_module.dart';

/// Default implementation for TasksRepository.
/// Which uses [TasksDatasource] for work with the data.
class TasksDataRepository extends TasksRepository {
  TasksDataRepository(this._tasksDataSource);

  final TasksDatasource _tasksDataSource;
  final log = getLogger();

  @override
  Future<List<Task>> getAllTasks() async {
    return _tasksDataSource.getAll().then((task) => task.map((entity) => entity.toDomainModel()).toList());
  }

  @override
  Future delete(int id) {
    return _tasksDataSource.delete(id);
  }

  @override
  Future<int> saveTask(Task task) {
    return _tasksDataSource.saveTask(TaskEntity.fromDomainModel(task));
  }

  @override
  Future saveTasks(List<Task> tasks) async {
    final entities = tasks.map((task) => TaskEntity.fromDomainModel(task)).toList();
    await _tasksDataSource.saveTasks(entities);
  }
}
