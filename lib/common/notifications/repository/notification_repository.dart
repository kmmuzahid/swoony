 
import 'package:swoony/core/config/api/api_end_point.dart';
import 'package:swoony/core/config/dependency/dependency_injection.dart';
import 'package:swoony/core/config/network/dio_service.dart';
import 'package:swoony/core/config/network/request_input.dart';
import 'package:swoony/core/config/network/response_state.dart';
import 'package:swoony/core/config/socket/notification_model.dart';
 

class NotificationRepository {
  final DioService _dioService = getIt();
  Future<ResponseState<List<NotificationModel>?>> fetch({required int page}) async {
    return _dioService.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.notification,
        method: RequestMethod.GET,
        queryParams: {'page': page, 'limit': 20}
      ),
      responseBuilder: (data) =>
          data == null ? [] : (data as List).map((e) => NotificationModel.fromMap(e)).toList(),
    ); 
  }
}
