import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:swoony/common/notifications/cubit/notification_cubit.dart';
import 'package:swoony/common/notifications/cubit/notification_state.dart';
import 'package:swoony/common/notifications/widgets/notification_item.dart';
import 'package:swoony/core/app_bar/common_app_bar.dart';
import 'package:swoony/core/component/other_widgets/smart_list_loader.dart';
import 'package:swoony/core/config/bloc/cubit_scope.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';

@RoutePage()
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
 
    return CubitScope(
      create: () => NotificationCubit()..init(),
      builder: (context, cubit, state) { 
        return Scaffold(
          appBar: CommonAppBar(title: AppString.notifications, onBackPress: cubit.cleanList),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SmartListLoader(
              itemCount: state.notifications?.length ?? 0,
              isLoading: state.isLoading,
              onLoadMore: cubit.loadMore,
              onRefresh: cubit.fetch,
              itemBuilder: (context, index) => NotificationItem(item: state.notifications![index]),
            ),
          ),
        );
      },
    );
  }
}
