import 'package:swoony/core/utils/log/app_log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SafeBloc<Event, State> extends Bloc<Event, State> {
  SafeBloc(super.initialState);

  @override
  void emit(State state) {
    if (!isClosed) {
      super.emit(state);
    } else {
      AppLogger.warning('Bloc is closed, cannot emit state.', tag: 'Safe Bloc');
    }
  }
}
