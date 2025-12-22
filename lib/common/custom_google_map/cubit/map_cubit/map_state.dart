// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../model/place_details.dart';

enum PointType { starting, destination }

class MapState extends Equatable {
  const MapState({
    required this.lastPikedPointType,
    required this.markers,
    required this.starting,
    required this.mapRoute,
    required this.travelMode,
    required this.initialized,
    required this.initializing,
    required this.isLoading,
    this.destination,
  });

  // Create an initial state
  MapState.initial()
    : markers = {},
      mapRoute = {},
      travelMode = TravelMode.driving,
      initialized = false,
      isLoading = false,
      lastPikedPointType = PointType.starting,
        starting = const PlaceDetails(address: '', coordinate: LatLng(51.165691, 10.451526)),
      destination = null,
      // destination = const PlaceDetails(address: 'Merul Badda', coordinate: LatLng(23.772109, 90.419656)),
      initializing = true;
  final PointType lastPikedPointType;
  final PlaceDetails starting;
  final PlaceDetails? destination;
  final bool isLoading;
  final Set<Marker> markers;
  final Set<Polyline> mapRoute;
  final TravelMode travelMode;
  final bool initialized;
  final bool initializing;

  // Copy constructor for state update

  @override
  List<Object> get props {
    return [
      starting,
      destination ?? '',
      isLoading,
      markers,
      mapRoute,
      travelMode,
      initialized,
      initializing,
      lastPikedPointType,
    ];
  }

  MapState copyWith({
    PointType? lastPikedPointType,
    PlaceDetails? starting,
    PlaceDetails? destination,
    bool? isLoading,
    Set<Marker>? markers,
    Set<Polyline>? mapRoute,
    TravelMode? travelMode,
    bool? initialized,
    bool? initializing,
  }) {
    return MapState(
      lastPikedPointType: lastPikedPointType ?? this.lastPikedPointType,
      starting: starting ?? this.starting,
      destination: destination ?? this.destination,
      isLoading: isLoading ?? this.isLoading,
      markers: markers ?? this.markers,
      mapRoute: mapRoute ?? this.mapRoute,
      travelMode: travelMode ?? this.travelMode,
      initialized: initialized ?? this.initialized,
      initializing: initializing ?? this.initializing,
    );
  }
}
