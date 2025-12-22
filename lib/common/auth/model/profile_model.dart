// ignore_for_file: public_member_api_docs, sort_constructors_first
// Flutter model class for 'Profile'
import 'package:swoony/common/auth/model/user_login_info_model.dart';

class ProfileModel {
  final String id;
  final String name;
  final Role role;
  final String email;
  final String contact;
  final String image;
  final String status;
  final bool verified;
  final bool termsAndCondition;
  final StripeAccountInfo stripeAccountInfo;
  final PersonalInfo personalInfo;
  final Address address;
  final DateTime joinedDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int mainlandFee;
  final NotificationPreferenceModel notificationPreference;
  final double withDrawAmount;
  final double sellAmount;

  ProfileModel({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    required this.contact,
    required this.image,
    required this.status,
    required this.verified,
    required this.termsAndCondition,
    required this.stripeAccountInfo,
    required this.personalInfo,
    required this.address,
    required this.joinedDate,
    required this.createdAt,
    required this.updatedAt,
    required this.mainlandFee,
    required this.notificationPreference,
    required this.withDrawAmount,
    required this.sellAmount,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      mainlandFee: json['mainlandFee'] ?? 0,
      notificationPreference: json['notification'] != null
          ? NotificationPreferenceModel.fromJson(json['notification'])
          : const NotificationPreferenceModel(),
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] == 'USER' ? Role.ATTENDEE : Role.ORGANIZER,
      email: json['email'] ?? '',
      contact: json['contact'] ?? '',
      image: json['image'] ?? '',
      status: json['status'] ?? '',
      verified: json['verified'] ?? false,
      termsAndCondition: json['terAndCondition'] ?? false,
      stripeAccountInfo: StripeAccountInfo.fromJson(json['stripeAccountInfo'] ?? {}),
      personalInfo: PersonalInfo.fromJson(json['personalInfo'] ?? {}),
      address: Address.fromJson(json['address'] ?? {}),
      joinedDate: DateTime.tryParse(json['joinedDate'] ?? '') ?? DateTime(1970),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime(1970),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime(1970),
      sellAmount: json['sellAmount']?.toDouble() ?? 0,
      withDrawAmount: json['withDrawAmount']?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'role': role.name,
      'email': email,
      'notification': notificationPreference.toJson(),
      'contact': contact,
      'image': image,
      'status': status,
      'verified': verified,
      'terAndCondition': termsAndCondition,
      'stripeAccountInfo': stripeAccountInfo.toJson(),
      'personalInfo': personalInfo.toJson(),
      'address': address.toJson(),
      'joinedDate': joinedDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'mainlandFee': mainlandFee,
      'withDrawAmount': withDrawAmount,
    };
  }

  @override
  bool operator ==(covariant ProfileModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.role == role &&
        other.email == email &&
        other.contact == contact &&
        other.mainlandFee == mainlandFee &&
        other.image == image &&
        other.status == status &&
        other.verified == verified &&
        other.termsAndCondition == termsAndCondition &&
        other.stripeAccountInfo == stripeAccountInfo &&
        other.personalInfo == personalInfo &&
        other.address == address &&
        other.joinedDate == joinedDate &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.notificationPreference == notificationPreference &&
        other.withDrawAmount == withDrawAmount &&
        other.sellAmount == sellAmount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        role.hashCode ^
        email.hashCode ^
        contact.hashCode ^
        mainlandFee.hashCode ^
        image.hashCode ^
        status.hashCode ^
        verified.hashCode ^
        termsAndCondition.hashCode ^
        stripeAccountInfo.hashCode ^
        personalInfo.hashCode ^
        address.hashCode ^
        joinedDate.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        notificationPreference.hashCode ^
        withDrawAmount.hashCode ^
        sellAmount.hashCode;
  }

  ProfileModel copyWith({
    String? id,
    String? name,
    Role? role,
    String? email,
    String? contact,
    String? image,
    int? mainlandFee,
    String? status,
    bool? verified,
    bool? termsAndCondition,
    StripeAccountInfo? stripeAccountInfo,
    PersonalInfo? personalInfo,
    Address? address,
    DateTime? joinedDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? sellAmount,
    double? withDrawAmount,
    NotificationPreferenceModel? notificationPreference,
  }) {
    return ProfileModel(
      mainlandFee: mainlandFee ?? this.mainlandFee,
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      email: email ?? this.email,
      contact: contact ?? this.contact,
      image: image ?? this.image,
      status: status ?? this.status,
      verified: verified ?? this.verified,
      termsAndCondition: termsAndCondition ?? this.termsAndCondition,
      stripeAccountInfo: stripeAccountInfo ?? this.stripeAccountInfo,
      personalInfo: personalInfo ?? this.personalInfo,
      address: address ?? this.address,
      joinedDate: joinedDate ?? this.joinedDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notificationPreference: notificationPreference ?? this.notificationPreference,
      withDrawAmount: withDrawAmount ?? this.withDrawAmount,
      sellAmount: sellAmount ?? this.sellAmount,
    );
  }
}

