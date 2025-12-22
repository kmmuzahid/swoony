// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum UserStatus { online, offline }

class ChatListItemModel {
  String chatId;
  String userImage;
  String userName;
  //enum
  UserStatus userStatus;
  DateTime lastSendMessageTime;
  String lastMessage;
  bool isRead;
  ChatListItemModel({
    required this.chatId,
    required this.userImage,
    required this.userName,
    required this.userStatus,
    required this.lastSendMessageTime,
    required this.lastMessage,
    required this.isRead,
  });

  ChatListItemModel copyWith({
    String? messageId,
    String? userImage,
    String? userName,
    UserStatus? userStatus,
    DateTime? lastSendMessageTime,
    String? lastMessage,
    bool? isRead,
  }) {
    return ChatListItemModel(
      chatId: messageId ?? this.chatId,
      userImage: userImage ?? this.userImage,
      userName: userName ?? this.userName,
      userStatus: userStatus ?? this.userStatus,
      lastSendMessageTime: lastSendMessageTime ?? this.lastSendMessageTime,
      lastMessage: lastMessage ?? this.lastMessage,
      isRead: isRead ?? this.isRead,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messageId': chatId,
      'userImage': userImage,
      'userName': userName,
      'userStatus': userStatus.index,
      'lastSendMessageTime': lastSendMessageTime.millisecondsSinceEpoch,
      'lastMessage': lastMessage,
      'isRead': isRead,
    };
  }

  factory ChatListItemModel.fromMap(Map<String, dynamic> map) {
    return ChatListItemModel(
      chatId: map['messageId'] ?? '',
      userImage: map['userImage'] ?? '',
      userName: map['userName'] as String,
      userStatus: UserStatus.values[map['userStatus'] as int],
      lastSendMessageTime: DateTime.fromMillisecondsSinceEpoch(map['lastSendMessageTime'] as int),
      lastMessage: map['lastMessage'] ?? '',
      isRead: map['isRead'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatListItemModel.fromJson(String source) =>
      ChatListItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatListItemModel(messageId: $chatId, userImage: $userImage, userName: $userName, userStatus: $userStatus, lastSendMessageTime: $lastSendMessageTime, lastMessage: $lastMessage, isRead: $isRead)';
  }

  @override
  bool operator ==(covariant ChatListItemModel other) {
    if (identical(this, other)) return true;

    return other.chatId == chatId &&
        other.userImage == userImage &&
        other.userName == userName &&
        other.userStatus == userStatus &&
        other.lastSendMessageTime == lastSendMessageTime &&
        other.lastMessage == lastMessage &&
        other.isRead == isRead;
  }

  @override
  int get hashCode {
    return chatId.hashCode ^
        userImage.hashCode ^
        userName.hashCode ^
        userStatus.hashCode ^
        lastSendMessageTime.hashCode ^
        lastMessage.hashCode ^
        isRead.hashCode;
  }
}
