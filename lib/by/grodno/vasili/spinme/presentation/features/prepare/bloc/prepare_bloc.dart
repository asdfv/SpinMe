import 'package:domain/domain_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/bloc/prepare_event.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/bloc/prepare_state.dart';

/// [Bloc] for reducing events from prepare flow screens - chose players and tasks screens.
class PrepareBloc extends Bloc<PrepareEvent, PrepareState> {
  final PrepareCoordinator coordinator;
  final log = getLogger();

  PrepareBloc(PrepareState initialState, this.coordinator) : super(initialState);

  @override
  Stream<PrepareState> mapEventToState(PrepareEvent event) async* {
    if (event is LoadTasks) yield* _mapLoadTasks();
    else if (event is NamesChosen) await _createAndSavePlayers(event);
    else if (event is TasksChosen) await _saveTasks(event);
    else if (event is TaskEdited) yield* _mapTaskEdited(event);
    else if (event is DeleteTask) yield* _mapDeleteTask(event);
    else if (event is LoadPlayers) yield* _mapLoadPlayers();
    else if (event is TaskAdded) yield* _mapTaskAdded(event);
  }

  Stream<PrepareState> _mapLoadTasks() async* {
    yield state.copyWith(isLoading: true);
    final tasks = await coordinator.getAllTasks();
    yield state.copyWith(isLoading: false, tasks: tasks);
  }

  Future _createAndSavePlayers(NamesChosen event) async {
    final List<Player> players = event.names.asMap().entries.map((entry) => Player(entry.key, entry.value)).toList();
    await coordinator.replaceAllPlayers(players);
    log.d(message: "${players.length} players replaced.");
  }

  Future _saveTasks(TasksChosen event) async {
    final tasks = event.tasks;
    await coordinator.saveTasks(tasks);
    log.d(message: "${tasks.length} tasks are saved.");
  }

  Stream<PrepareState> _mapTaskEdited(TaskEdited event) async* {
    final updatedTask = event.newTask;
    await coordinator.saveTask(updatedTask);
    final List<Task> newList = List.from(state.tasks!);
    final index = newList.indexWhere((element) => element.id == updatedTask.id);
    newList[index] = updatedTask;
    yield state.copyWith(tasks: newList);
  }

  Stream<PrepareState> _mapDeleteTask(DeleteTask event) async* {
    final idToRemove = event.id;
    await coordinator.deleteTask(idToRemove);
    final List<Task> newList = List.from(state.tasks!);
    newList.removeWhere((task) {
      log.d(message: "Task $task deleted.");
      return task.id == idToRemove;
    });
    yield state.copyWith(tasks: newList);
  }

  Stream<PrepareState> _mapLoadPlayers() async* {
    yield state.copyWith(isLoading: true);
    final players = await coordinator.getAllPlayers();
    yield state.copyWith(players: players, isLoading: false);
  }

  Stream<PrepareState> _mapTaskAdded(TaskAdded event) async* {
    final task = event.task;
    await coordinator.saveTask(task);
    log.d(message: "Task $task saved.");
    final List<Task> newList = List.from(state.tasks!)..add(task);
    yield state.copyWith(tasks: newList);
  }
}
