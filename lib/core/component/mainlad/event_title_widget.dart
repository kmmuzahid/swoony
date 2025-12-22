import 'package:flutter/material.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/utils/app_utils.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';

/// Author: Km Muzahid
/// Email: km.muzahid@gmail.com
/// Date: 2025-12-22
/// Version: 1.0.0
/// Description: Event title widget for the app
class EventTitleWidget extends StatelessWidget {
  const EventTitleWidget({super.key, required this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Utils.deviceSize.width * .7,
      child: CommonText(
        text: title ?? 'Juice WRLD Eko Hotel & Suites Monday, November 04',
        autoResize: false,
        maxLines: 12,
        textAlign: TextAlign.left,
        textColor: AppColors.primaryColor,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
