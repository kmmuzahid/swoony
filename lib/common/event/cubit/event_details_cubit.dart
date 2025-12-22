import 'package:swoony/common/event/cubit/event_details_state.dart';
import 'package:swoony/common/event/repository/event_details_repository.dart';
import 'package:swoony/core/config/bloc/safe_cubit.dart';
import 'package:swoony/core/config/dependency/dependency_injection.dart';
import 'package:swoony/core/utils/app_utils.dart';

class EventDetailsCubit extends SafeCubit<EventDetailsState> {
  EventDetailsCubit() : super(const EventDetailsState());
  final EventDetailsRepository repository = getIt();

  void showDetails(bool show) {
    emit(state.copyWith(showDetails: show));
  }

  void fetch({required String eventId}) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true));
    final result = await repository.getDetails(id: eventId);
    if (result.isSuccess) {
      emit(state.copyWith(eventDetails: result.data, isLoading: false));
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }
}
