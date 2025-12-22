import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/common/show_info/cubit/info_cubit.dart';
import 'package:swoony/common/show_info/cubit/info_state.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/config/bloc/cubit_scope.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/extensions/extension.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:swoony/core/utils/log/app_log.dart';

@RoutePage()
class ShowInfoScreen extends StatelessWidget {
  const ShowInfoScreen({super.key, required this.title, required this.infoType});
  final String title;
  final InfoType infoType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CubitScope(
          create: () => InfoCubit()..fetch(infoType),
          builder: (context, cubit, state) => Column(
            children: [
              IconButton(
                onPressed: appRouter.pop,
                icon: Icon(Icons.arrow_back, size: 24.w),
              ).start,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    CommonText(
                      text: title,
                      fontSize: 24,
                      textColor: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ).start, 
                    CommonText(text: state.content ?? ''),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
