// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart'; 
import 'package:swoony/core/config/socket/notification_model.dart';


class NotificationState extends Equatable {
  const NotificationState({this.notifications, this.pageNo = 1, this.isLoading = false});

  final List<NotificationModel>? notifications;
  final int pageNo;
  final bool isLoading;

  NotificationState copyWith({
    List<NotificationModel>? notifications,
    int? pageNo,
    bool? isLoading,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      pageNo: pageNo ?? this.pageNo,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [notifications ?? '', pageNo, isLoading];
}
