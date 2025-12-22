// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:swoony/common/setting/model/faq_model.dart';

class FaqState {
  const FaqState({this.isLoading = false, this.faq = const [], this.page = 1});

  final bool isLoading;
  final List<FaqModel> faq;
  final int page;

  FaqState copyWith({bool? isLoading, List<FaqModel>? faq, int? page}) {
    return FaqState(
      isLoading: isLoading ?? this.isLoading,
      faq: faq ?? this.faq,
      page: page ?? this.page,
    );
  }

  @override
  bool operator ==(covariant FaqState other) {
    if (identical(this, other)) return true;

    return other.isLoading == isLoading && listEquals(other.faq, faq) && other.page == page;
  }

  @override
  int get hashCode => isLoading.hashCode ^ faq.hashCode ^ page.hashCode;
}
