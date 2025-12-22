import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swoony/common/chat/model/chat_model.dart';
import 'package:swoony/common/chat/model/chat_user_info.dart';
import 'package:swoony/common/chat/repository/chat_repository.dart';
import 'package:swoony/core/component/other_widgets/permission_handler_helper.dart';
import 'package:swoony/core/config/bloc/safe_cubit.dart';
import 'package:swoony/core/config/dependency/dependency_injection.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/config/socket/socket_message_model.dart';
import 'package:swoony/core/config/socket/socket_service.dart';
import 'package:swoony/core/config/socket/stream_data_model.dart';
import 'package:swoony/core/utils/log/app_log.dart';
import 'package:swoony/main.dart';
import 'package:permission_handler/permission_handler.dart';

import 'chat_state.dart';

class ChatCubit extends SafeCubit<ChatState> {
  ChatCubit(this.chatId) : super(const ChatState());
  final String chatId;

  final ChatRepository _repository = getIt();
  final FilePicker _picker = FilePicker.platform;
  final ImagePicker _imagePicker = ImagePicker();
  late StreamSubscription<StreamDataModel> _subscriptions;

  int? _getPageNo(List responce) => responce.isNotEmpty ? state.pageNo + 1 : null;

  void init() async {
    _subscriptions = SocketService.instance.streamController.stream.listen((data) {
      if (data.streamType == StreamType.message) {
        final model = data.data as SocketMessageModel;
        emit(
          state.copyWith(
            chats: [
              ChatModel(
                updatedAt: model.updatedAt ?? DateTime.now(),
                messageId: model.id,
                chatType: ChatType.message,
                content: model.text,
                files: model.image,
                userInfo: ChatUserInfo(
                  userId: model.ownerId ?? '',
                  name: model.sender.name,
                  image: model.sender.image,
                ),
                createdAt: model.createdAt ?? DateTime.now(),
              ),
              ...state.chats,
            ],
          ),
        );
      }
    });
    fetch();
  }

  Future<void> fetch() async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, chats: [], pageNo: 1));
    final responce = await _repository.fetchChat(page: 1, chatId: chatId);
    emit(
      state.copyWith(
        chats: responce.data,
        isLoading: false,
        pageNo: _getPageNo(responce.data ?? []),
      ),
    );
  }

  Future<void> loadMore() async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true));
    final responce = await _repository.fetchChat(page: state.pageNo, chatId: chatId);
    AppLogger.debug(responce.data.toString());
    emit(
      state.copyWith(
        isLoading: false,
        chats: [...state.chats, ...responce.data ?? []],
        pageNo: _getPageNo(responce.data ?? []),
      ),
    );
  }

