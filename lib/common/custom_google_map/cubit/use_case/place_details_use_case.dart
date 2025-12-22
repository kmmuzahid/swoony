import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:swoony/core/config/secret_key/secret_key.dart';
import 'package:swoony/core/utils/log/app_log.dart';

import '../../model/place_details.dart';

class PlaceDetailsUseCase {
  Future<PlaceDetails?> getPlaceDetails(double latitude, double longitude) async {
    try {
      final url =
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=${SecretKey.mapKey}';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK' && data['results'].isNotEmpty) {
          final place = data['results'][0]['formatted_address'];
          return PlaceDetails(address: place, coordinate: LatLng(latitude, longitude));
        }
      }
    } catch (e) {
      AppLogger.error('Error fetching place details: $e');
    }
    return null;
  }

  Future<PlaceDetails?> getPlaceDetailsFromPlaceId(String placeId, String address) async {
    try {
      final url =
          'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=${SecretKey.mapKey}';

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        final double lat = result['result']['geometry']['location']['lat'];
        final double lng = result['result']['geometry']['location']['lng'];
        final coordinate = LatLng(lat, lng);
        return PlaceDetails(address: address, coordinate: coordinate);
      }
    } catch (e) {
      AppLogger.error('Error fetching place details by placeId: $e');
    }
    return null;
  }
}
