// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:swoony/common/tickets/model/ticket_model.dart';

class AllEventState {
  const AllEventState({this.isLoading = false, this.page = 1, this.events = const []});

  final bool isLoading;
  final int page;
  final List<TicketModel> events;

  AllEventState copyWith({bool? isLoading, int? page, List<TicketModel>? events}) {
    return AllEventState(
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page,
      events: events ?? this.events,
    );
  }

  @override
  bool operator ==(covariant AllEventState other) {
    if (identical(this, other)) return true;

    return other.isLoading == isLoading && other.page == page && listEquals(other.events, events);
  }

  @override
  int get hashCode => isLoading.hashCode ^ page.hashCode ^ events.hashCode;
}
