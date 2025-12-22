// File: setting_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/common/auth/cubit/auth_cubit.dart';
import 'package:swoony/common/auth/cubit/auth_state.dart';
import 'package:swoony/common/auth/model/profile_model.dart';
import 'package:swoony/common/auth/model/user_login_info_model.dart';
import 'package:swoony/common/auth/widgets/common_logo.dart';
import 'package:swoony/common/payment/cubit/payment_cubit.dart';
import 'package:swoony/common/setting/cubit/faq_cubit.dart';
import 'package:swoony/common/show_info/cubit/info_state.dart';
import 'package:swoony/core/app_bar/common_app_bar.dart';
import 'package:swoony/core/component/button/common_button.dart';
import 'package:swoony/core/component/image/common_image.dart';
import 'package:swoony/core/component/other_widgets/common_dialog.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/component/text_field/common_multiline_text_field.dart';
import 'package:swoony/core/component/text_field/common_text_field.dart';
import 'package:swoony/core/component/text_field/input_helper.dart';
import 'package:swoony/core/config/bloc/cubit_scope.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/config/route/app_router.gr.dart';
import 'package:swoony/core/utils/app_utils.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/constants/app_text_styles.dart';
import 'package:swoony/core/utils/extensions/extension.dart';
import 'package:swoony/gen/assets.gen.dart';
import 'package:swoony/main.dart';

