// File: home_repository.dart

import 'package:swoony/core/config/api/api_end_point.dart';
import 'package:swoony/core/config/dependency/dependency_injection.dart';
import 'package:swoony/core/config/network/dio_service.dart';
import 'package:swoony/core/config/network/request_input.dart';
import 'package:swoony/core/config/network/response_state.dart';

class UnreadCount {
  UnreadCount(this.notification, this.message);
  final int notification;
  final int message;
}

class HomeRepository {
  final DioService _dioService = getIt();
  Future<ResponseState<UnreadCount?>> getUnreadCount() async {
    return _dioService.request(
      input: RequestInput(endpoint: ApiEndPoint.instance.unreadCount, method: RequestMethod.GET),
      responseBuilder: (data) => UnreadCount(data['notificationCount'], data['messageCount']),
    );

  }
}
