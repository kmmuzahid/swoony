import 'package:flutter/scheduler.dart';
import 'package:swoony/common/auth/model/user_login_info_model.dart';
import 'package:swoony/common/event/cubit/all_event_state.dart';
import 'package:swoony/common/tickets/model/ticket_model.dart';
import 'package:swoony/common/tickets/repository/ticket_repository.dart';
import 'package:swoony/core/config/api/api_end_point.dart';
import 'package:swoony/core/config/bloc/safe_cubit.dart';
import 'package:swoony/core/config/dependency/dependency_injection.dart';
import 'package:swoony/core/config/network/dio_service.dart';
import 'package:swoony/core/config/network/request_input.dart';
import 'package:swoony/core/config/network/response_state.dart';
import 'package:swoony/core/utils/app_utils.dart';

class AllEventCubit extends SafeCubit<AllEventState> {
  AllEventCubit() : super(const AllEventState());
  final TicketRepository _repository = getIt();
  final DioService _dioService = getIt();

  void fetch({bool isRefresh = false, TicketFilter ticketFilter = TicketFilter.Live}) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, page: isRefresh ? 1 : state.page));
    final result = Utils.getRole() == Role.ORGANIZER
        ? await _repository.getOranizerEvents(filter: ticketFilter, page: state.page)
        : await _userHome(ticketFilter);
    emit(
      state.copyWith(
        isLoading: false,
        page: state.page + 1,
        events: isRefresh ? result.data : [...state.events, ...result.data ?? []],
      ),
    );
    return;
  }

  Future<ResponseState<List<TicketModel>?>> _userHome(TicketFilter filterName) async {
    final result = await _dioService.request<List<TicketModel>>(
      input: RequestInput(
        endpoint: filterName == TicketFilter.newlyAdded
            ? ApiEndPoint.instance.userNewlyAdded
            : ApiEndPoint.instance.userPopularEvent,
        method: RequestMethod.GET,
        queryParams: {'page': state.page, 'limit': 20},
      ),
      responseBuilder: (data) =>
          (data as List<dynamic>).map((e) => TicketModel.fromJson(e)).toList(),
    );
    return result;
  }
}
