import 'package:equatable/equatable.dart';

import '../../model/chat_list_item_model.dart';

class ChatListState extends Equatable {
  const ChatListState({this.chatListItems = const [], this.pageNo = 0, this.isLoading = false, this.unread = 0});

  final List<ChatListItemModel> chatListItems;
  final int pageNo;
  final bool isLoading;
  final int unread;

  ChatListState copyWith({List<ChatListItemModel>? chatListItems, int? pageNo, bool? isLoading, int? unread}) {
    return ChatListState(
      chatListItems: chatListItems ?? this.chatListItems,
      pageNo: pageNo ?? this.pageNo,
      isLoading: isLoading ?? this.isLoading,
      unread: unread ?? this.unread,
    );
  }

  @override
  List<Object> get props => [chatListItems, pageNo, isLoading, unread];
}
