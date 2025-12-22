import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:swoony/core/config/bloc/safe_cubit.dart';
import 'package:swoony/core/config/secret_key/secret_key.dart';
import 'package:swoony/core/utils/helpers/debouncer.dart';

import 'map_search_state.dart';

class MapSearchCubit extends SafeCubit<MapSearchState> {
  // Replace with your API key

  MapSearchCubit() : super(const MapSearchState());

  // Method to fetch place suggestions with coordinates
  Future<void> getPlaceSuggestions(String searchTerm) async {
    Debouncer(delay: const Duration(milliseconds: 300)).call(() async {
      try {
        emit(state.copyWith(isLoading: true, errorMessage: ''));

        final url =
            'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchTerm&key=${SecretKey.mapKey}';

        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          if (data['status'] == 'OK') {
            final Map<String, String> suggestionsWithCoordinates = {};
            for (final prediction in data['predictions']) {
              final String id = prediction['place_id'];
              final String address = prediction['description'];
              suggestionsWithCoordinates[id] = address;
            }

            emit(state.copyWith(isLoading: false, searchResults: suggestionsWithCoordinates));
          } else {
            emit(state.copyWith(isLoading: false, errorMessage: 'Failed to load suggestions.'));
          }
        } else {
          emit(state.copyWith(isLoading: false, errorMessage: 'Failed to fetch data from API.'));
        }
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorMessage: 'Error: $e'));
      }
    });
  }

  Future<void> onClear() async {
    emit(const MapSearchState());
  }
}
