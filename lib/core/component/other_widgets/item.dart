import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../image/common_image.dart';
import '../text/common_text.dart';

class Item extends StatelessWidget {
  const Item({
    required this.title,
    super.key,
    this.icon,
    this.image = '',
    this.disableDivider = false,
    this.onTap,
    this.color = const Color(0xFF333333),
    this.vertical = 4,
    this.horizontal = 24,
    this.disableIcon = false,
  });

  final IconData? icon;
  final String title;
  final String image;
  final bool disableDivider;
  final bool disableIcon;
  final VoidCallback? onTap;
  final Color color;
  final double vertical;
  final double horizontal;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontal.w, vertical: vertical.h),
        child: Column(
          children: [
            Row(
              children: [
                icon != null ? Icon(icon, color: color) : CommonImage(imageSrc: image),
                CommonText(text: title, textColor: color, fontSize: 18, left: 16),
                const Spacer(),
                disableIcon
                    ? const SizedBox()
                    : Icon(Icons.arrow_forward_ios_outlined, size: 20.sp),
              ],
            ),
            disableDivider ? const SizedBox() : const Divider(),
          ],
        ),
      ),
    );
  }
}
