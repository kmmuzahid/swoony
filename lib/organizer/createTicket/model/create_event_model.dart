// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:swoony/core/utils/app_utils.dart';
import 'package:swoony/core/utils/extensions/extension.dart';

enum TicketName { Premium, VIP, Standard, Other }

class DiscountCodeModel {
  final String code;
  final int discountPercentage; // e.g., 10 for 10%
  final bool isActive;
  final int? filedId;
  final DateTime? expireDate;

  DiscountCodeModel({
    required this.code,
    required this.discountPercentage,
    this.isActive = true,
    this.filedId,
    this.expireDate,
  });

  // Empty Initializer
  static DiscountCodeModel empty() {
    return DiscountCodeModel(
      code: '',
      expireDate: DateTime.now(),
      discountPercentage: 0,
      isActive: true,
      filedId: 1,
    );
  }

  // Factory constructor for creating an instance from a JSON map
  factory DiscountCodeModel.fromJson(Map<String, dynamic> json) {
    return DiscountCodeModel(
      code: json['code'] as String? ?? '',
      discountPercentage: json['discountPercentage'] as int? ?? 0,
      isActive: json['isActive'] as bool? ?? true,
      filedId: 1,
      expireDate: json['expireDate'] != null ? DateTime.parse(json['expireDate'] as String) : null,
    );
  }

  // Method to convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'discountPercentage': discountPercentage,
      'isActive': isActive,
      'filedId': filedId,
      'expireDate': expireDate?.toIso8601String(),
    };
  }

  DiscountCodeModel copyWith({
    String? code,
    int? discountPercentage,
    bool? isActive,
    int? filedId,
    DateTime? expireDate,
  }) {
    return DiscountCodeModel(
      code: code ?? this.code,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      isActive: isActive ?? this.isActive,
      filedId: filedId ?? this.filedId,
      expireDate: expireDate ?? this.expireDate,
    );
  }
}

class TicketTypeModel {
  final TicketName? name;
  final double setUnitPrice;
  final int availableUnit;

  TicketTypeModel({required this.name, required this.setUnitPrice, required this.availableUnit});

  // Empty Initializer - all dates null
  static TicketTypeModel empty() {
    return TicketTypeModel(name: null, setUnitPrice: 0.0, availableUnit: 0);
  }

  // Factory constructor for JSON with safe defaults
  factory TicketTypeModel.fromJson(Map<String, dynamic> json) {
    return TicketTypeModel(
      name: json['name'] != null
          ? TicketName.values.firstWhere(
              (e) => e.toString().split('.').last == json['name'],
              orElse: () => TicketName.Standard,
            )
          : TicketName.Standard,
      setUnitPrice: (json['setUnitPrice'] as num?)?.toDouble() ?? 0.0,
      availableUnit: json['availableUnit'] as int? ?? 0,
      // saleStartDate: json['saleStartDate'] != null
      //     ? DateTime.tryParse(json['saleStartDate'] as String)
      //     : null,
      // saleEndDate: json['saleEndDate'] != null
      //     ? DateTime.tryParse(json['saleEndDate'] as String)
      //     : null,
    );
  }

  // Method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name.toString().split('.').last,
      'setUnitPrice': setUnitPrice,
      'availableUnit': availableUnit,
      // 'saleStartDate': saleStartDate?.toIso8601String(),
      // 'saleEndDate': saleEndDate?.toIso8601String(),
    };
  }

  TicketTypeModel copyWith({
    TicketName? name,
    double? setUnitPrice,
    int? availableUnit,
    DateTime? saleStartDate,
    DateTime? saleEndDate,
  }) {
    return TicketTypeModel(
      name: name ?? this.name,
      setUnitPrice: setUnitPrice ?? this.setUnitPrice,
      availableUnit: availableUnit ?? this.availableUnit,
      // saleStartDate: saleStartDate ?? this.saleStartDate,
      // saleEndDate: saleEndDate ?? this.saleEndDate,
    );
  }
}

class CreateEventModel {
  final String? image;
  // Event Details
  final String? draftId;
  final String? title;
  final List<String> category;
  final String? description;
  final DateTime? eventDate;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final String? streetAddress1;
  final String? streetAddress2;
  final String? city;
  final String? state;
  final String? country;

  // Tickets Details
  final List<TicketTypeModel> ticketTypes;
  final bool isFreeEvent;

