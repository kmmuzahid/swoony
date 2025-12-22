import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swoony/organizer/createTicket/model/create_event_model.dart';

class CreateTicketState extends Equatable {
  final int currentPage;
  final bool isReadOnly;
  final bool isExpandedView;
  final CreateEventModel createEventModel;
  final CreateEventModel draftEventModel;
  final XFile? image;
  final bool isLoading;
  final bool isDraftFetching;

  const CreateTicketState({
    this.currentPage = 0,
    this.isExpandedView = false,
    this.isReadOnly = false,
    this.isLoading = false,
    this.isDraftFetching = false,
    required this.createEventModel,
    required this.draftEventModel,
    this.image,
  });

  CreateTicketState copyWith({
    int? currentPage,
    bool? isExpandedView,
    bool? isReadOnly,
    CreateEventModel? createEventModel,
    CreateEventModel? draftEventModel,
    XFile? image,
    bool? isDraftFetching,
    bool? isLoading,
  }) {
    return CreateTicketState(
      currentPage: currentPage ?? this.currentPage,
      isExpandedView: isExpandedView ?? this.isExpandedView,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      isDraftFetching: isDraftFetching ?? this.isDraftFetching,
      isLoading: isLoading ?? this.isLoading,
      createEventModel: createEventModel ?? this.createEventModel,
      draftEventModel: draftEventModel ?? this.draftEventModel,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [
    currentPage,
    isExpandedView,
    isReadOnly,
    isDraftFetching,
    createEventModel,
    draftEventModel,
    image?.path,
    isLoading,
  ];
}
