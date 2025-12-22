import 'package:swoony/core/utils/app_utils.dart';

class SocketMessageModel {
  SocketMessageModel({
    required this.id,
    required this.chatId,
    required this.replyTo,
    required this.replies,
    required this.read,
    required this.sender,
    required this.text,
    required this.image,
    required this.isDeleted,
    this.ownerId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory SocketMessageModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return SocketMessageModel(
        id: '',
        chatId: '',
        replyTo: ReplyToModel.empty(),
        replies: const [],
        read: false,
        sender: SenderModel.empty(),
        text: '',
        image: const [],
        isDeleted: false,
      );
    }

    return SocketMessageModel(
      id: json['_id'] ?? '',
      chatId: json['chatId'] ?? '',
      replyTo: ReplyToModel.fromJson(json['replyTo']),
      replies: List<String>.from(json['replies'] ?? []),
      read: json['read'] ?? false,
      sender: SenderModel.fromJson(json['sender']),
      text: json['text'] ?? '',
      image: List<String>.from(json['image'] ?? []),
      isDeleted: json['isDeleted'] ?? false,
      deletedAt: Utils.parseDate(json['deletedAt']),
      createdAt: Utils.parseDate(json['createdAt']),
      updatedAt: Utils.parseDate(json['updatedAt']),
      ownerId: json['ownerId'] ?? '',

    );
  }
  final String id;
  final String chatId;
  final ReplyToModel replyTo;
  final List<String> replies;
  final bool read;
  final SenderModel sender;
  final String text;
  final List<String> image;
  final bool isDeleted;
  final DateTime? deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? ownerId;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'chatId': chatId,
      'replyTo': replyTo.toJson(),
      'replies': replies,
      'read': read,
      'sender': sender.toJson(),
      'text': text,
      'image': image,
      'isDeleted': isDeleted,
      'deletedAt': deletedAt?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'ownerId': ownerId
    };
  }
}

class ReplyToModel {
  ReplyToModel({required this.id, required this.sender, required this.text});

  factory ReplyToModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ReplyToModel.empty();
    return ReplyToModel(
      id: json['_id'] ?? '',
      sender: json['sender'] ?? '',
      text: json['text'] ?? '',
    );
  }

  factory ReplyToModel.empty() => ReplyToModel(id: '', sender: '', text: '');
  final String id;
  final String sender;
  final String text;

  Map<String, dynamic> toJson() {
    return {'_id': id, 'sender': sender, 'text': text};
  }
}

class SenderModel {
  SenderModel({required this.id, required this.name, required this.image});

  factory SenderModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return SenderModel.empty();
    return SenderModel(id: json['_id'] ?? '', name: json['name'] ?? '', image: json['image'] ?? '');
  }

  factory SenderModel.empty() => SenderModel(id: '', name: '', image: '');
  final String id;
  final String name;
  final String image;

  Map<String, dynamic> toJson() {
    return {'_id': id, 'name': name, 'image': image};
  }
}
