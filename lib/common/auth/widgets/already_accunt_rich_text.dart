import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/config/route/app_router.gr.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/constants/app_text_styles.dart';
import 'package:swoony/core/utils/extensions/extension.dart';

class AlreadyAccountRichText extends StatelessWidget {
  const AlreadyAccountRichText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: AppString.alreadyHaveAccount,

            style: TextStyle(fontSize: 16.sp, color: AppColors.outlineColor),
          ),

          /// Sign Up Button here
          TextSpan(
            text: ' ${AppString.signIn}',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                appRouter.replace(
                  SignInRoute(
                    ctrUsername: TextEditingController(),
                    ctrPassword: TextEditingController(),
                  ),
                );
              },
            style: AppTextStyles.titleMedium?.copyWith(color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
