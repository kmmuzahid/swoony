import 'package:flutter/material.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';

class RequiredIconWidget extends StatelessWidget {
  const RequiredIconWidget({super.key});

  Widget requiredIcon() =>
      const CommonText(text: '*', textColor: AppColors.warning, fontSize: 20, top: 10);

  @override
  Widget build(BuildContext context) => requiredIcon();
}
