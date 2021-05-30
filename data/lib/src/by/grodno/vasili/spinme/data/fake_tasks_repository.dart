import 'package:data/src/by/grodno/vasili/spinme/data/models/task_entity.dart';
import 'package:domain/domain_module.dart';

class FakeTasksRepository extends TasksRepository {
  final log = getLogger();

  final Set<TaskEntity> _tasksDatasource =
      List.generate(5, (index) => TaskEntity(index, 'Task number $index', true)).toSet();

  @override
  Future<List<Task>> getAllTasks() async {
    return Future.delayed(
        const Duration(milliseconds: 200), () => _tasksDatasource.map((entity) => entity.toDomainModel()).toList());
  }

  @override
  Future<Task?> getOne(int id) {
    return Future.delayed(
        const Duration(milliseconds: 200), () => _tasksDatasource.firstWhere((task) => task.id == id).toDomainModel());
  }

  @override
  Future delete(int id) {
    return Future.delayed(const Duration(milliseconds: 200), () => null);
  }

  @override
  Future<int> size() => Future.delayed(const Duration(milliseconds: 200), () => _tasksDatasource.length);

  @override
  Future<int> saveTask(Task task) {
    _tasksDatasource.add(TaskEntity.fromDomainModel(task));
    return Future.delayed(const Duration(milliseconds: 200), () => task.id);
  }

  @override
  void saveTasks(List<Task> tasks) {
    tasks.forEach((task) {
      saveTask(task);
    });
    final chosenTasksIds = tasks.where((task) => task.isChecked).map((task) => task.id);
    log.i(message: "Tasks saved. Chosen tasks ids are: $chosenTasksIds");
  }
}
