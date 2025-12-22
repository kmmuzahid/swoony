import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swoony/common/auth/repository/auth_repository.dart';
import 'package:swoony/common/auth/repository/auth_repository_impl.dart';
import 'package:swoony/common/chat/repository/chat_repository.dart';
import 'package:swoony/common/chat/repository/mock_chat_repository.dart';
import 'package:swoony/common/tickets/repository/ticket_repository.dart';
import 'package:swoony/core/config/dependency/dependency_injection.dart';
import 'package:swoony/core/utils/log/app_log.dart';
import 'package:swoony/organizer/createTicket/repository/create_ticket_repository.dart';

class MockRepositoryDependency {
  static void dependencies() {
    getIt.registerLazySingleton<ChatRepository>(MockChatRepository.new);
    AppLogger.debug('Mock repository dependency initalized', tag: 'dependency');
  }
}
