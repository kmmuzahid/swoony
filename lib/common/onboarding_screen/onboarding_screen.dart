import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/common/onboarding_screen/widgets/onboarding_template_widget.dart';
import 'package:swoony/core/component/button/common_button.dart';
import 'package:swoony/core/component/image/common_image.dart';

import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/config/route/app_router.gr.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/extensions/extension.dart';
import 'package:swoony/gen/assets.gen.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class OnBoardingDataModel {
  String title;
  String subTitle;

  OnBoardingDataModel({required this.title, required this.subTitle});
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  int selectedIndex = 0;
  List<OnBoardingDataModel> onBoardingDataList = [
    OnBoardingDataModel(
      title: "Connect Through Events",
      subTitle:
          "Join or create events effortlessly and meet the people who matter - right where the moments happen.",
    ),
    OnBoardingDataModel(
      title: "Access Made Simple",
      subTitle:
          "Use QR codes or access codes to enter events quickly, securely, and without any hassle.",
    ),
    OnBoardingDataModel(
      title: "Personalize Your Experience",
      subTitle:
          "Build your profile, manage your events, and customize how you connect - all in one seamless platform.",
    ),
  ];

  void onTapNext() {
    if (selectedIndex < onBoardingDataList.length - 1) {
      selectedIndex++;
      setState(() {});
    } else {
      onTapSkip();
    }
  }

  void onTapSkip() {
    appRouter.replaceAll([
      SignInRoute(ctrPassword: TextEditingController(), ctrUsername: TextEditingController()),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final curvePosition = screenHeight * 0.45; // This matches the curveHeightRatio in template

    return PageView(
      controller: pageController,
      onPageChanged: (value) {
        selectedIndex = value;
        setState(() {});
      },
      children: [_getPage(curvePosition), _getPage(curvePosition), _getPage(curvePosition)],
    );
  }

  GradientCurveContainer _getPage(double curvePosition) {
    return GradientCurveContainer(
      imageAsset: Assets.images.onboard1.path,
      gradientColors: const [Color(0xffFF1A60), Color(0xffFF6B60)],
      child: Stack(
        children: [
          // Logo and Glass Card - positioned in the upper image area
          Positioned(
            top: 60.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
                CommonImage(imageSrc: Assets.images.appIcon, size: 80),
                30.height,

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        height: 200.h,
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(100),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white.withAlpha(20), width: 1.5),
                        ),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CommonText(
                                  textAlign: TextAlign.center,
                                  textColor: AppColors.white50,
                                  text: onBoardingDataList[selectedIndex].title,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24,
                                ),
                                10.height,
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                                  child: CommonText(
                                    textColor: AppColors.white50,
                                    textAlign: TextAlign.center,
                                    text: onBoardingDataList[selectedIndex].subTitle,
                                    maxLines: 5,
                                    preventScaling: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Page Indicator - positioned right on top of the curve
          Positioned(
            top: curvePosition + 50.h, // Positioned slightly above the curve start
            left: 0,
            right: 0,
            child: Container(
              height: 20.h,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  onBoardingDataList.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: selectedIndex == index ? 24.w : 8.w,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(selectedIndex == index ? 4 : 24),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Buttons - positioned in the gradient area below the curve
          Positioned(
            top: curvePosition + 180.h, // Positioned slightly above the curve start
            left: 0,
            right: 0,
            child: selectedIndex == 0
                ? Center(
                    child: CommonButton(
                      onTap: onTapNext,
                      titleColor: AppColors.primaryColor,
                      titleText: 'Next',
                      buttonWidth: 100,
                      buttonColor: AppColors.backgroundWhite,
                      buttonRadius: 8,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonButton(
                          buttonWidth: 100,
                          borderColor: AppColors.backgroundWhite,
                          onTap: onTapSkip,
                          titleColor: AppColors.white50,
                          titleText: 'Skip',
                          buttonRadius: 8,
                          buttonColor: AppColors.transparent,
                        ),
                        12.width,
                        CommonButton(
                          buttonWidth: 100,
                          buttonColor: AppColors.backgroundWhite,
                          onTap: onTapNext,
                          titleText: 'Next',
                          titleColor: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
