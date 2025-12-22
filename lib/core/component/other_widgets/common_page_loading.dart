import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonPageLoading extends StatelessWidget {
  const CommonPageLoading({
    super.key,
    this.message,
    this.backgroundColor = Colors.white,
    this.indicatorColor,
    this.indicatorSize = 40.0,
  });

  final String? message;
  final Color backgroundColor;
  final Color? indicatorColor;
  final double indicatorSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: backgroundColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: indicatorSize.w,
            height: indicatorSize.w,
            child: CircularProgressIndicator(
              strokeWidth: 3.0.w,
              valueColor: AlwaysStoppedAnimation<Color>(indicatorColor ?? theme.primaryColor),
            ),
          ),
          if (message != null) ...[
            SizedBox(height: 16.w),
            Text(message!, style: theme.textTheme.bodyMedium, textAlign: TextAlign.center),
          ],
        ],
      ),
    );
  }
}
