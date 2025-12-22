import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Author: Km Muzahid
/// Email: km.muzahid@gmail.com
/// Date: 2025-12-22
/// Version: 1.0.0
/// Description: Common loader widget for the app
class CommonLoader extends StatelessWidget {
  const CommonLoader({super.key, this.size = 60, this.strokeWidth = 4});

  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size.sp.w,
        width: size.sp.w,
        child: CircularProgressIndicator.adaptive(strokeWidth: strokeWidth.w),
      ),
    );
  }
}
