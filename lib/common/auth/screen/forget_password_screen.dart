import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/common/auth/cubit/auth_cubit.dart';

import 'package:swoony/common/auth/widgets/common_logo.dart';
import 'package:swoony/core/app_bar/common_app_bar.dart';
import 'package:swoony/core/component/button/common_button.dart';
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
import 'package:swoony/core/utils/log/app_log.dart';

@RoutePage()
class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({
    required this.newPasswordController,
    required this.verificationToken,
    super.key,
  });
  final TextEditingController newPasswordController;
  final String verificationToken;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.backgroundWhite,
    appBar: CommonAppBar(backgroundColor: AppColors.backgroundWhite),
    body: CustomForm(
      builder: (_, formKey) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommonLogo().center,
            CommonText(
              text: AppString.appName,
              style: getTheme.textTheme.headlineLarge?.copyWith(color: AppColors.primaryColor),
            ).center,
            30.height,
            CommonText(
              text: AppString.resetPassword,
              style: AppTextStyles.titleLarge,
              alignment: MainAxisAlignment.center,
            ).start,

            5.height,
            CommonTextField(
              hintText: AppString.newPassword,
              backgroundColor: AppColors.disable,
              borderColor: AppColors.disable,
              controller: newPasswordController,
              validationType: ValidationType.validatePassword,
            ),
            10.height,
            CommonTextField(
              backgroundColor: AppColors.disable,
              borderColor: AppColors.disable, 
              hintText: AppString.confirmPassword,
              validationType: ValidationType.validateConfirmPassword,
              originalPassword: () => newPasswordController.text,
            ),
            20.height,

            /// Submit Button here
            CommonButton(
              titleText: AppString.resetPassword,
              buttonWidth: 100,
              onTap: () { 
                
                if (formKey.currentState!.validate()) {
                  context.read<AuthCubit>().resetPassword(
                    verificationToken: verificationToken,
                    newPassword: newPasswordController.text,
                  );
                }
              },
              isLoading: false,
            ).center,

            const Spacer(),
          ],
        ),
      ),
    ),
  );
}
