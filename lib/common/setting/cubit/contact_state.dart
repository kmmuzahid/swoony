// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:swoony/common/tickets/model/ticket_model.dart';

class ContactState {
  const ContactState({this.isSening = false});

  final bool isSening;

  ContactState copyWith({bool? isSening}) {
    return ContactState(isSening: isSening ?? this.isSening);
  }

  @override
  bool operator ==(covariant ContactState other) {
    if (identical(this, other)) return true;

    return other.isSening == isSening;
  }

  @override
  int get hashCode => isSening.hashCode;
}
