// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceDetails extends Equatable {
  const PlaceDetails({required this.address, required this.coordinate});
  final String address;
  final LatLng coordinate;

  PlaceDetails copyWith({String? address, LatLng? coordinate}) {
    return PlaceDetails(address: address ?? this.address, coordinate: coordinate ?? this.coordinate);
  }

  @override
  String toString() => 'PlaceDetails(address: $address, coordinate: $coordinate)';

  @override
  List<Object> get props => [address, coordinate];
}
