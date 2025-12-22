import 'package:swoony/common/tickets/model/ticket_model.dart';
import 'package:swoony/core/config/api/api_end_point.dart';
import 'package:swoony/core/config/dependency/dependency_injection.dart';
import 'package:swoony/core/config/network/dio_service.dart';
import 'package:swoony/core/config/network/request_input.dart';
import 'package:swoony/core/config/network/response_state.dart';

class TicketRepository {
  final DioService _dioService = getIt();

  Future<ResponseState<List<TicketModel>?>> getOranizerEvents({
    required TicketFilter filter,
    required int page,
  }) async {
    String path = '';
    String eventStatus = '';
    bool isDraft = false;
    path = ApiEndPoint.instance.orgEvent;
    if (filter == TicketFilter.Live) {
      eventStatus = 'Live';
    } else if (filter == TicketFilter.UnderReview) {
      eventStatus = 'UnderReview';
    } else if (filter == TicketFilter.Draft) {
      isDraft = true;
    } else if (filter == TicketFilter.Closed) {
      path = ApiEndPoint.instance.orgEventClosed;
    }

    final result = await _dioService.request<List<TicketModel>>(
      input: RequestInput(
        endpoint: path,
        queryParams: {
          'limit': 20,
          'page': page,
          if (eventStatus.isNotEmpty) 'EventStatus': eventStatus,
          if (isDraft) 'isDraft': isDraft,
        },
        method: RequestMethod.GET,
      ),
      responseBuilder: (data) => (data as List).map((e) => TicketModel.fromJson(e)).toList(),
    );
    return result;
  }

  Future<ResponseState<List<TicketModel>?>> getUserEventsOnTicket({
    required TicketFilter filter,
    required int page,
  }) async {
    String path = '';
    String eventStatus = '';

    path = ApiEndPoint.instance.userLiveEvent;
    if (filter == TicketFilter.Live) {
      eventStatus = 'onsell';
    } else if (filter == TicketFilter.Used) {
      eventStatus = 'used';
    } else if (filter == TicketFilter.Available || filter == TicketFilter.Upcoming) {
      eventStatus = 'available';
    } else if (filter == TicketFilter.Sold) {
      path = ApiEndPoint.instance.userSoldEvent;
    } else if (filter == TicketFilter.Expired) {
      path = ApiEndPoint.instance.userExpiredEvent;
    } else if (filter == TicketFilter.fanClub) {
      path = ApiEndPoint.instance.userFavourite;
    }

    final result = await _dioService.request<List<TicketModel>>(
      input: RequestInput(
        endpoint: path,
        queryParams: {'limit': 20, 'page': page, if (eventStatus.isNotEmpty) 'status': eventStatus},
        method: RequestMethod.GET,
      ),
      responseBuilder: (data) => (data as List).map((e) => TicketModel.fromJson(e)).toList(),
    );
    return result;
  }
}
