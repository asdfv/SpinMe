import 'package:domain/domain_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/prepare_event.dart';
import 'package:spinme/by/grodno/vasili/spinme/presentation/features/prepare/prepare_state.dart';

class PrepareBloc extends Bloc<PrepareEvent, PrepareState> {
  final PrepareCoordinator coordinator;

  PrepareBloc(PrepareState initialState, this.coordinator) : super(initialState);

  @override
  Stream<PrepareState> mapEventToState(PrepareEvent event) async* {
    if (event is LoadTasks) {
      yield TasksLoadingState();
      try {
        final tasks = await coordinator.getAllTasks();
        yield TasksLoadedState(tasks);
      } catch (error) {
        yield TaskLoadErrorState(error.toString());
      }
    }
  }
}