  // Pre-Sale Details
  final bool offerPreSale;
  final DateTime? preSaleStartDate;
  final DateTime? preSaleEndDate;
  final DateTime? ticketSaleStartDate;

  // Discount Codes
  final List<DiscountCodeModel> discountCodes;

  // Event Organizer Details
  final String? organizerName;
  final String? emailAddress;
  final String? phoneNumber;
  final bool offerDiscountByCode;

  CreateEventModel({
    this.image,
    required this.title,
    required this.category,
    this.description,
    this.eventDate,
    required this.startTime,
    required this.endTime,
    required this.streetAddress1,
    this.streetAddress2,
    required this.city,
    required this.state,
    required this.country,
    required this.ticketTypes,
    this.offerPreSale = true,
    this.preSaleStartDate,
    this.preSaleEndDate,
    this.ticketSaleStartDate,
    required this.discountCodes,
    required this.organizerName,
    required this.emailAddress,
    required this.phoneNumber,
    this.isFreeEvent = false,
    this.offerDiscountByCode = true,
    this.draftId,
  });

  // Empty Initializer - all dates null
  static CreateEventModel empty() {
    return CreateEventModel(
      title: '',
      category: [],
      description: '',
      eventDate: null,
      startTime: TimeOfDay.now(),
      endTime: TimeOfDay.now().replacing(hour: TimeOfDay.now().hour + 1),
      streetAddress1: '',
      streetAddress2: '',
      city: '',
      state: '',
      country: '',
      image: null,
      ticketTypes: [],
      offerPreSale: true,
      preSaleStartDate: null,
      preSaleEndDate: null,
      ticketSaleStartDate: null,
      discountCodes: [],
      organizerName: '',
      emailAddress: '',
      phoneNumber: '',
      isFreeEvent: false,
      offerDiscountByCode: true,
    );
  }

