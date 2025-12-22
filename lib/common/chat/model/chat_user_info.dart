// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatUserInfo {
  String userId;
  String name;
  String image;
  ChatUserInfo({required this.userId, required this.name, required this.image});

  ChatUserInfo copyWith({String? userId, String? name, String? image}) {
    return ChatUserInfo(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'userId': userId, 'name': name, 'image': image};
  }

  factory ChatUserInfo.fromMap(Map<String, dynamic> map) {
    return ChatUserInfo(
      userId: map['userId'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatUserInfo.fromJson(String source) =>
      ChatUserInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ChatUserInfo(userId: $userId, name: $name, image: $image)';

  @override
  bool operator ==(covariant ChatUserInfo other) {
    if (identical(this, other)) return true;

    return other.userId == userId && other.name == name && other.image == image;
  }

  @override
  int get hashCode => userId.hashCode ^ name.hashCode ^ image.hashCode;
}
