import 'package:flutter/material.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';

class FormLabel extends StatelessWidget {
  const FormLabel({super.key, required this.isRequired, required this.label});
  final bool isRequired;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isRequired)
          CommonText(
            text: '*',
            fontSize: 18,
            textColor: AppColors.error,
            fontWeight: FontWeight.w400,
          ),
        CommonText(text: label, fontSize: 14, fontWeight: FontWeight.w400),
      ],
    );
  }
}