Future<void> send({required String userId}) async {
    final chat = ChatModel(
      messageId: DateTime.now().millisecondsSinceEpoch.toString(),
      isSending: true,
      chatType: ChatType.message,
      content: state.message,
      files: state.filePath.map((e) => e.path).toList(),
      userInfo: ChatUserInfo(userId: userId, name: '', image: ''),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    emit(state.copyWith(chats: [chat, ...state.chats], filePath: [], message: ''));

    final result = await _repository.sendMessage(
      message: chat.content,
      chatId: chatId,
      rowFiles: state.filePath,
    );
    final updatedChats = state.chats.map((e) {
      if (e.messageId == chat.messageId) {
        return e.copyWith(isSending: false, isSendingFaild: !result);
    }
      return e;
    }).toList();

    emit(state.copyWith(chats: updatedChats));
}


  Future<void> onMessageChange({required String message}) async {
    emit(state.copyWith(message: message));
  }

  Future<void> pickImage({bool isAttachment = true}) async {
    if (isAttachment) {
      await const PermissionHandlerHelper(permission: Permission.storage).getStatus();
      final pickedFile = await _picker.pickFiles(allowMultiple: true);
      List<XFile> files = pickedFile?.files.map((e) => e.xFile).toList() ?? [];
      if (files.length > 9) {
        files = files.sublist(0, 9);
        showSnackBar(AppString.maximumFileSelection(9), type: SnackBarType.warning);
      }

      emit(state.copyWith(filePath: files));
    } else {
      await const PermissionHandlerHelper(permission: Permission.photos).getStatus();
      final pickedFile = await _imagePicker.pickMultiImage(limit: 9);
      List<XFile> files = pickedFile.map((e) => XFile(e.path)).toList();
      if (files.length > 9) {
        files = files.sublist(0, 9);
        showSnackBar(AppString.maximumFileSelection(9), type: SnackBarType.warning);
      }
      emit(state.copyWith(filePath: files));
    }
  }

  Future<void> removeFile(int index) async {
    final updatedList = List.of(state.filePath);
    updatedList.removeAt(index);
    emit(state.copyWith(filePath: updatedList));
  }

  Future<void> deleteMessage({required String messageId}) async {
    final result = await _repository.deleteMessage(messageId: messageId);
    if (result) {
      final list = List.from(state.chats);
      final index = state.chats.indexWhere((e) => e.messageId == messageId);
      list.removeAt(index);
      emit(state.copyWith(chats: [...list]));
    }
  }

  Future<void> editMessage({
    required String messageId,
    required String message,
    required int index,
  }) async {
    final result = await _repository.editMessage(messageId: messageId, message: message);
    if (result) {
      final list = List.from(state.chats);
      final model = list[index];
      list[index] = list[index].copyWith(
        content: message,
        isEdit: false,
        createdAt: model.createdAt,
        updatedAt: DateTime.now(),
      );
      emit(state.copyWith(chats: [...list], editIndex: -1));
    } else {
      final list = List.from(state.chats);
      showSnackBar('Could not edit message', type: SnackBarType.error);
      list[index] = list[index].copyWith(isEdit: false);
      emit(state.copyWith(chats: [...list], editIndex: -1));
    }
  }

  Future<void> resendMessage({required String messageId}) async {
    final chat = state.chats.firstWhere((e) => e.messageId == messageId);

    emit(
      state.copyWith(
        chats: state.chats.map((e) {
          return e.messageId == messageId
              ? e.copyWith(
                  isSending: true,
                  isSendingFaild: false,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                )
              : e;
        }).toList(),
      ),
    );

    final result = await _repository.sendMessage(
      message: chat.content,
      chatId: chatId,
      rowFiles: chat.files?.map(XFile.new).toList(),
    );
    emit(
      state.copyWith(
        chats: state.chats.map((e) {
          return e.messageId == messageId
              ? e.copyWith(
                  isSending: false,
                  isSendingFaild: !result,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                )
              : e;
        }).toList(),
      ),
    );
  }

  void enableEdit(int index) {
    final list = List.from(state.chats);
    if (state.editIndex != -1) {
      list[state.editIndex] = list[state.editIndex].copyWith(isEdit: false);
    }
    list[index] = list[index].copyWith(isEdit: true);
    emit(state.copyWith(chats: [...list], editIndex: index));
  }

  void disableEdit(int index) {
    final list = List.from(state.chats);
    list[index] = list[index].copyWith(isEdit: false);
    emit(state.copyWith(chats: [...list], editIndex: -1));
  }

  Future<void> reportChat({
    required String chatId,
    required List<String> selectedReasons,
    required String others,
  }) async {
    _repository.reportChat(
      chatId: chatId,
      privacyConcerns: selectedReasons.contains(AppString.privacyConcerns),
      eroticContent: selectedReasons.contains(AppString.eroticContent),
      obscene: selectedReasons.contains(AppString.obscene),
      defamation: selectedReasons.contains(AppString.defamation),
      copyrightViolations: selectedReasons.contains(AppString.copyrightViolations),
      others: others,
    );
  }

  @override
  Future<void> close() {
    _subscriptions.cancel();
    return super.close();
  }
}
