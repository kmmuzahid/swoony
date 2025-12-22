import 'dart:async';

import 'package:swoony/common/chat/model/chat_list_item_model.dart';
import 'package:swoony/common/chat/repository/chat_repository.dart';

import 'package:swoony/core/config/bloc/safe_cubit.dart';
import 'package:swoony/core/config/dependency/dependency_injection.dart';
import 'package:swoony/core/config/socket/socket_message_model.dart';
import 'package:swoony/core/config/socket/socket_service.dart';
import 'package:swoony/core/config/socket/stream_data_model.dart';
import 'package:swoony/core/utils/helpers/debouncer.dart';

import 'chat_list_state.dart';

class ChatListCubit extends SafeCubit<ChatListState> {
  ChatListCubit() : super(const ChatListState());
  final ChatRepository _repository = getIt();
  late StreamSubscription<StreamDataModel> _subscription;
  final Debouncer _debouncer = Debouncer(delay: const Duration(milliseconds: 300));

  int? _getPageNo(List responce) => responce.isNotEmpty ? state.pageNo + 1 : null;

  Future<void> init() async {
    await fetch();
    _streamInitialize();
  }

  Future<void> search(String keyword) async {
    _debouncer.call(() async {
      if (state.isLoading) return;
      emit(state.copyWith(isLoading: true, chatListItems: [], pageNo: 1));
      final responce = await _repository.searchChatList(page: 1, keywords: keyword);
      emit(
        state.copyWith(
          chatListItems: responce.data,
          isLoading: false,
          pageNo: _getPageNo(responce.data ?? []),
        ),
      );
    });
  }

  Future<void> fetch() async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, chatListItems: [], pageNo: 1));
    final responce = await _repository.fetchChatList(page: 1);
    emit(
      state.copyWith(
        chatListItems: responce.data,
        isLoading: false,
        pageNo: _getPageNo(responce.data ?? []),
      ),
    );
  }

  Future<void> loadMore() async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true));
    final response = await _repository.fetchChatList(page: state.pageNo);

    final newItems = response.data ?? [];

    final uniqueItems = newItems.where((newItem) {
      return !state.chatListItems.any((oldItem) => oldItem.chatId == newItem.chatId);
    }).toList();

    emit(
      state.copyWith(
        isLoading: false,
        chatListItems: [...state.chatListItems, ...uniqueItems],
        pageNo: _getPageNo(response.data ?? []),
      ),
    );
  }

  void _streamInitialize() {
    _subscription = SocketService.instance.streamController.stream.listen((event) {
      if (event.streamType == StreamType.message) {
        final message = event.data as SocketMessageModel;
        final index = state.chatListItems.indexWhere((e) => e.chatId == message.chatId);
        if (index > -1) {
          final List<ChatListItemModel> list = List.from(state.chatListItems);
          list.removeAt(index);
          final chatListItem = ChatListItemModel(
            chatId: message.chatId,
            userImage: message.sender.image,
            userStatus: UserStatus.online,
            lastSendMessageTime: DateTime.now(),
            userName: message.sender.name,
            lastMessage: message.text,
            isRead: message.read,
          );
          list.insert(0, chatListItem);
          emit(state.copyWith(chatListItems: list));
        }
      }
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