class StripeAccountInfo {
  StripeAccountInfo({required this.stripeAccountId, required this.loginUrl});
  final String stripeAccountId;
  final String loginUrl;

  factory StripeAccountInfo.fromJson(Map<String, dynamic> json) {
    return StripeAccountInfo(
      stripeAccountId: json['stripeAccountId'] ?? '',
      loginUrl: json['loginUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'stripeCustomerId': stripeAccountId};
  }
}

class PersonalInfo {
  final String phone;
  final DateTime? dateOfBirth;
  final String firstName;
  final String lastName;

  PersonalInfo({
    required this.phone,
    required this.dateOfBirth,
    required this.firstName,
    required this.lastName,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    return PersonalInfo(
      phone: json['phone'] ?? '',
      dateOfBirth: json['dateOfBirth'] != null ? DateTime.tryParse(json['dateOfBirth']) : null,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}

class Address {
  final String city;
  final String street;
  final String country;
  final String postalCode;

  Address({
    required this.city,
    required this.street,
    required this.country,
    required this.postalCode,
  });

  Address copyWith({String? city, String? street, String? country, String? postalCode}) {
    return Address(
      city: city ?? this.city,
      street: street ?? this.street,
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
    );
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'] ?? '',
      street: json['street'] ?? '',
      country: json['country'] ?? '',
      postalCode: json['postalCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'city': city, 'street': street, 'country': country, 'postalCode': postalCode};
  }
}

class NotificationPreferenceModel {
  final bool? isSellTicketNotificationEnabled;
  final bool? isMessageNotificationEnabled;
  final bool? isPublishEventNotificationEnabled;
  final bool? isWithdrawMoneyNotificationEnabled;

  const NotificationPreferenceModel({
    this.isSellTicketNotificationEnabled,
    this.isMessageNotificationEnabled,
    this.isPublishEventNotificationEnabled,
    this.isWithdrawMoneyNotificationEnabled,
  });

  factory NotificationPreferenceModel.fromJson(Map<String, dynamic> json) {
    return NotificationPreferenceModel(
      isSellTicketNotificationEnabled: json['isSellTicketNotificationEnabled'],
      isMessageNotificationEnabled: json['isMessageNotificationEnabled'],
      isPublishEventNotificationEnabled: json['isPublishEventNotificationEnabled'],
      isWithdrawMoneyNotificationEnabled: json['isWithdrawMoneyNotificationEnabled'],
    );
  }

  Map<String, dynamic> toJson() => {
    "isSellTicketNotificationEnabled": isSellTicketNotificationEnabled,
    "isMessageNotificationEnabled": isMessageNotificationEnabled,
    "isPublishEventNotificationEnabled": isPublishEventNotificationEnabled,
    "isWithdrawMoneyNotificationEnabled": isWithdrawMoneyNotificationEnabled,
  };

  NotificationPreferenceModel copyWith({
    bool? isSellTicketNotificationEnabled,
    bool? isMessageNotificationEnabled,
    bool? isPublishEventNotificationEnabled,
    bool? isWithdrawMoneyNotificationEnabled,
  }) {
    return NotificationPreferenceModel(
      isSellTicketNotificationEnabled:
          isSellTicketNotificationEnabled ?? this.isSellTicketNotificationEnabled,
      isMessageNotificationEnabled:
          isMessageNotificationEnabled ?? this.isMessageNotificationEnabled,
      isPublishEventNotificationEnabled:
          isPublishEventNotificationEnabled ?? this.isPublishEventNotificationEnabled,
      isWithdrawMoneyNotificationEnabled:
          isWithdrawMoneyNotificationEnabled ?? this.isWithdrawMoneyNotificationEnabled,
    );
  }

  @override
  bool operator ==(covariant NotificationPreferenceModel other) {
    if (identical(this, other)) return true;

    return other.isSellTicketNotificationEnabled == isSellTicketNotificationEnabled &&
        other.isMessageNotificationEnabled == isMessageNotificationEnabled &&
        other.isPublishEventNotificationEnabled == isPublishEventNotificationEnabled &&
        other.isWithdrawMoneyNotificationEnabled == isWithdrawMoneyNotificationEnabled;
  }

  @override
  int get hashCode {
    return isSellTicketNotificationEnabled.hashCode ^
        isMessageNotificationEnabled.hashCode ^
        isPublishEventNotificationEnabled.hashCode ^
        isWithdrawMoneyNotificationEnabled.hashCode;
  }
}
