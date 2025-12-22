import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/common/auth/cubit/auth_cubit.dart';
import 'package:swoony/common/auth/model/user_login_info_model.dart';
import 'package:swoony/common/auth/widgets/common_logo.dart';
import 'package:swoony/common/onboarding_screen/widgets/onboarding_template_widget.dart';
import 'package:swoony/core/app_bar/common_app_bar.dart';
import 'package:swoony/core/component/button/common_button.dart';
import 'package:swoony/core/component/button/common_radio_group.dart';
import 'package:swoony/core/component/other_widgets/common_wavy_gradient_container.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/component/text_field/common_text_field.dart';
import 'package:swoony/core/component/text_field/custom_form.dart';
import 'package:swoony/core/component/text_field/input_helper.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/config/route/app_router.gr.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/constants/app_text_styles.dart';
import 'package:swoony/core/utils/extensions/extension.dart';
import 'package:swoony/gen/assets.gen.dart';
import '../widgets/do_not_have_account_widget.dart';

@RoutePage()
class SignInScreen extends StatelessWidget {
  const SignInScreen({required this.ctrUsername, required this.ctrPassword, super.key});

  final TextEditingController ctrUsername;
  final TextEditingController ctrPassword;

  @override
  Widget build(BuildContext context) {
    final colorA = Color(0xFFFF947D).withOpacity(.5);
    final colorB = Color(0xFFFF1A60).withOpacity(.5);
    return Scaffold(
      /// App Bar Sections Starts here
      appBar: CommonAppBar(
        backgroundColor: AppColors.backgroundWhite,
        disableBack: true,
        hideBack: true,
      ),
      backgroundColor: AppColors.backgroundWhite,

      /// Body Sections Starts here
      body: Column(
        children: [
          CommonLogo().center,
          20.height,
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  child: GradientCurveContainer(
                    curveHeightRatio: .4,
                    gradientColors: [colorA, colorB],
                    child: Container(),
                  ),
                ),

                Positioned(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundWhite,
                      border: BoxBorder.all(color: AppColors.cta),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: _content(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _content() => SingleChildScrollView(
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    child: CustomForm(
      builder: (BuildContext context, GlobalKey<FormState> formKey) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Log In Instruction here
          40.height,
          CommonText(
            text: AppString.letsSignYouIn,
            style: AppTextStyles.headlineLarge?.copyWith(color: AppColors.primaryColor),
          ),
          CommonText(
            textAlign: TextAlign.start,
            text: '${AppString.welcomeBack}\n${AppString.youHaveBeenMissed}',
            maxLines: 2,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          20.height,
          CommonText(
            text: AppString.pleaseSelectARoleBeforeContinuing,
            style: getTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.secondaryText,
            ),
          ),
          15.height,
          CommonRadioGroup(
            options: {'attendee': AppString.attendee, 'organizer': AppString.organizer},
            onChanged: (value) {
              context.read<AuthCubit>().onChangeUserRole(
                value == 'organizer' ? Role.ORGANIZER : Role.ATTENDEE,
              );
            },
            initialKey: 'attendee',
            iconSize: 25.w,
            textStyle: AppTextStyles.headlineSmall,
          ),
          20.height,

          CommonTextField(
            backgroundColor: AppColors.disable,
            borderColor: AppColors.disable,
            hintText: AppString.emailAddress,
            validationType: ValidationType.validateEmail,
            controller: ctrUsername,
          ),
          10.height,
          CommonTextField(
            backgroundColor: AppColors.disable,
            borderColor: AppColors.disable,
            hintText: AppString.password,
            validationType: ValidationType.validatePassword,
            controller: ctrPassword,
          ),
                      
          /// Forget Password Button here
          GestureDetector(
            onTap: () {
              appRouter.push(const OtpRoute());
            },
            child: CommonText(
              text: AppString.forgotThePassword,
              style: AppTextStyles.titleMedium?.copyWith(color: AppColors.primaryColor),
              top: 10,
              bottom: 30,
            ),
          ).end,

          /// Submit Button here
          Align(
            child: CommonButton(
              titleText: AppString.signIn,
              onTap: () {
                // if (formKey.currentState?.validate() == true) {
                //   formKey.currentState?.save();
                // }
                context.read<AuthCubit>().signIn(ctrUsername.text, ctrPassword.text);
              },
              buttonWidth: 100,
              isLoading: false,
            ),
          ),
          24.height,

          /// Account Creating Instruction here
          const Align(alignment: Alignment.bottomCenter, child: DoNotHaveAccount()),
          30.height,
        ],
      ),
    ),
  );
}
