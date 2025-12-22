// form_cubit.dart
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:swoony/common/event/repository/event_details_repository.dart';
import 'package:swoony/core/component/other_widgets/permission_handler_helper.dart';
import 'package:swoony/core/config/bloc/safe_cubit.dart';
import 'package:swoony/core/config/dependency/dependency_injection.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/config/route/app_router.gr.dart';
import 'package:swoony/core/utils/log/app_log.dart';
import 'package:swoony/main.dart';
import 'package:swoony/organizer/createTicket/model/create_event_model.dart';
import 'package:permission_handler/permission_handler.dart';

import '../repository/create_ticket_repository.dart';
import 'create_ticket_state.dart';

class CreateTicketCubit extends SafeCubit<CreateTicketState> {
  CreateTicketCubit()
    : super(
        CreateTicketState(
          createEventModel: CreateEventModel.empty(),
          draftEventModel: CreateEventModel.empty(),
        ),
      );
  final ImagePicker _imagePicker = ImagePicker();
  final CreateTicketRepository repository = getIt();
  final EventDetailsRepository eventDetailsRepository = getIt();
  // Navigate to next page
  void saveDraft() async {
    if (state.isLoading) return;
    if (state.createEventModel.startTime != null &&
        state.createEventModel.endTime != null &&
        state.createEventModel.startTime!.isAfter(state.createEventModel.endTime!)) {
      showSnackBar('Event End Time should be greater than Start Time', type: SnackBarType.error);
      return;
    }
    if ((state.image == null && state.draftEventModel.image == null) ||
        state.createEventModel.title == null ||
        state.createEventModel.title?.isEmpty == true ||
        state.createEventModel.description == null ||
        state.createEventModel.description?.isEmpty == true) {
      showSnackBar(
        'Sorry! Image, Title and Event Description is Mandatory',
        type: SnackBarType.error,
      );
      return;
    }
    emit(state.copyWith(isLoading: true));
    // final result = await repository.saveDraft(
    //   createEvent: state.createEventModel,
    //   category: state.createEventModel.selectedCategory,
    //   subCategory: state.createEventModel.selectedSubcategories,
    //   image: state.image,
    // );
    // if (result.isSuccess) {
    //   if (result.data['_id'] != null) {
    //     emit(
    //       state.copyWith(
    //         createEventModel: state.createEventModel.copyWith(draftId: result.data['_id']),
    //       ),
    //     );
    //   }
    // }
    emit(state.copyWith(isLoading: false));
  }

  void updatePromoCode({
    required String code,
    required int discountPercentage,
    required int filedId,
    required DateTime? expireDate,
  }) {
    final currentDiscounts = List<DiscountCodeModel>.from(state.createEventModel.discountCodes);
    final existingIndex = currentDiscounts.indexWhere((element) => element.filedId == filedId);

    final updatedDiscount = existingIndex != -1
        ? currentDiscounts[existingIndex].copyWith(
            code: code,
            discountPercentage: discountPercentage,
            expireDate: expireDate,
          )
        : DiscountCodeModel(
            code: code,
            discountPercentage: discountPercentage,
            filedId: filedId,
            expireDate: expireDate,
          );

    if (existingIndex != -1) {
      currentDiscounts[existingIndex] = updatedDiscount;
    } else {
      currentDiscounts.add(updatedDiscount);
    }

    emit(
      state.copyWith(
        createEventModel: state.createEventModel.copyWith(discountCodes: currentDiscounts),
      ),
    );
  }

  void submit() async {
    // final result = await repository.submit(
    //   createEvent: state.createEventModel,
    //   category: state.createEventModel.selectedCategory,
    //   subCategory: state.createEventModel.selectedSubcategories,
    //   image: state.image,
    // );
    // if (result.isSuccess) {
    //   appRouter.replaceAll([const HomeRoute()]);
    // }
  }

  void fetchDraft({required String id}) async {}

  void nextPage() {
    if (state.currentPage < 2) {
      emit(state.copyWith(currentPage: state.currentPage + 1));
    }
  }

  void updateReadOnly() {
    emit(state.copyWith(isReadOnly: !state.isReadOnly));
  }

  // Navigate to previous page
  void previousPage() {
    if (state.currentPage > 0) {
      emit(state.copyWith(currentPage: state.currentPage - 1));
    }
  }

  // Toggle between page view and expanded view
  void toggleView() {
    updateReadOnly();
    emit(state.copyWith(isExpandedView: !state.isExpandedView));
  }

  // Update form field
  void updateField(CreateEventModel model) {
    emit(state.copyWith(createEventModel: model));
  }

  void removeSubCategory(int index) {
    // final List<SubCategoryModel> list = List.from(state.createEventModel.selectedSubcategories);
    // list.removeAt(index);
    // emit(
    //   state.copyWith(
    //     createEventModel: state.createEventModel.copyWith(selectedSubcategories: list),
    //   ),
    // );
  }

  Future<void> updateTicket({
    required TicketName ticketName,
    int? availableUnit,
    bool? isSelected,
    double? unitPrice,
  }) async {
    if (isSelected == false) {
      final List<TicketTypeModel> tickets = List.from(state.createEventModel.ticketTypes);
      tickets.removeWhere((element) => element.name == ticketName);
      emit(state.copyWith(createEventModel: state.createEventModel.copyWith(ticketTypes: tickets)));
    }

    final TicketTypeModel existingTicket = state.createEventModel.ticketTypes.firstWhere(
      (element) => element.name == ticketName,
      orElse: TicketTypeModel.empty,
    );

    final isSelectedTicket = (existingTicket.name == ticketName) || (isSelected ?? false);

    if (!(existingTicket.name == ticketName) && isSelected == true) {
      //create
      emit(
        state.copyWith(
          createEventModel: state.createEventModel.copyWith(
            ticketTypes: [
              ...state.createEventModel.ticketTypes,
              TicketTypeModel(
                name: ticketName,
                availableUnit: availableUnit ?? 0,
                setUnitPrice: unitPrice ?? 0,
              ),
            ],
          ),
        ),
      );
    } else if (isSelectedTicket) {
      //update
      final newTicket = existingTicket.copyWith(
        availableUnit: availableUnit ?? existingTicket.availableUnit,
        setUnitPrice: unitPrice ?? existingTicket.setUnitPrice,
      );

      // copy all tickets as list. later remove existing ticket. then add newticket and emit
      final List<TicketTypeModel> tickets = List.from(state.createEventModel.ticketTypes);
      tickets.removeWhere((element) => element.name == ticketName);
      tickets.add(newTicket);
      emit(state.copyWith(createEventModel: state.createEventModel.copyWith(ticketTypes: tickets)));
    }
  }

  Future<void> pickImage({bool isAttachment = true}) async {
    if (state.isReadOnly) return;
    final status = await const PermissionHandlerHelper(permission: Permission.photos).getStatus();
    if (status) {
      final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        if (checkImageResolution(pickedFile.path)) {
          emit(state.copyWith(image: pickedFile));
        } else {
          showSnackBar('Image resolution is not valid', type: SnackBarType.error);
        }
      }
    }
  }

  bool checkImageResolution(String path) {
    if (kDebugMode) return true;
    final image = img.decodeImage(File(path).readAsBytesSync());
    if (image != null) {
      return (image.width == 1080 && image.height == 1920);
    }
    return false;
  }
}
