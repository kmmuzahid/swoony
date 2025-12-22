import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swoony/core/utils/log/app_log.dart';

class SafeCubit<State> extends Cubit<State> {
  SafeCubit(super.initialState);

  @override
  void emit(State state) {
    if (!isClosed) {
      super.emit(state);
    } else {
      AppLogger.warning('Cubit is closed, cannot emit state.', tag: 'Safe Cubit');
    }
  }

}
