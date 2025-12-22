// ignore_for_file: public_member_api_docs, sort_constructors_first
// File: chat_model.dart

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:swoony/common/chat/model/chat_user_info.dart';

enum ChatType { message, callSuccess, callFailed }

class ChatModel {
  String messageId;
  //enum
  ChatType chatType;
  String content;
  ChatUserInfo userInfo;
  DateTime createdAt;
  DateTime updatedAt;
  List<String>? files;
  final bool isSending;
  final bool isSendingFaild;
  final bool isEdit;
  ChatModel({
    required this.messageId,
    required this.chatType,
    required this.content,
    required this.userInfo,
    required this.createdAt,
    required this.updatedAt,
    this.isSending = false,
    this.isSendingFaild = false,
    this.files,
    this.isEdit = false,
  });

  ChatModel copyWith({
    String? messageId,
    ChatType? chatType,
    String? content,
    ChatUserInfo? userInfo,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? files,
    bool? isSending,
    bool? isSendingFaild,
    bool? isEdit,
  }) {
    return ChatModel(
      messageId: messageId ?? this.messageId,
      chatType: chatType ?? this.chatType,
      content: content ?? this.content,
      userInfo: userInfo ?? this.userInfo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      files: files ?? this.files,
      isSending: isSending ?? this.isSending,
      isSendingFaild: isSendingFaild ?? this.isSendingFaild,
      isEdit: isEdit ?? this.isEdit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatId': messageId,
      'chatType': chatType.index,
      'content': content,
      'userInfo': userInfo.toMap(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'files': files,
      'isEdit': isEdit,
      'isSending': isSending,
      'isSendingFaild': isSendingFaild,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      messageId: map['chatId'] as String,
      chatType: ChatType.values[map['chatType'] as int],
      content: map['content'] as String,
      userInfo: ChatUserInfo.fromMap(map['userInfo'] as Map<String, dynamic>),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      files: map['files'] != null ? List<String>.from((map['files'] as List<String>)) : null,
      isEdit: map['isEdit'] as bool,
      isSending: map['isSending'] as bool,
      isSendingFaild: map['isSendingFaild'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatModel( chatId: $messageId, chatType: $chatType, content: $content, userInfo: $userInfo, createdAt: $createdAt, files: $files, isEdit: $isEdit, isSending: $isSending, isSendingFaild: $isSendingFaild)';
  }

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;

    return other.messageId == messageId &&
        other.chatType == chatType &&
        other.content == content &&
        other.userInfo == userInfo &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.isSending == isSending &&
        other.isSendingFaild == isSendingFaild &&
        listEquals(other.files, files) &&
        other.isEdit == isEdit;
  }

  @override
  int get hashCode {
    return messageId.hashCode ^
        chatType.hashCode ^
        content.hashCode ^
        updatedAt.hashCode ^
        userInfo.hashCode ^
        createdAt.hashCode ^
        isSending.hashCode ^
        isSendingFaild.hashCode ^
        files.hashCode ^
        isEdit.hashCode;
  }
}
