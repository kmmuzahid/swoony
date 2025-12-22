import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/common/auth/widgets/common_logo.dart';
import 'package:swoony/core/component/button/common_button.dart';

import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/config/route/app_router.gr.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/extensions/extension.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          children: [
            const Spacer(),
            const CommonLogo(width: 208, height: 142).center,
            CommonText(
              text: AppString.appName,
              style: getTheme.textTheme.headlineLarge?.copyWith(color: AppColors.primaryColor),
            ).center,
            CommonText(
              text: AppString.buySellKeepFavoriteTickets,
              style: getTheme.textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
            ).center,
            50.height,
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonButton(
                  titleText: AppString.signIn,
                  buttonWidth: 100,
                  onTap: () {
                    appRouter.push(
                      SignInRoute(
                        ctrUsername: TextEditingController(),
                        ctrPassword: TextEditingController(),
                      ),
                    );
                  },
                ),
                28.width,
                CommonButton(
                  titleText: AppString.signUp,
                  buttonWidth: 100,
                  onTap: () {
                    appRouter.push(const SignUpRoute());
                  },
                ),
                100.height,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
