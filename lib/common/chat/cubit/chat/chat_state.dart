import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swoony/common/chat/model/chat_model.dart';

class ChatState {
  const ChatState({
    this.chats = const [],
    this.filePath = const [],
    this.pageNo = 0,
    this.isLoading = false,
    this.message = '',
    this.unread = 0,
    this.editIndex = -1,
  });

  final List<ChatModel> chats;
  final int pageNo;
  final bool isLoading;
  final int unread;
  final List<XFile> filePath;
  final String message;
  final int editIndex;

  ChatState copyWith({
    List<ChatModel>? chats,
    List<XFile>? filePath,
    int? pageNo,
    bool? isLoading,
    String? message,
    int? unread,
    int? editIndex,
  }) {
    return ChatState(
      chats: chats ?? this.chats,
      pageNo: pageNo ?? this.pageNo,
      isLoading: isLoading ?? this.isLoading,
      unread: unread ?? this.unread,
      filePath: filePath ?? this.filePath,
      message: message ?? this.message,
      editIndex: editIndex ?? this.editIndex,
    );
  }

  // equity
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatState &&
        other.chats == chats &&
        other.pageNo == pageNo &&
        other.isLoading == isLoading &&
        other.unread == unread &&
        other.filePath == filePath &&
        other.message == message &&
        other.editIndex == editIndex;
  }

  @override
  int get hashCode {
    return chats.hashCode ^
        pageNo.hashCode ^
        isLoading.hashCode ^
        unread.hashCode ^
        filePath.hashCode ^
        message.hashCode ^
        editIndex.hashCode;
  }
}
