// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SignUpModel {
  final String verificationId;
  final String otp;
  final String password;
  final DateTime? dateOfBirth;
  final String fullName;
  final String email;
  final String phone;
  final String registrationType;
  final String country;
  final String city;
  final String state;
  const SignUpModel({
    required this.verificationId,
    required this.otp,
    required this.password,
    this.dateOfBirth,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.registrationType,
    required this.country,
    required this.city,
    required this.state,
  });


  SignUpModel copyWith({
    String? verificationId,
    String? otp,
    String? password,
    DateTime? dateOfBirth,
    String? fullName,
    String? email,
    String? phone,
    String? registrationType,
    String? country,
    String? city,
    String? state,
  }) {
    return SignUpModel(
      verificationId: verificationId ?? this.verificationId,
      otp: otp ?? this.otp,
      password: password ?? this.password,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      registrationType: registrationType ?? this.registrationType,
      country: country ?? this.country,
      city: city ?? this.city,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'verificationId': verificationId,
      'otp': otp,
      'password': password,
      'dateOfBirth': dateOfBirth?.millisecondsSinceEpoch,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'registrationType': registrationType,
      'country': country,
      'city': city,
      'state': state,
    };
  }

  factory SignUpModel.fromMap(Map<String, dynamic> map) {
    return SignUpModel(
      verificationId: map['verificationId'] as String,
      otp: map['otp'] as String,
      password: map['password'] as String,
      dateOfBirth: map['dateOfBirth'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateOfBirth'] as int)
          : null,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      registrationType: map['registrationType'] as String,
      country: map['country'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpModel.fromJson(String source) => SignUpModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SignUpModel(verificationId: $verificationId, otp: $otp, password: $password, dateOfBirth: $dateOfBirth, fullName: $fullName, email: $email, phone: $phone, registrationType: $registrationType, country: $country, city: $city, state: $state)';
  }

  @override
  bool operator ==(covariant SignUpModel other) {
    if (identical(this, other)) return true;
  
    return other.verificationId == verificationId &&
        other.otp == otp &&
        other.password == password &&
        other.dateOfBirth == dateOfBirth &&
        other.fullName == fullName &&
        other.email == email &&
        other.phone == phone &&
        other.registrationType == registrationType &&
        other.country == country &&
        other.city == city &&
        other.state == state;
  }

  @override
  int get hashCode {
    return verificationId.hashCode ^
        otp.hashCode ^
        password.hashCode ^
        dateOfBirth.hashCode ^
        fullName.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        registrationType.hashCode ^
        country.hashCode ^
        city.hashCode ^
        state.hashCode;
  }
}
