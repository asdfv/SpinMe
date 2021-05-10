import 'package:domain/domain_module.dart';

class DefaultTasksRepository extends TasksRepository {
  final List<String> _tasks = List.generate(30, (index) => 'Task number $index');

  @override
  List<String> getAllTasks() {
    return _tasks;
  }
}
