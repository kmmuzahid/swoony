import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/core/utils/constants/app_colors.dart' show AppColors;

/// Author: Km Muzahid
/// Email: km.muzahid@gmail.com
/// Date: 2025-12-22
/// Version: 1.0.0
/// Description: Common switch widget for the app
class CommonSwitch extends StatelessWidget {
  const CommonSwitch({super.key, required this.isActive, required this.onChanged});
  final bool isActive;
  final Function(bool value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      trackOutlineWidth: WidgetStateProperty.all(1.4.w),
      thumbColor: WidgetStateProperty.all(isActive ? AppColors.primaryColor : AppColors.greay200),
      trackColor: WidgetStateProperty.all(isActive ? AppColors.primary50 : AppColors.white500),
      trackOutlineColor: WidgetStateProperty.all(
        isActive ? AppColors.primary100 : AppColors.white500,
      ),
      value: isActive,
      onChanged: onChanged,
    );
  }
}