  // Factory constructor with safe defaults for all fields
  factory CreateEventModel.fromJson(Map<String, dynamic> json) {
    return CreateEventModel(
      image: json['image'] ?? '',
      title: json['title'] as String? ?? '',
      ticketSaleStartDate: json['ticketSaleStartDate'] != null
          ? Utils.parseDate(json['ticketSaleStartDate'] as String)
          : null,
      category: json['category'] ?? [],
      description: json['description'] as String?,
      eventDate: json['eventDate'] != null ? Utils.parseDate(json['eventDate'] as String) : null,
      startTime: json['startTime'] != null
          ? (json['startTime'] as String).toTimeOfDay12()
          : TimeOfDay.now(),
      endTime: json['endTime'] != null
          ? (json['endTime'] as String).toTimeOfDay12()
          : TimeOfDay.now(),
      streetAddress1: json['streetAddress1'] as String? ?? '',
      streetAddress2: json['streetAddress2'] as String?,
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      country: json['country'] as String? ?? '',
      ticketTypes: json['ticketTypes'] != null
          ? (json['ticketTypes'] as List<dynamic>)
                .map((item) => TicketTypeModel.fromJson(item as Map<String, dynamic>))
                .toList()
          : [],
      offerPreSale: json['offerPreSale'] as bool? ?? false,
      preSaleStartDate: json['preSaleStartDate'] != null
          ? Utils.parseDate(json['preSaleStartDate'] as String)
          : null,
      preSaleEndDate: json['preSaleEndDate'] != null
          ? Utils.parseDate(json['preSaleEndDate'] as String)
          : null,
      discountCodes: json['discountCodes'] != null
          ? (json['discountCodes'] as List<dynamic>)
                .map((item) => DiscountCodeModel.fromJson(item as Map<String, dynamic>))
                .toList()
          : [],
      organizerName: json['organizerName'] as String? ?? '',
      emailAddress: json['emailAddress'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      isFreeEvent: json['isFreeEvent'] as bool? ?? false,
      offerDiscountByCode: json['offerDiscountByCode'] as bool? ?? false,
      draftId: json['draftId'] as String? ?? '',
    );
  }

  // Method to convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'category': category,
      'description': description,
      'eventDate': eventDate?.toIso8601String().split('T').first,
      'startTime': startTime,
      'endTime': endTime,
      'streetAddress1': streetAddress1,
      'streetAddress2': streetAddress2,
      'city': city,
      'state': state,
      'country': country,
      'ticketTypes': ticketTypes.map((t) => t.toJson()).toList(),
      'offerPreSale': offerPreSale,
      'preSaleStartDate': preSaleStartDate?.toIso8601String(),
      'preSaleEndDate': preSaleEndDate?.toIso8601String(),
      'discountCodes': discountCodes.map((d) => d.toJson()).toList(),
      'organizerName': organizerName,
      'emailAddress': emailAddress,
      'phoneNumber': phoneNumber,
      'isFreeEvent': isFreeEvent,
      'ticketSaleStartDate': ticketSaleStartDate?.toIso8601String(),
      'offerDiscountByCode': offerDiscountByCode,
      'draftId': draftId,
    };
  }

  CreateEventModel copyWith({
    String? title,
    List<String>? category,
    String? description,
    DateTime? eventDate,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    String? streetAddress1,
    String? streetAddress2,
    String? city,
    String? image,
    String? state,
    String? country,
    List<TicketTypeModel>? ticketTypes,
    bool? offerPreSale,
    DateTime? preSaleStartDate,
    DateTime? preSaleEndDate,
    List<DiscountCodeModel>? discountCodes,
    String? organizerName,
    String? emailAddress,
    String? phoneNumber,
    bool? offerDiscountByCode,
    bool? isFreeEvent,
    DateTime? ticketSaleStartDate,
    String? draftId,
  }) {
    return CreateEventModel(
      title: title ?? this.title,
      image: image ?? this.image,
      category: category ?? this.category,
      description: description ?? this.description,
      eventDate: eventDate ?? this.eventDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      streetAddress1: streetAddress1 ?? this.streetAddress1,
      streetAddress2: streetAddress2 ?? this.streetAddress2,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      ticketTypes: ticketTypes ?? this.ticketTypes,
      offerPreSale: offerPreSale ?? this.offerPreSale,
      preSaleStartDate: preSaleStartDate ?? this.preSaleStartDate,
      preSaleEndDate: preSaleEndDate ?? this.preSaleEndDate,
      discountCodes: discountCodes ?? this.discountCodes,
      organizerName: organizerName ?? this.organizerName,
      emailAddress: emailAddress ?? this.emailAddress,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isFreeEvent: isFreeEvent ?? this.isFreeEvent,
      ticketSaleStartDate: ticketSaleStartDate ?? this.ticketSaleStartDate,
      offerDiscountByCode: offerDiscountByCode ?? this.offerDiscountByCode,
      draftId: draftId ?? this.draftId,
    );
  }

  @override
  bool operator ==(covariant CreateEventModel other) {
    if (identical(this, other)) return true;

    return other.image == image &&
        other.draftId == draftId &&
        other.title == title &&
        listEquals(other.category, category) &&
        other.description == description &&
        other.eventDate == eventDate &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.streetAddress1 == streetAddress1 &&
        other.streetAddress2 == streetAddress2 &&
        other.city == city &&
        other.state == state &&
        other.country == country &&
        listEquals(other.ticketTypes, ticketTypes) &&
        other.isFreeEvent == isFreeEvent &&
        other.offerPreSale == offerPreSale &&
        other.preSaleStartDate == preSaleStartDate &&
        other.preSaleEndDate == preSaleEndDate &&
        other.ticketSaleStartDate == ticketSaleStartDate &&
        listEquals(other.discountCodes, discountCodes) &&
        other.organizerName == organizerName &&
        other.emailAddress == emailAddress &&
        other.phoneNumber == phoneNumber &&
        other.offerDiscountByCode == offerDiscountByCode;
  }

  @override
  int get hashCode {
    return image.hashCode ^
        draftId.hashCode ^
        title.hashCode ^
        category.hashCode ^
        description.hashCode ^
        eventDate.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        streetAddress1.hashCode ^
        streetAddress2.hashCode ^
        city.hashCode ^
        state.hashCode ^
        country.hashCode ^
        ticketTypes.hashCode ^
        isFreeEvent.hashCode ^
        offerPreSale.hashCode ^
        preSaleStartDate.hashCode ^
        preSaleEndDate.hashCode ^
        ticketSaleStartDate.hashCode ^
        discountCodes.hashCode ^
        organizerName.hashCode ^
        emailAddress.hashCode ^
        phoneNumber.hashCode ^
        offerDiscountByCode.hashCode;
  }
}
