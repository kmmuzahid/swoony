import 'package:swoony/common/auth/repository/auth_repository.dart';
import 'package:swoony/common/auth/repository/auth_repository_impl.dart';  
import 'package:swoony/common/event/repository/event_details_repository.dart';
import 'package:swoony/common/home/repository/home_repository.dart'; 
import 'package:swoony/common/tickets/repository/ticket_repository.dart';
import 'package:swoony/core/config/dependency/dependency_injection.dart';
import 'package:swoony/core/utils/log/app_log.dart';
import 'package:swoony/organizer/createTicket/repository/create_ticket_repository.dart';
 

class RealRepositoryDependency {
  static void dependencies() {
    
    // getIt.registerLazySingleton<ChatRepository>(RealChatRepository.new); 
    // getIt.registerLazySingleton<TicketPurchaseRepository>(RealTicketPurchaseRepository.new);
    
    getIt.registerLazySingleton<CreateTicketRepository>(CreateTicketRepository.new);
    getIt.registerLazySingleton(HomeRepository.new);
    getIt.registerLazySingleton<EventDetailsRepository>(EventDetailsRepository.new);

    getIt.registerLazySingleton<AuthRepository>(AuthRepositoryImpl.new);
    getIt.registerLazySingleton<TicketRepository>(TicketRepository.new);
    AppLogger.debug('Real repository dependency initalized', tag: 'dependency');
  }
}
