// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

enum NotificationType { ready, delivered, onTheWay, verification, others }

// class NotificationModel {
//   final String id;
//   final String title;
//   final String subtitle;
//   //enum
//   final NotificationType type;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final String body;
//   NotificationModel({
//     required this.id,
//     required this.title,
//     required this.subtitle,
//     required this.type,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.body,
//   });

//   NotificationModel copyWith({
//     String? id,
//     String? title,
//     String? subtitle,
//     NotificationType? type,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//     String? body,
//   }) {
//     return NotificationModel(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       subtitle: subtitle ?? this.subtitle,
//       type: type ?? this.type,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//       body: body ?? this.body,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'title': title,
//       'subtitle': subtitle,
//       'type': type.index,
//       'createdAt': createdAt.millisecondsSinceEpoch,
//       'updatedAt': updatedAt.millisecondsSinceEpoch,
//       'body': body,
//     };
//   }

//   factory NotificationModel.fromMap(Map<String, dynamic> map) {
//     return NotificationModel(
//       id: map['id'] as String,
//       title: map['title'] as String,
//       subtitle: map['subtitle'] as String,
//       type: NotificationType.values[map['type'] as int],
//       createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
//       updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
//       body: map['body'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory NotificationModel.fromJson(String source) =>
//       NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'NotificationModel(id: $id, title: $title, subtitle: $subtitle, type: $type, createdAt: $createdAt, updatedAt: $updatedAt, body: $body)';
//   }

//   @override
//   bool operator ==(covariant NotificationModel other) {
//     if (identical(this, other)) return true;
  
//     return other.id == id &&
//         other.title == title &&
//         other.subtitle == subtitle &&
//         other.type == type &&
//         other.createdAt == createdAt &&
//         other.updatedAt == updatedAt &&
//         other.body == body;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//         title.hashCode ^
//         subtitle.hashCode ^
//         type.hashCode ^
//         createdAt.hashCode ^
//         updatedAt.hashCode ^
//         body.hashCode;
//   }
// }
