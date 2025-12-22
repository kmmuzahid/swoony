import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/core/app_bar/common_app_bar.dart';
import 'package:swoony/core/component/button/common_button.dart';
import 'package:swoony/core/component/common_bar/common_tab_bar.dart';
import 'package:swoony/core/component/image/common_image.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/component/text_field/common_date_input_text_field.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/extensions/extension.dart';
import 'package:swoony/core/component/text_field/common_text_field.dart';
import 'package:swoony/core/component/text_field/custom_form.dart';
import 'package:swoony/core/component/text_field/input_helper.dart';
import 'package:swoony/gen/assets.gen.dart';

@RoutePage()
class ProfileInfoScreen extends StatelessWidget {
  const ProfileInfoScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: CommonAppBar(title: AppString.profileInfo),

    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: BoxBorder.all(width: 8, color: AppColors.secondaryColor),
                shape: BoxShape.circle,
              ),
              child: CommonImage(
                imageSrc: Assets.sample.sample1,
                borderRadius: 130,
                width: 130,
                height: 130,
              ).center,
            ),
            10.height,
            Text('Cameron Williamson', style: getTheme.textTheme.bodyLarge),
            10.height,
            CommonTabBar(
              tabs: [AppString.editProfile, AppString.changePassword],
              tabViews: [_profileChange(), _changePassowrd()],
            ),
          ],
        ),
      ),
    ),
  );

  Widget _changePassowrd() => CustomForm(
    builder: (_, formKey) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        30.height,

        /// current Password section
        CommonText(text: AppString.currentPassword, bottom: 8),
        CommonTextField(
          hintText: AppString.currentPassword,
          validationType: ValidationType.validatePassword,
          prefixIcon: Icon(Icons.lock, size: 20.sp),
        ),

        /// New Password section
        CommonText(text: AppString.newPassword, bottom: 8, top: 16),
        CommonTextField(
          hintText: AppString.newPassword,
          validationType: ValidationType.validatePassword,
          prefixIcon: Icon(Icons.lock, size: 20.sp),
        ),

        /// confirm Password section
        CommonText(text: AppString.confirmPassword, bottom: 8, top: 16),
        CommonTextField(
          hintText: AppString.confirmPassword,
          validationType: ValidationType.validateConfirmPassword,
          originalPassword: () => '',
          prefixIcon: Icon(Icons.lock, size: 20.sp),
        ),
        20.height,

        /// submit Button
        CommonButton(
          titleText: AppString.save,
          buttonWidth: 172,
          onTap: () {
            if (formKey.currentState?.validate() == true) {
              formKey.currentState?.save();
            }
          },
        ).center,
      ],
    ),
  );

  Widget _profileChange() => CustomForm(
    builder: (_, formKey) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        30.height,

        /// current Password section
        CommonText(text: AppString.fullName, bottom: 8),
        CommonTextField(
          hintText: AppString.fullName,
          validationType: ValidationType.validateFullName,
          prefixIcon: Icon(Icons.person, size: 20.sp),
        ),

        /// New Password section
        CommonText(text: AppString.phoneNumber, bottom: 8, top: 16),
        CommonTextField(
          hintText: AppString.phoneNumber,
          validationType: ValidationType.validatePhone,
          prefixIcon: Icon(Icons.phone, size: 20.sp),
        ),

        /// confirm Password section
        CommonText(text: AppString.dateOfBirth, bottom: 8, top: 16),
        CommonDateInputTextField(onSave: (date) {}),
        20.height,

        CommonButton(
          titleText: AppString.save,
          buttonWidth: 172,
          onTap: () {
            if (formKey.currentState?.validate() == true) {
              formKey.currentState?.save();
            }
          },
        ).center,
      ],
    ),
  );
}
