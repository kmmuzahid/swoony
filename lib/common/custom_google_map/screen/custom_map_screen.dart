import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:swoony/common/custom_google_map/model/place_details.dart';
import 'package:swoony/common/custom_google_map/widgets/custom_google_map.dart';
import 'package:swoony/core/app_bar/common_app_bar.dart';
import 'package:swoony/core/component/button/common_button.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';

@RoutePage()
class CustomMapScreen extends StatelessWidget {
  const CustomMapScreen({super.key, this.onPositionChange});
  final void Function(PlaceDetails details)? onPositionChange;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: CommonAppBar(
      title: 'Location',
      actions: [
        TextButton(
          onPressed: appRouter.pop,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryButton, width: 1.4.w),

              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: const EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
            child: CommonText(
              text: 'Done',
              style: TextStyle(color: AppColors.primaryColor, fontSize: 16.sp),
            ),
          ),
        ),
      ],
    ),
    body: CustomGoogleMap(widgets: (contex, state) => [], onPositionChange: onPositionChange),
  );
}
