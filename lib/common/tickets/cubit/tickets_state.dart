import 'package:equatable/equatable.dart';
import 'package:swoony/common/tickets/model/ticket_model.dart';
import 'package:swoony/common/tickets/widgets/ticket_filter_widget.dart';

class TicketsState extends Equatable {
  const TicketsState({
    this.selectedFilter,
    this.tickets = const [],
    this.page = 1,
    this.isLoading = false,
  });

  final List<TicketModel> tickets;
  final TicketFilter? selectedFilter;
  final int page;
  final bool isLoading;

  TicketsState copyWith({
    List<TicketModel>? tickets,
    TicketFilter? selectedFilter,
    int? page,
    bool? isLoading,
  }) {
    return TicketsState(
      tickets: tickets ?? this.tickets,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading
    );
  }

  @override
  List<Object?> get props => [tickets, selectedFilter, page, isLoading];
}
