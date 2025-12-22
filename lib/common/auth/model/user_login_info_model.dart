// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum Role { ATTENDEE, ORGANIZER }

class UserLoginInfoModel {
  final String accessToken;
  final String refreshToken; 
  //enum
  final Role? role;
  final String id;
  const UserLoginInfoModel({
    required this.accessToken,
    required this.refreshToken,
    required this.role,
    required this.id,
  });

  UserLoginInfoModel copyWith({String? accessToken, String? refreshToken, Role? role, String? id}) {
    return UserLoginInfoModel(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      role: role ?? this.role,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'role': role?.index,
      'id': id,
    };
  }

  factory UserLoginInfoModel.fromMap(Map<String, dynamic> map) {
    return UserLoginInfoModel(
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
      role: map['role'] != null ? Role.values[map['role'] as int] : null,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLoginInfoModel.fromJson(String source) =>
      UserLoginInfoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserLoginInfoModel( accessToken: $accessToken, refreshToken: $refreshToken, role: $role, id: $id)';
  }

  @override
  bool operator ==(covariant UserLoginInfoModel other) {
    if (identical(this, other)) return true;

    return other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.role == role &&
        other.id == id;
  }

  @override
  int get hashCode {
    return accessToken.hashCode ^ refreshToken.hashCode ^ role.hashCode ^ id.hashCode;
  }
}
