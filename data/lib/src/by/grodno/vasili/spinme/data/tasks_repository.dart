import 'package:domain/domain_module.dart';

class FakeTasksRepository extends TasksRepository {
  final List<String> _tasks = List.generate(30, (index) => 'Task number $index');

  @override
  Future<List<String>> getAllTasks() async {
    return Future.delayed(const Duration(seconds: 1), () => _tasks);
  }
}
