// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MapSearchModel {
  final String id;
  final String address;
  MapSearchModel({required this.id, required this.address});

  MapSearchModel copyWith({String? id, String? address}) {
    return MapSearchModel(id: id ?? this.id, address: address ?? this.address);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'address': address};
  }

  factory MapSearchModel.fromMap(Map<String, dynamic> map) {
    return MapSearchModel(id: map['id'] as String, address: map['address'] as String);
  }

  String toJson() => json.encode(toMap());

  factory MapSearchModel.fromJson(String source) => MapSearchModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MapSearchModel(id: $id, address: $address)';

  @override
  bool operator ==(covariant MapSearchModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.address == address;
  }

  @override
  int get hashCode => id.hashCode ^ address.hashCode;
}
