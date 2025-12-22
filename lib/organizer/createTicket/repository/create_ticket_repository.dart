import 'package:image_picker/image_picker.dart';
import 'package:swoony/common/event/model/event_details_model.dart';
import 'package:swoony/core/config/api/api_end_point.dart';
import 'package:swoony/core/config/dependency/dependency_injection.dart';
import 'package:swoony/core/config/network/dio_service.dart';
import 'package:swoony/core/config/network/request_input.dart';
import 'package:swoony/core/config/network/response_state.dart';
import 'package:swoony/core/utils/app_utils.dart';
import 'package:swoony/core/utils/extensions/extension.dart';
import 'package:swoony/core/utils/log/app_log.dart';
import 'package:swoony/organizer/createTicket/model/create_event_model.dart';

class CreateTicketRepository {
  DioService dioService = getIt();
}
