import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/common/auth/cubit/auth_cubit.dart';
import 'package:swoony/core/app_bar/common_app_bar.dart';
import 'package:swoony/core/component/button/common_button.dart';
import 'package:swoony/core/component/mainlad/common_switch.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/constants/app_text_styles.dart';
import 'package:swoony/core/utils/extensions/extension.dart';

import '../cubit/email_preference_state.dart';
import '../cubit/email_prefernce_cubit.dart';

@RoutePage()
class EmailPreferenceScreen extends StatelessWidget {
  const EmailPreferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: BlocProvider<EmailPreferenceCubit>(
          create: (context) {
            final AuthCubit authCubit = context.read<AuthCubit>();
            return EmailPreferenceCubit(authCubit)..init();
          },
          child: BlocBuilder<EmailPreferenceCubit, EmailPreferenceState>(
            builder: (context, state) {
              final cubit = context.read<EmailPreferenceCubit>();
              return Column(
                children: [
                  CommonText(
                    text: AppString.emailPreferences,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    style: AppTextStyles.titleMedium?.copyWith(color: AppColors.primaryColor),
                  ).start,
                  10.height,
                  CommonText(
                    text: '${AppString.receiveEmailNotificationsFor}:',
                    fontSize: 16,
                    textColor: AppColors.greay400,
                    fontWeight: FontWeight.w400,
                  ).start,
                  _itemBuilder(
                    title: AppString.whenYouSellYourTicket,
                    isActive: state.notificationPreference.isSellTicketNotificationEnabled ?? false,
                    onChanged: (value) {
                      cubit.onSelectionChange(
                        state.notificationPreference.copyWith(
                          isSellTicketNotificationEnabled: value,
                        ),
                      );
                    },
                  ),
                  _itemBuilder(
                    title: AppString.whenYouReceiveAMessage,
                    isActive: state.notificationPreference.isMessageNotificationEnabled ?? false,
                    onChanged: (value) {
                      cubit.onSelectionChange(
                        state.notificationPreference.copyWith(isMessageNotificationEnabled: value),
                      );
                    },
                  ),
                  _itemBuilder(
                    title: AppString.whenAFavoritePublishAnEvent,
                    isActive:
                        state.notificationPreference.isPublishEventNotificationEnabled ?? false,
                    onChanged: (value) {
                      cubit.onSelectionChange(
                        state.notificationPreference.copyWith(
                          isPublishEventNotificationEnabled: value,
                        ),
                      );
                    },
                  ),
                  _itemBuilder(
                    title: AppString.whenYouCanWithdrawFromYourWallet,
                    isActive:
                        state.notificationPreference.isWithdrawMoneyNotificationEnabled ?? false,
                    onChanged: (value) {
                      cubit.onSelectionChange(
                        state.notificationPreference.copyWith(
                          isWithdrawMoneyNotificationEnabled: value,
                        ),
                      );
                    },
                  ),
                  20.height,
                  CommonButton(
                    isLoading: state.isSaving,
                    titleText: AppString.save,
                    onTap: cubit.updateEmailPreference,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _itemBuilder({
    required String title,
    required bool isActive,
    required Function(bool value) onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CommonText(
            text: title,
            fontSize: 16,
            maxLines: 1,
            overflow: TextOverflow.fade,
            textColor: AppColors.greay400,
            fontWeight: FontWeight.w400,
          ),
        ),
        20.width,

        CommonSwitch(isActive: isActive, onChanged: onChanged),
      ],
    );
  }
}
