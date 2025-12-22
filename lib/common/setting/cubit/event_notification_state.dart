// ignore_for_file: public_member_api_docs, sort_constructors_first
class EventNotificationState {
  EventNotificationState({
    required this.isFetching,
    required this.isSending,
    required this.notification,
  });

  final bool isFetching;
  final bool isSending;

  final String notification;

  EventNotificationState copyWith({bool? isFetching, bool? isSending, String? notification}) {
    return EventNotificationState(
      isFetching: isFetching ?? this.isFetching,
      isSending: isSending ?? this.isSending,
      notification: notification ?? this.notification,
    );
  }

  @override
  bool operator ==(covariant EventNotificationState other) {
    if (identical(this, other)) return true;

    return other.isFetching == isFetching &&
        other.isSending == isSending &&
        other.notification == notification;
  }

  @override
  int get hashCode => isFetching.hashCode ^ isSending.hashCode ^ notification.hashCode;
}
