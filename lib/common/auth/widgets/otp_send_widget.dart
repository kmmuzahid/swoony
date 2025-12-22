import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swoony/common/auth/cubit/otp_cubit.dart';
import 'package:swoony/common/auth/cubit/otp_state.dart';
import 'package:swoony/common/auth/widgets/otp_verify_widget.dart';
import 'package:swoony/core/component/button/common_button.dart';
import 'package:swoony/core/component/other_widgets/common_dialog.dart';
import 'package:swoony/core/component/text_field/common_text_field.dart';
import 'package:swoony/core/component/text_field/input_helper.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/config/route/app_router.gr.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/extensions/extension.dart';

class OtpSend extends StatefulWidget {
  const OtpSend({super.key});

  @override
  State<OtpSend> createState() => _OtpSendState();
}

class _OtpSendState extends State<OtpSend> {
  late TextEditingController controller;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
    controller = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: BlocBuilder<OtpCubit, OtpState>(
          builder: (context, state) {
            return Column(
              children: [
                CommonTextField(
                  controller: controller,
                  backgroundColor: AppColors.disable,
                  borderColor: AppColors.disable,
                  hintText: AppString.emailAddress,
                  validationType: ValidationType.validateEmail,
                ),
                25.height,
                CommonButton(
                  titleText: AppString.otpSendButton,
                  isLoading: false,
                  buttonWidth: 100,
                  onTap: () {
                    if (formKey.currentState?.validate() == true) {
                      commonDialog(
                      context: context,
                      child: OtpVerifyWidget(
                        email: controller.text,
                          onSuccess: (verificationToken) {
                          appRouter.pop();
                          appRouter.push(
                              ForgetPasswordRoute(
                                newPasswordController: TextEditingController(),
                                verificationToken: verificationToken,
                              ),
                          );
                        },
                      ),
                    );
                    }
                    
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    try {
      controller.dispose();
    } catch (e) {}
    super.dispose();
  }
}
