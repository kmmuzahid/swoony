import 'package:swoony/core/utils/log/app_log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    AppLogger.debug('Created → ${bloc.runtimeType}', tag: 'BLOC');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    AppLogger.info('Event → ${event.runtimeType}', tag: bloc.runtimeType.toString());
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    AppLogger.debug('''
                Transition:
                  ➤ Event     : ${transition.event}
                  ➤ From State: ${transition.currentState}
                  ➤ To State  : ${transition.nextState}
                ''', tag: bloc.runtimeType.toString());
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    AppLogger.error(
      'Error → $error\n${stackTrace.toString().split('\n').take(3).join('\n')}',
      tag: bloc.runtimeType.toString(),
    );
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    AppLogger.warning('Closed → ${bloc.runtimeType}', tag: 'BLOC');
  }
}
