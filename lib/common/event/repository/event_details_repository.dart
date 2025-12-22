import 'package:dio/dio.dart';
import 'package:swoony/common/event/model/event_details_model.dart';
import 'package:swoony/core/config/api/api_end_point.dart';
import 'package:swoony/core/config/dependency/dependency_injection.dart';
import 'package:swoony/core/config/network/dio_service.dart';
import 'package:swoony/core/config/network/request_input.dart';
import 'package:swoony/core/config/network/response_state.dart';

class EventDetailsRepository {
  final DioService _dioService = getIt();
  Future<ResponseState<EventDetailsModel?>> getDetails({required String id}) async {
    return _dioService.request<EventDetailsModel>(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.eventDetails(id: id),
        method: RequestMethod.GET,
      ),   
      responseBuilder: (data) => data != null ? EventDetailsModel.fromJson(data) : null,
    );
  }
}
