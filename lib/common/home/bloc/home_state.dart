// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.currentIndex,
    this.unreadMessage = 0,
    this.unreadNotification = 0,
  });
  final int currentIndex;
  final int unreadMessage;
  final int unreadNotification;

  @override
  List<Object?> get props => [currentIndex, unreadMessage, unreadNotification];

  HomeState copyWith({int? currentIndex, int? unreadMessage, int? unreadNotification}) {
    return HomeState(
      currentIndex: currentIndex ?? this.currentIndex,
      unreadMessage: unreadMessage ?? this.unreadMessage,
      unreadNotification: unreadNotification ?? this.unreadNotification,
    );
  }
}
