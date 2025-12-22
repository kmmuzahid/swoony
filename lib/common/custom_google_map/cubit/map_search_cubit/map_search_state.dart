import 'package:equatable/equatable.dart';

class MapSearchState extends Equatable {
  const MapSearchState({this.isLoading = false, this.searchResults = const {}, this.errorMessage = ''});
  final bool isLoading;
  final Map<String, String> searchResults;
  final String errorMessage;

  MapSearchState copyWith({bool? isLoading, Map<String, String>? searchResults, String? errorMessage}) {
    return MapSearchState(
      isLoading: isLoading ?? this.isLoading,
      searchResults: searchResults ?? this.searchResults,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [isLoading, searchResults, errorMessage];
}
