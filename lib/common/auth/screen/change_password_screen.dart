import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/common/auth/cubit/auth_cubit.dart';
import 'package:swoony/core/app_bar/common_app_bar.dart';
import 'package:swoony/core/component/button/common_button.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/component/text_field/common_text_field.dart';
import 'package:swoony/core/component/text_field/custom_form.dart';
import 'package:swoony/core/component/text_field/input_helper.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/constants/app_text_styles.dart';
import 'package:swoony/core/utils/extensions/extension.dart';

@RoutePage()
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late AuthCubit authCubit;
  String oldPassword = '';
  String newPassword = '';
  @override
  void initState() {
    authCubit = context.read<AuthCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthCubit>().state;
    return Scaffold(
      appBar: const CommonAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: CustomForm(
          builder: (context, formKey) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: AppString.changePassword,
                fontSize: 24,
                fontWeight: FontWeight.w600,

                style: AppTextStyles.titleMedium?.copyWith(color: AppColors.primaryColor),
              ),
              10.height,
              CommonTextField(
                prefixIcon: _requiredIcon(),
                borderColor: AppColors.disable,
                backgroundColor: AppColors.white400,
                validationType: ValidationType.validatePassword,
                hintText: AppString.oldPassword,
                onChanged: (value) {
                  oldPassword = value;
                },
              ),
              10.height,
              CommonTextField(
                prefixIcon: _requiredIcon(),
                borderColor: AppColors.disable,
                backgroundColor: AppColors.white400,
                validationType: ValidationType.validatePassword,
                hintText: AppString.newPassword,
                onChanged: (value) {
                  newPassword = value;
                },
              ),
              20.height,
              CommonButton(
                titleText: AppString.submit,
                isLoading: state.isLoading,
                onTap: () {
                  formKey.currentState?.save();
                  if (formKey.currentState?.validate() == true) {
                    authCubit.changePassword(newPassword: newPassword, oldPassword: oldPassword);
                  }
                },
              ).center,
            ],
          ),
        ),
      ),
    );
  }

  Widget _requiredIcon() =>
      const CommonText(text: '*', textColor: AppColors.warning, fontSize: 20, top: 10);
}
