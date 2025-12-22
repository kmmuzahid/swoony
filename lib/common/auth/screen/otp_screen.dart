import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/common/auth/cubit/otp_cubit.dart';
import 'package:swoony/common/auth/cubit/otp_state.dart';
import 'package:swoony/common/auth/widgets/already_accunt_rich_text.dart';
import 'package:swoony/common/auth/widgets/common_logo.dart';
import 'package:swoony/common/auth/widgets/otp_send_widget.dart';
import 'package:swoony/common/auth/widgets/otp_verify_widget.dart';
import 'package:swoony/core/app_bar/common_app_bar.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/constants/app_text_styles.dart';
import 'package:swoony/core/utils/extensions/extension.dart';

@RoutePage()
class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});
 

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: CommonAppBar(backgroundColor: AppColors.backgroundWhite),
    backgroundColor: AppColors.backgroundWhite,
    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: BlocProvider(
        create: (context) => OtpCubit(),
        child: BlocBuilder<OtpCubit, OtpState>(
          builder: (context, state) {
            return Column(
              children: [
                const CommonLogo().center,
                CommonText(
                  text: AppString.appName,
                  style: getTheme.textTheme.headlineSmall?.copyWith(color: AppColors.primaryColor),
                ),
                CommonText(
                  text: AppString.buySellKeepFavoriteTickets,
                  style: getTheme.textTheme.bodyLarge?.copyWith(fontStyle: FontStyle.italic),
                  alignment: MainAxisAlignment.center,
                ),
                30.height,
                CommonText(
                  text: AppString.forgotThePassword.replaceFirst('?', ''),
                  style: AppTextStyles.titleLarge,
                  alignment: MainAxisAlignment.center,
                ).start,
                5.height,
                const OtpSend(),
                80.height

                // AnimatedCrossFade(
                //   firstChild: const OtpSend(),
                //   secondChild: OtpVerifyWidget(onSuccess: onSuccess, state: state),
                //   crossFadeState: state.verificationId.isNotEmpty || state.isLoading
                //       ? CrossFadeState.showSecond
                //       : CrossFadeState.showFirst,
                //   duration: const Duration(milliseconds: 300), // Increase the duration
                // ),
              ],
            );
          },
        ),
      ),
    ),
  );
}
