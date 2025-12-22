import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swoony/core/config/secret_key/secret_key.dart';

class PolylineUseCase {
  const PolylineUseCase();

  Future<RoutesApiResponse> getRouteBetweenPoints(LatLng start, LatLng end, TravelMode mode) async {
    final polylinePoints = PolylinePoints(apiKey: SecretKey.mapKey);
    final request = RoutesApiRequest(
      origin: PointLatLng(start.latitude, start.longitude),
      destination: PointLatLng(end.latitude, end.longitude),
      travelMode: mode,
    );
    return await polylinePoints.getRouteBetweenCoordinatesV2(request: request);
  }

  List<LatLng>? getPoints(Route? route) {
    return route?.polylinePoints?.map((p) => LatLng(p.latitude, p.longitude)).toList();
  }

  num calculateDistance(Route? route) {
    return route?.distanceMeters ?? 0;
  }

  num calculateDuration(Route? route) {
    return route?.duration ?? 0;
  }
}
