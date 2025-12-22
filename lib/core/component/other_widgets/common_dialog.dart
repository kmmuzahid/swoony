import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/core/component/button/common_button.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/component/text_field/custom_form.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/extensions/extension.dart';

/// Author: Km Muzahid
/// Email: km.muzahid@gmail.com
/// Date: 2025-12-22
/// Version: 1.0.0
/// Description: Common dialog widget for the app

Future commonDialog({
  required Widget child,
  required BuildContext context,
  bool isDismissible = false,
}) {
  return showDialog(
    context: context,
    barrierDismissible: isDismissible,
    builder: (dialogContext) => Dialog(
      backgroundColor: AppColors.serfeceBG,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: child,
      ),
    ),
  );
}

Future CommonDialogWithActions({
  required List<Widget> content,
  required BuildContext context,
  required String title,
  String? subTitle,
  bool isDismissible = true,
  final bool validationRequired = false,
  required Function() onConfirm,
  Function()? onCancel,
}) {
  return showDialog(
    context: context,
    barrierDismissible: isDismissible,
    builder: (dialogContext) => Dialog(
      backgroundColor: AppColors.serfeceBG,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: validationRequired
            ? CustomForm(
                builder: (context, formKey) =>
                    _body(title, subTitle, content, onConfirm, onCancel, formKey),
              )
            : _body(title, subTitle, content, onConfirm, onCancel, null),
      ),
    ),
  );
}

Column _body(
  String title,
  String? subTitle,
  List<Widget> content,
  Function onConfirm,
  Function? onCancel,
  GlobalKey<FormState>? formKey,
) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      CommonText(
        top: 20,
        text: title,
        fontWeight: FontWeight.w600,
        textColor: AppColors.primaryColor,
        fontSize: 24,
      ),
      if (subTitle != null)
        CommonText(
          maxLines: 3,
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.left,
          bottom: 10,
          fontSize: 16,
          text: subTitle,
        ),
      ...content,
      20.height,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonButton(
            titleText: AppString.confim,
            onTap: () {
              if (formKey != null) {
                if (formKey.currentState?.validate() ?? false) {
                  formKey.currentState?.save();
                  onConfirm.call();
                  appRouter.pop();
                }
              } else {
                onConfirm.call();
                appRouter.pop();
              }
            },
          ),
          20.width,
          CommonButton(
            buttonColor: AppColors.white400,
            titleText: AppString.cancel,
            onTap: () {
              onCancel?.call();
              appRouter.pop();
            },
          ),
        ],
      ),
      20.height,
    ],
  );
}
