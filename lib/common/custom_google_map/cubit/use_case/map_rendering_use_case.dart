import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class MapRenderingUseCase {
  const MapRenderingUseCase(this.mapController);
  final GoogleMapController mapController;

  Future<void> drawPolyline(List<LatLng> points, Function(Set<Polyline>) emitPolyline) async {
    final polyline = Polyline(
      polylineId: const PolylineId('route'),
      color: AppColors.primaryColor,
      width: 5,
      points: points,
    );

    emitPolyline({polyline});
    _moveCameraToFitPolyline(points);
  }

  void _moveCameraToFitPolyline(List<LatLng> polylinePoints) {
    if (polylinePoints.isEmpty) return;

    double minLat = polylinePoints[0].latitude,
        maxLat = polylinePoints[0].latitude,
        minLng = polylinePoints[0].longitude,
        maxLng = polylinePoints[0].longitude;

    for (final point in polylinePoints) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }

    // Assuming isClosed is false meaning camera should animate
    mapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(southwest: LatLng(minLat, minLng), northeast: LatLng(maxLat, maxLng)),
        50,
      ),
      duration: const Duration(milliseconds: 300),
    );
  }

  Future<void> addMarkers(
    LatLng start,
    LatLng end,
    LatLng middle,
    String distance,
    String duration,
    Function(Set<Marker>) emitMarkers,
    Future<BitmapDescriptor> Function(String) createCustomMarker,
  ) async {
    final middleMarkerIcon = await createCustomMarker('Distance- $distance\nDuration- $duration');
    final startMarker = Marker(
      markerId: const MarkerId('starting'),
      position: start,
      icon: await Icon(Icons.gps_fixed, color: AppColors.primaryColor).toBitmapDescriptor(),
    );
    final endMarker = Marker(markerId: const MarkerId('destination'), position: end);
    final middleMarker = Marker(
      markerId: const MarkerId('middle'),
      position: middle,
      icon: middleMarkerIcon,
    );

    emitMarkers({startMarker, endMarker, middleMarker});
  }
}
