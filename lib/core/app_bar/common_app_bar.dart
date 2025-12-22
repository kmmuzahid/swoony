import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/core/component/image/common_image.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/gen/assets.gen.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    this.title,
    this.onBackPress,
    this.titleWidget,
    this.leading,
    this.actions,
    this.isCenterTitle = true,
    this.backgroundColor,
    this.hideBack = false,
    this.disableBack = false,
  });
  final String? title;
  final Widget? titleWidget;
  final Function()? onBackPress;
  final Widget? leading;
  final List<Widget>? actions;
  final bool isCenterTitle;
  final Color? backgroundColor;
  final bool hideBack;
  final bool disableBack;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
    backgroundColor: backgroundColor ?? AppColors.background,
    centerTitle: isCenterTitle,
    actionsPadding: const EdgeInsets.only(bottom: 10),
    leading: hideBack
        ? const SizedBox.shrink()
        : leading ??
              IconButton(
                onPressed: () {
                  if (onBackPress != null) {
                    onBackPress!();
                  }
                  if (!disableBack) {
                    appRouter.pop();
                  }
                },
                icon:
                    // Platform.isIOS
                    //     ? const Icon(Icons.arrow_back_ios, size: 25)
                    //     :
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: CommonImage(
                        fill: BoxFit.contain,
                        width: 40.w, 
                        imageSrc: Assets.images.backIcon,
                      ),
                    ),
              ),
    actions: actions ?? _appBarActions(),

    title:
        titleWidget ?? CommonText(text: title ?? '', fontWeight: FontWeight.w600, fontSize: 18.sp),
  );

  List<Widget> _appBarActions() => [];
}
