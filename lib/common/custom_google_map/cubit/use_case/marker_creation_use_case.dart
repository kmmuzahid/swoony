import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class MarkerCreationUseCase {
  Future<Marker> createStartMarker(LatLng coordinate) async {
    return Marker(
      markerId: const MarkerId('starting'),
      position: coordinate,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(title: 'Start'),
    );
  }

  Future<Marker> createDestinationMarker(LatLng coordinate) async {
    return Marker(
      markerId: const MarkerId('destination'),
      position: coordinate,
      infoWindow: const InfoWindow(title: 'Destination'),
    );
  }

  Future<BitmapDescriptor> createCustomMarker(String text) async {
    return CommonText(
      text: text,
      decorationColor: Colors.amber,
      textColor: Colors.amber,
      fontWeight: FontWeight.bold,
    ).toBitmapDescriptor();
  }
}
