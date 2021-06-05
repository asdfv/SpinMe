import 'package:data/src/by/grodno/vasili/spinme/data/datasources/tasks/tasks_datasource.dart';
import 'package:data/src/by/grodno/vasili/spinme/data/models/task_entity.dart';
import 'package:domain/domain_module.dart';

class TasksDataRepository extends TasksRepository {
  TasksDataRepository(this._inMemoryDataSource);

  final TasksDatasource _inMemoryDataSource;
  final log = getLogger();

  @override
  Future<List<Task>> getAllTasks() async {
    return _inMemoryDataSource.getAll().then((task) => task.map((entity) => entity.toDomainModel()).toList());
  }

  @override
  Future delete(int id) {
    return _inMemoryDataSource.delete(id);
  }

  @override
  Future<int> saveTask(Task task) {
    return _inMemoryDataSource.saveTask(TaskEntity.fromDomainModel(task));
  }

  @override
  void saveTasks(List<Task> tasks) {
    final entities = tasks.map((task) => TaskEntity.fromDomainModel(task)).toList();
    _inMemoryDataSource.saveTasks(entities);
  }
}
