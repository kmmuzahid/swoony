import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:swoony/common/auth/cubit/auth_cubit.dart';
import 'package:swoony/common/setting/cubit/event_notification_state.dart';
import 'package:swoony/core/config/api/api_end_point.dart';
import 'package:swoony/core/config/bloc/safe_cubit.dart';
import 'package:swoony/core/config/dependency/dependency_injection.dart';
import 'package:swoony/core/config/network/dio_service.dart';
import 'package:swoony/core/config/network/request_input.dart';
import 'package:swoony/core/config/route/app_router.dart';

class EventNotificationCubit extends SafeCubit<EventNotificationState> {
  EventNotificationCubit()
    : super(EventNotificationState(isFetching: false, notification: '', isSending: false));

  final DioService _dioService = getIt();

  Future<void> init({required String id}) async {
    if (state.isFetching) return;
    emit(state.copyWith(isSending: true));
    final result = await _dioService.request<dynamic>(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.eventDetails(id: id),
        method: RequestMethod.GET,
      ),
      responseBuilder: (data) => data,
    );

    emit(state.copyWith(isSending: false, notification: result.data['notification'] ?? ''));
  }

  Future<void> updateWelcomeNotificaion({required String id, required String notification}) async {
    if (state.isSending) return;
    emit(state.copyWith(isSending: true));
    final result = await _dioService.request<dynamic>(
      showMessage: true,
      input: RequestInput(
        endpoint: ApiEndPoint.instance.updateEvent(id),
        method: RequestMethod.PATCH,
        formFields: {
          'data': jsonEncode({'notification': notification}),
        },
      ),
      responseBuilder: (data) => data,
    );

    emit(state.copyWith(isSending: true));

    if (result.isSuccess) {
      appRouter.pop();
    }
  }

  Future<void> onMessageChange({required String notification}) async {
    emit(state.copyWith(notification: notification));
  }
}
