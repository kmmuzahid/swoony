// ignore_for_file:  sort_constructors_first
import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructo

enum NotificationType { NOTIFICATION, EVENT }

class NotificationModel {
  final String? id;
  final String? message;
  final String? receiver;
  final String? eventTitle;
  final String? eventId;
  final bool read;
  //enum
  final NotificationType? type;
  final String? title;
  final DateTime? createdAt;
  NotificationModel({
    this.id,
    this.message,
    this.receiver,
    this.eventTitle,
    this.eventId,
    this.read = false,
    this.type,
    this.title,
    this.createdAt,
  });

  NotificationModel copyWith({
    String? id,
    String? message,
    String? receiver,
    String? eventTitle,
    String? eventId,
    bool? read,
    NotificationType? type,
    String? title,
    DateTime? createdAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      message: message ?? this.message,
      receiver: receiver ?? this.receiver,
      eventTitle: eventTitle ?? this.eventTitle,
      eventId: eventId ?? this.eventId,
      read: read ?? this.read,
      type: type ?? this.type,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'message': message,
      'receiver': receiver,
      'eventTitle': eventTitle,
      'eventId': eventId,
      'read': read,
      'type': type?.index,
      'title': title,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      receiver: map['receiver'] != null ? map['receiver'] as String : null,
      eventTitle: map['eventTitle'] != null ? map['eventTitle'] as String : null,
      eventId: map['eventId'] != null ? map['eventId'] as String : null,
      read: map['read'] as bool,
      type: map['type'] != null ? NotificationType.values.byName(map['type']) : null,
      title: map['title'] != null ? map['title'] as String : null,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationModel(id: $id, message: $message, receiver: $receiver, eventTitle: $eventTitle, eventId: $eventId, read: $read, type: $type, title: $title, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.message == message &&
        other.receiver == receiver &&
        other.eventTitle == eventTitle &&
        other.eventId == eventId &&
        other.read == read &&
        other.type == type &&
        other.title == title &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        message.hashCode ^
        receiver.hashCode ^
        eventTitle.hashCode ^
        eventId.hashCode ^
        read.hashCode ^
        type.hashCode ^
        title.hashCode ^
        createdAt.hashCode;
  }
}
