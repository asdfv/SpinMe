import 'package:bloc/bloc.dart';
import 'package:domain/domain_module.dart';

class SimpleBlocObserver extends BlocObserver {
  var log = getLogger();

  @override
  void onEvent(Bloc bloc, Object? event) {
    log.d(message: event.toString());
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    log.d(message: change.toString());
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log.d(message: transition.toString());
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log.d(message: error.toString());
    super.onError(bloc, error, stackTrace);
  }
}
