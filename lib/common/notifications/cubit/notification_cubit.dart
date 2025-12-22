import 'dart:async';

import 'package:swoony/common/notifications/repository/notification_repository.dart';
import 'package:swoony/core/config/bloc/safe_cubit.dart';
import 'package:swoony/core/config/dependency/dependency_injection.dart';
import 'package:swoony/core/config/socket/notification_model.dart';
import 'package:swoony/core/config/socket/socket_service.dart';
import 'package:swoony/core/config/socket/stream_data_model.dart';

import 'notification_state.dart';

class NotificationCubit extends SafeCubit<NotificationState> {
  NotificationCubit() : super(const NotificationState());
  final NotificationRepository _repository = getIt();
  late StreamSubscription<StreamDataModel> _subscriptions;

  Future<void> init() async {
    _subscriptions = SocketService.instance.streamController.stream.listen((data) {
      if (data.streamType == StreamType.notification) {
        addNotification(notification: data.data as NotificationModel);
      }
    });
    fetch();
  }

  int? _getPageNo(List responce) => responce.isNotEmpty ? state.pageNo + 1 : null;

  void cleanList() async {
    emit(state.copyWith(notifications: []));
  }

  void addNotification({required NotificationModel notification}) {
    final List<NotificationModel> updatedList = [notification, ...state.notifications ?? []];
    emit(state.copyWith(notifications: updatedList));
  }

  Future<void> fetch() async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, notifications: [], pageNo: 1));
    final responce = await _repository.fetch(page: state.pageNo);
    emit(
      state.copyWith(
        notifications: responce.data,
        isLoading: false,
        pageNo: _getPageNo(responce.data ?? []),
      ),
    );
  }

  Future<void> loadMore() async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true));
    final responce = await _repository.fetch(page: state.pageNo);
    emit(
      state.copyWith(
        isLoading: false,
        notifications: [...state.notifications ?? [], ...responce.data ?? []],
        pageNo: _getPageNo(responce.data ?? []),
      ),
    );
  }

  @override
  Future<void> close() {
    _subscriptions.cancel();
    return super.close();
  }
}
