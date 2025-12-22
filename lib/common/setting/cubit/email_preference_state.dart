// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:swoony/common/auth/model/profile_model.dart';

class EmailPreferenceState {
  final bool isSaving;
  final NotificationPreferenceModel notificationPreference;
  const EmailPreferenceState({
    this.isSaving = false,
    this.notificationPreference = const NotificationPreferenceModel(
      isSellTicketNotificationEnabled: false,
      isMessageNotificationEnabled: false,
      isPublishEventNotificationEnabled: false,
      isWithdrawMoneyNotificationEnabled: false,
    ),
  });

  EmailPreferenceState copyWith({
    bool? isSaving,
    NotificationPreferenceModel? notificationPreference,
  }) {
    return EmailPreferenceState(
      isSaving: isSaving ?? this.isSaving,
      notificationPreference: notificationPreference ?? this.notificationPreference,
    );
  }

  @override
  bool operator ==(covariant EmailPreferenceState other) {
    if (identical(this, other)) return true;

    return other.isSaving == isSaving && other.notificationPreference == notificationPreference;
  }

  @override
  int get hashCode => isSaving.hashCode ^ notificationPreference.hashCode;
}
