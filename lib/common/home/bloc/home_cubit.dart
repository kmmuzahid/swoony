import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:swoony/common/auth/model/user_login_info_model.dart';
import 'package:swoony/common/notifications/firebase/firebase_notification_handler.dart';
import 'package:swoony/core/config/bloc/safe_cubit.dart';
import 'package:swoony/core/config/dependency/dependency_injection.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/config/socket/notification_model.dart';
import 'package:swoony/core/config/socket/socket_message_model.dart';
import 'package:swoony/core/config/socket/socket_service.dart';
import 'package:swoony/core/config/socket/stream_data_model.dart';
import 'package:swoony/core/utils/app_utils.dart';

import '../repository/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends SafeCubit<HomeState> {
  HomeCubit() : super(const HomeState(currentIndex: 0));
  final HomeRepository homeRepository = getIt();
  late StreamSubscription<StreamDataModel> _subscriptions;

  void changeIndex(int index) => emit(state.copyWith(currentIndex: index));
  void resetNotificationCount() => emit(state.copyWith(unreadNotification: 0));
  void resetMessageCount() => emit(state.copyWith(unreadMessage: 0));

  void init() async {
    fetchCount();
    _subscriptions = SocketService.instance.streamController.stream.listen((data) {
      if (data.streamType == StreamType.notification) {
        if (appRouter.current.name != 'NotificationRoute') {
          final notifiaction = data.data as NotificationModel;
          emit(state.copyWith(unreadNotification: state.unreadNotification + 1));
          FirebaseNotificationHandler.instance.showLocalNotification(
            RemoteNotification(title: notifiaction.title, body: notifiaction.message),
          );
        }
      } else if (data.streamType == StreamType.message) {
        final bool isChatOpen = Utils.getRole() == Role.ORGANIZER
            ? state.currentIndex == 3
            : state.currentIndex == 4;
        if (!isChatOpen) {
          final message = data.data as SocketMessageModel;
          emit(state.copyWith(unreadMessage: state.unreadMessage + 1));
          FirebaseNotificationHandler.instance.showLocalNotification(
            RemoteNotification(title: message.sender.name, body: message.text),
          );
        }
      }
    });
  }

  Future<void> fetchCount() async {
    final result = await homeRepository.getUnreadCount();
    if (result.isSuccess) {
      emit(
        state.copyWith(
          unreadNotification: result.data?.notification,
          unreadMessage: result.data?.message,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _subscriptions.cancel();
    return super.close();
  }
}
