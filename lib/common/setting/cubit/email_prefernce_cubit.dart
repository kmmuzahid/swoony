import 'package:swoony/common/auth/cubit/auth_cubit.dart';
import 'package:swoony/common/auth/model/profile_model.dart';
import 'package:swoony/core/config/bloc/safe_cubit.dart';

import 'email_preference_state.dart';

class EmailPreferenceCubit extends SafeCubit<EmailPreferenceState> {
  EmailPreferenceCubit(this.authCubit) : super(const EmailPreferenceState());
  final AuthCubit authCubit;

  Future<void> init() async {
    emit(
      state.copyWith(notificationPreference: authCubit.state.profileModel?.notificationPreference),
    );
  }

  void onSelectionChange(NotificationPreferenceModel notificationPreference) {
    emit(state.copyWith(notificationPreference: notificationPreference));
  }

  Future<void> updateEmailPreference() async {
    final ProfileModel? profile = authCubit.state.profileModel;
    if (profile == null) return;
    emit(state.copyWith(isSaving: true)); 
    await authCubit.updateProfile(
      profileModel: profile.copyWith(notificationPreference: state.notificationPreference),
    );
    emit(state.copyWith(isSaving: false));
  }
}