@RoutePage()
class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key, this.showBackButton = false});
  final bool showBackButton;
  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final authState = context.watch<AuthCubit>().state;
    return Scaffold(
      appBar: showBackButton ? const CommonAppBar() : null,
      body: CubitScope(
        create: () => PaymentCubit(authCubit),
        builder: (context, cubit, state) => SingleChildScrollView(
          child: Column(
            children: [
              showBackButton ? const SizedBox.shrink() : 10.height,

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CommonText(
                        text: AppString.myAccount,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        style: AppTextStyles.titleMedium?.copyWith(color: AppColors.primaryColor),
                      ).start,
                      8.height,
                      GestureDetector(
                        onTap: () {
                          commonDialog(
                            child: BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    24.height,
                                    GestureDetector(
                                      onTap: authCubit.pickImage,
                                      child: CommonImage(
                                        imageSrc:
                                            state.pickedImage?.path ??
                                            (authCubit.state.profileModel?.image ??
                                                Assets.images.user),
                                        size: 63,
                                      ),
                                    ),
                                    22.height,
                                    CommonButton(
                                      buttonWidth: 150.w,
                                      isLoading: state.isLoading,
                                      titleText: AppString.uploadImage,
                                      onTap: () {
                                        if (authCubit.state.pickedImage != null)
                                          authCubit.updateProfile(image: state.pickedImage);
                                        appRouter.pop();
                                      },
                                    ),
                                    8.height,
                                    CommonButton(
                                      buttonWidth: 150.w,
                                      titleText: AppString.removeImage,
                                      onTap: () {
                                        authCubit.updateProfile(isDeleteImage: true);
                                      },
                                    ),
                                    14.height,
                                    CommonButton(
                                      titleText: AppString.cancel,
                                      borderColor: AppColors.error,
                                      titleColor: AppColors.error,
                                      onTap: () {
                                        authCubit.clearImage();
                                        appRouter.pop();
                                      },
                                      buttonColor: AppColors.backgroundWhite,
                                    ),
                                    24.height,
                                  ],
                                );
                              },
                            ),
                            context: context,
                          );
                        },
                        child: CommonImage(
                          borderRadius: 4,
                          imageSrc: authCubit.state.profileModel?.image ?? Assets.images.user,
                          size: 36,
                        ).start,
                      ),
                      CommonText(
                        top: 8,
                        text: context.read<AuthCubit>().state.profileModel?.name ?? '',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ).start,
                      10.height,
                      accountSummery(authState.profileModel),
                      15.height,
                      if (Utils.getRole() == Role.ORGANIZER) ...[
                        _menuItems(
                          context: context,
                          title: AppString.sendNotificationAboutAnEvent,
                          showInfo: true,
                          onTap: () {
                            appRouter.push(
                              AllEventRoute(
                                onTap: (eventId, title) {
                                  appRouter.push(
                                    EventNotificationEnableRoute(title: title, id: eventId),
                                  );
                                },
                                title: 'Select an Event to send a Notification',
                              ),
                            );
                          },
                        ),
                        Utils.divider(),
                      ],

                      _menuItems(
                        context: context,
                        title: AppString.aboutUs,
                        onTap: () {
                          appRouter.push(
                            ShowInfoRoute(title: AppString.aboutUs, infoType: InfoType.about_us),
                          );
                        },
                      ),
                      Utils.divider(),
                      _menuItems(
                        context: context,
                        title: AppString.faqHelp,
                        onTap: () {
                          appRouter.push(FaqRoute(faqType: FaqType.user));
                        },
                      ),
                      Utils.divider(),
                      _menuItems(
                        context: context,
                        title: AppString.contactUs,
                        onTap: () {
                          appRouter.push(const ContactUsRoute());
                        },
                      ),
                      Utils.divider(),
                      _menuItems(
                        context: context,
                        title:
                            authState.profileModel?.stripeAccountInfo.stripeAccountId.isNotEmpty ??
                                false
                            ? 'Open your (Bank) Account'
                            : AppString.linkYourBankAccount,
                        onTap: () {
                          cubit.onPaymentSettingClick();
                        },
                      ),
                      Utils.divider(),
                      _menuItems(
                        context: context,
                        title: AppString.emailPreferences,
                        onTap: () {
                          appRouter.push(const EmailPreferenceRoute());
                        },
                      ),
                      Utils.divider(),
                      _menuItems(
                        context: context,
                        title: AppString.changePassword,
                        onTap: () {
                          appRouter.push(const ChangePasswordRoute());
                        },
                      ),
                      Utils.divider(),
                      _menuItems(
                        context: context,
                        title: AppString.deleteAccount,
                        onTap: () {
                          String password = '';
                          String reason = '';
                          CommonDialogWithActions(
                            title: AppString.deleteAccount,
                            subTitle: AppString.accountDeleteMessage,
                            content: [
                              CommonTextField(
                                validationType: ValidationType.validatePassword,
                                hintText: AppString.password,
                                onSaved: (value, c) {
                                  password = value;
                                },
                              ),
                              10.height,
                              CommonMultilineTextField(
                                onSaved: (value, c) {
                                  reason = value;
                                },
                                height: 110,
                                validationType: ValidationType.validateRequired,
                                hintText: AppString.enterYourReason,
                              ),
                            ],
                            validationRequired: true,
                            onConfirm: () {
                              authCubit.deleteAccount(password: password, reason: reason);
                            },
                            context: context,
                          );
                        },
                      ),
                      Utils.divider(),
                      _menuItems(
                        context: context,
                        title: AppString.locations,
                        subTitle:
                            '${authState.profileModel?.address.city ?? ''}, ${authState.profileModel?.address.street ?? ''}, ${authState.profileModel?.address.country ?? ''}',
                        onTap: () {
                          // appRouter.push(CustomMapRoute(onPositionChange: (details) {}));
                          appRouter.push(const LocationRoute());
                        },
                      ),
                      Utils.divider(),
                      _menuItems(
                        context: context,
                        title: Utils.getRole() == Role.ORGANIZER
                            ? 'Switch to Attendee'
                            : 'Switch to Organizer',
                        onTap: () {
                          context.read<AuthCubit>().switchRole();
                        },
                      ),
                      20.height,
                      CommonButton(
                        titleText: AppString.logOut,
                        onTap: () {
                          context.read<AuthCubit>().logout();
                        },
                      ).center,
                      10.height,
                      CommonText(
                        text: '${AppString.appName} v $versionCode',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ).center,

                      CommonText(
                        text: AppString.copyright,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ).center,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              appRouter.push(
                                ShowInfoRoute(
                                  title: AppString.termsOfuse,
                                  infoType: InfoType.terms,
                                ),
                              );
                            },
                            child: CommonText(
                              text: AppString.termsOfuse,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              textColor: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primaryColor,
                            ),
                          ),
                          const CommonText(text: ' & ', fontSize: 12, fontWeight: FontWeight.w400),
                          GestureDetector(
                            onTap: () {
                              appRouter.push(
                                ShowInfoRoute(
                                  title: AppString.privacyNotice,
                                  infoType: InfoType.privacy,
                                ),
                              );
                            },
                            child: CommonText(
                              text: AppString.privacyNotice,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              textColor: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      30.height,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuItems({
    required BuildContext context,
    required String title,
    required Function() onTap,
    String? subTitle,
    bool showInfo = false,
  }) {
    Widget textWidget = CommonText(fontSize: 14, fontWeight: FontWeight.w400, text: title);
    if (subTitle != null) {
      textWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonText(fontSize: 14, fontWeight: FontWeight.w400, text: title.capitalizeEachWord()),
          CommonText(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            textColor: AppColors.primaryColor,
            text: subTitle,
          ),
        ],
      );
    }
    final Widget container = Container(
      height: 54.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.white400,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          textWidget,
          if (showInfo)
            IconButton(
              onPressed: () {
                commonDialog(
                  isDismissible: true,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      24.height,
                      const CommonLogo(),
                      CommonText(
                        text: AppString.appName,
                        fontSize: 20,
                        textColor: AppColors.primaryColor,
                      ),
                      10.height,
                      CommonText(
                        text:
                            'Request Mainland to send urgent updates. Once approved, attendees who purchased your Event ticket will get an email and push notification.',
                        fontSize: 20,
                        maxLines: 5,
                        textColor: AppColors.greay400,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.left,
                      ),
                      10.height,
                      CommonButton(titleText: AppString.cancel, onTap: appRouter.pop),
                      24.height,
                    ],
                  ),
                  context: context,
                );
              },
              icon: const Icon(Icons.info_outline),
            ),
          const Spacer(),
          Icon(Icons.arrow_forward_ios, color: AppColors.primaryColor),
        ],
      ),
    );
    return GestureDetector(onTap: onTap, child: container);
  }

  Widget accountSummery(ProfileModel? profileModel) {
    double balance = 0;
    if (profileModel != null) {
      balance = profileModel.sellAmount - profileModel.withDrawAmount;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(Assets.images.user), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              12.height,
              CommonText(
                text: AppString.myBalance,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                textAlign: TextAlign.left,
                textColor: AppColors.textWhite,
              ).start,
              CommonText(
                text: '\$$balance',
                fontWeight: FontWeight.w600,
                fontSize: 24,
                textAlign: TextAlign.left,
                textColor: AppColors.textWhite,
              ).start,
              12.height,
            ],
          ),
          const Spacer(),
          CommonButton(
            buttonColor: AppColors.backgroundWhite,
            titleText: AppString.withdraw,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
