import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swoony/common/chat/model/chat_list_item_model.dart';
import 'package:swoony/common/chat/model/chat_model.dart';
import 'package:swoony/common/chat/repository/chat_repository.dart';
import 'package:swoony/core/config/api/api_end_point.dart';
import 'package:swoony/core/config/dependency/dependency_injection.dart';
import 'package:swoony/core/config/network/dio_service.dart';
import 'package:swoony/core/config/network/request_input.dart';
import 'package:swoony/core/config/network/response_state.dart';
import 'package:swoony/core/config/socket/socket_message_model.dart';
import 'package:swoony/core/utils/app_utils.dart';
 

import '../model/chat_user_info.dart';

class MockChatRepository implements ChatRepository {
  final DioService _dioService = getIt();
  
  @override
  Future<bool> reportChat({
    required String chatId,
    bool? privacyConcerns,
    bool? obscene,
    bool? defamation,
    bool? copyrightViolations,
    bool? eroticContent,
    String? others,
  }) async {
    final result = await _dioService.request(
      showMessage: true,
      input: RequestInput(
        endpoint: ApiEndPoint.instance.reportChat(chatId: chatId),
        method: RequestMethod.POST,
        jsonBody: {
          'Privacy_concerns': privacyConcerns,
          'Others': others,
          'Obscene': obscene,
          'Defamation': defamation,
          'Copyright_violations': copyrightViolations,
          'Erotic_content': eroticContent,
        },
      ),
      responseBuilder: (data) => data,
    );
    return result.isSuccess;
  }

  @override
  Future<bool> editMessage({required String messageId, required String message}) async {
    final result = await _dioService.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.editMessage(messageId: messageId),
        method: RequestMethod.PATCH,
        jsonBody: {'text': message},
      ),
      responseBuilder: (data) => data,
    );

    return result.isSuccess;
  }

  @override
  Future<bool> deleteMessage({required String messageId}) async {
    final result = await _dioService.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.deleteMessage(messageId: messageId),
        method: RequestMethod.DELETE,
      ),
      responseBuilder: (data) => data,
    );

    return result.isSuccess;
  }

  @override
  Future<ResponseState<List<ChatListItemModel>?>> fetchChatList({required int page}) async {
    return _dioService.request(
      input: RequestInput(endpoint: ApiEndPoint.instance.chat, method: RequestMethod.GET),
      responseBuilder: (data) {
        if (data != null) {
          return (data as List)
              .map(
                (e) => ChatListItemModel(
                  chatId: e['id'],
                  userImage: e['photo'],
                  userStatus: UserStatus.online,
                  lastSendMessageTime: Utils.parseDate(e['lastMessageTime']) ?? DateTime.now(),
                  userName: e['name'] ?? '',
                  lastMessage: e['lastMessage'] ?? '',
                  isRead: e['lastMessageRead'] ?? false,
                ),
              )
              .toList();
        }
      },
    );
  }

  @override
  Future<ResponseState<List<ChatModel>?>> fetchChat({
    required int page,
    required String chatId,
  }) async {
    return _dioService.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.getMessages(chatId: chatId),
        queryParams: {'limit': 20, 'page': page},
        method: RequestMethod.GET,
      ),
      responseBuilder: (data) => (data as List).map((e) {
        final model = SocketMessageModel.fromJson(e);
        return ChatModel(
          messageId: model.id,
          updatedAt: model.updatedAt ?? DateTime.now(),
          chatType: ChatType.message,
          files: model.image,
          content: model.text,
          userInfo: ChatUserInfo(
            userId: model.ownerId ?? '',
            name: model.sender.name,
            image: model.sender.image,
          ),
          createdAt: model.createdAt ?? DateTime.now(),
        );
      }).toList(),
    );
  }

  @override
  Future<bool> sendMessage({
    required String chatId,
    required String message,
    required List<XFile>? rowFiles,
  }) async {
    final image = rowFiles
        ?.where(
          (e) => e.path.endsWith('.png') || e.path.endsWith('.jpg') || e.path.endsWith('.jpeg'),
        )
        .toList();
    final file = rowFiles
        ?.where(
          (e) => e.path.endsWith('.pdf') || e.path.endsWith('.doc') || e.path.endsWith('.docx'),
        )
        .toList(); 
    final result = await _dioService.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.sentMessage,
        method: RequestMethod.POST,
        formFields: {'chatId': chatId, 'text': message},
        files: {
          if (image?.isNotEmpty ?? false) 'image': image,
          if (file?.isNotEmpty ?? false) 'document': file,
          'chatId': chatId,
        }, 
      ),
      responseBuilder: (data) => data,
    );

    return result.isSuccess;
  }

  @override
  Future<ResponseState<List<ChatListItemModel>?>> searchChatList({
    required int page,
    required String keywords,
  }) {
    return _dioService.request(
      input: RequestInput(
        endpoint: ApiEndPoint.instance.chat,
        queryParams: {'search': keywords},
        method: RequestMethod.GET,
      ),
      responseBuilder: (data) {
        if (data != null) {
          return (data as List)
              .map(
                (e) => ChatListItemModel(
                  chatId: e['id'],
                  userImage: e['photo'],
                  userStatus: UserStatus.online,
                  lastSendMessageTime: Utils.parseDate(e['lastMessageTime']) ?? DateTime.now(),
                  userName: e['name'] ?? '',
                  lastMessage: e['lastMessage'] ?? '',
                  isRead: e['lastMessageRead'] ?? '',
                ),
              )
              .toList();
        }
      },
    );
  }
}
