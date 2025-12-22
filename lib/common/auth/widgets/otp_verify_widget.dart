import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swoony/core/component/text_field/custom_form.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:swoony/common/auth/cubit/otp_cubit.dart';
import 'package:swoony/common/auth/cubit/otp_state.dart';
import 'package:swoony/core/component/button/common_button.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/component/text_field/input_helper.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/constants/app_text_styles.dart';
import 'package:swoony/core/utils/extensions/extension.dart';

class OtpVerifyWidget extends StatefulWidget {
  const OtpVerifyWidget({required this.onSuccess, required this.email, super.key});
  final Function(String verificationToken) onSuccess;
  final String email;

  @override
  State<OtpVerifyWidget> createState() => _OtpVerifyWidgetState();
}

class _OtpVerifyWidgetState extends State<OtpVerifyWidget> {
  late TextEditingController controller;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(_) => CustomForm(
    builder: (context, formKey) {
      return BlocProvider(
        create: (context) => OtpCubit()..sendOtp(widget.email),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: appRouter.pop,
              icon: Icon(Icons.close, size: 20.w),
            ).end,
            CommonText(
              text: AppString.enterVerifyCode,
              style: AppTextStyles.titleLarge,
              bottom: 10.w,
            ).start,
            _otpBuilder(context),
            20.height,
            CommonText(text: AppString.codeHasBeenSentTo, style: AppTextStyles.bodySmall),
            BlocSelector<OtpCubit, OtpState, int>(
              selector: (otpState) => otpState.count,
              builder: (context, state) => _resendOtpTimerBuilder(
                state,
                widget.email,
                () => context.read<OtpCubit>().sendOtp(widget.email),
              ),
            ).end,
            20.height,
            BlocSelector<OtpCubit, OtpState, bool>(
              selector: (otpState) => otpState.isLoading,
              builder: (context, state) => CommonButton(
                titleText: AppString.confim,
                isLoading: state,
                buttonRadius: 12.w,
                buttonWidth: 100, 
                onTap: () {
                  if (formKey.currentState?.validate() == true) {
                  context.read<OtpCubit>().verifyOtp(
                    otp: controller.text,
                    email: widget.email,
                      onSuccess: widget.onSuccess,
                  );
                  }
                },
              ),
            ),
            20.height,
          ],
        ),
      );
    }
  );

  Widget _resendOtpTimerBuilder(int count, String username, Function onResend) {
    return count == 0
        ? _resendMessageBuilder(username, onResend)
        : CommonText(
            alignment: MainAxisAlignment.end,
            text: '${AppString.resendCodeIn} $count ${AppString.seconds}',
            style: TextStyle(fontWeight: FontWeight.bold, color: getTheme.colorScheme.primary),
          );
  }

  Widget _resendMessageBuilder(String username, Function onResend) => Align(
    alignment: Alignment.centerRight,
    child: Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: AppString.didntReciveCode,
            style: GoogleFonts.dmSans(
              color: getTheme.textTheme.bodySmall?.color,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),

          /// Sign Up Button here
          TextSpan(
            text: ' ${AppString.resendCode}',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                onResend();
              },
            style: GoogleFonts.lato(
              color: getTheme.colorScheme.primary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    ),
  );

  Flexible _otpBuilder(BuildContext context) {
    return Flexible(
      flex: 0,
      child: PinCodeTextField(
       
        controller: controller,
        autoDisposeControllers: false,
        
        cursorColor: getTheme.textSelectionTheme.cursorColor,
        textStyle: getTheme.textTheme.bodyMedium?.copyWith(
          fontSize: 25,
          color: AppColors.primaryColor,
        ),
        appContext: (context),
        autoFocus: true,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(04),
          fieldHeight: 40.w,
          fieldWidth: 40.w,
          
          activeFillColor: AppColors.disable,
          selectedFillColor: AppColors.disable,
          inactiveFillColor: AppColors.disable,
          borderWidth: 0.1.w,
          selectedColor: getTheme.primaryColor.withAlpha(80),
          activeColor: getTheme.primaryColor.withAlpha(80),
          inactiveColor: getTheme.primaryColor.withAlpha(80),
        ),
        length: 6,
        keyboardType: InputHelper.getKeyboardType(ValidationType.validateOTP),
        inputFormatters: InputHelper.getInputFormatters(ValidationType.validateOTP),
        autovalidateMode: AutovalidateMode.disabled,
        enableActiveFill: true,
        validator: (value) => InputHelper.validate(ValidationType.validateOTP, value),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
