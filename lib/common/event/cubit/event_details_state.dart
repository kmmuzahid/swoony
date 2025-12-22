// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:swoony/common/event/model/event_details_model.dart';

class EventDetailsState extends Equatable {
  const EventDetailsState({this.showDetails = false, this.eventDetails, this.isLoading = false});
  final bool showDetails;
  final EventDetailsModel? eventDetails;
  final bool isLoading;

  @override
  List<Object?> get props => [showDetails, eventDetails.hashCode, isLoading];

  EventDetailsState copyWith({
    bool? showDetails,
    EventDetailsModel? eventDetails,
    bool? isLoading,
  }) {
    return EventDetailsState(
      showDetails: showDetails ?? this.showDetails,
      eventDetails: eventDetails ?? this.eventDetails,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
