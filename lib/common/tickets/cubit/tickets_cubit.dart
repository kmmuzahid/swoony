import 'package:swoony/common/auth/model/user_login_info_model.dart';
import 'package:swoony/common/tickets/cubit/tickets_state.dart';
import 'package:swoony/common/tickets/model/ticket_model.dart';
import 'package:swoony/common/tickets/repository/ticket_repository.dart';
import 'package:swoony/core/config/bloc/safe_cubit.dart';
import 'package:swoony/core/config/dependency/dependency_injection.dart';
import 'package:swoony/core/utils/app_utils.dart';

class TicketsCubit extends SafeCubit<TicketsState> {
  TicketsCubit() : super(const TicketsState());

  final TicketRepository _repository = getIt();

  void initalize(TicketFilter filter) {
    emit(TicketsState(selectedFilter: filter));
    fetch(isRefresh: true);
  }

  void fetch({bool isRefresh = false}) async {
    if (state.selectedFilter == null || state.isLoading) return;
    emit(state.copyWith(isLoading: true, page: isRefresh ? 1 : state.page));
    final role = Utils.getRole();
    if (role == Role.ORGANIZER) {
      final result = await _repository.getOranizerEvents(
        filter: state.selectedFilter!,
        page: state.page,
      );

      emit(
        state.copyWith(
          isLoading: false,
          page: state.page + 1,
          tickets: isRefresh ? result.data : [...state.tickets, ...result.data ?? []],
        ),
      );
      return;
    } else {
      final result = await _repository.getUserEventsOnTicket(
        filter: state.selectedFilter!,
        page: state.page,
      );
      emit(
        state.copyWith(
          isLoading: false,
          page: state.page + 1,
          tickets: isRefresh ? result.data : [...state.tickets, ...result.data ?? []],
        ),
      );
    }
  }

  void filter(TicketFilter filter) {
    if (filter != state.selectedFilter)
      emit(state.copyWith(selectedFilter: filter, page: 1, tickets: []));
    fetch(isRefresh: true);
  }
}
