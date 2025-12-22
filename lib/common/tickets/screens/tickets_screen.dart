import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/common/tickets/cubit/tickets_cubit.dart';
import 'package:swoony/common/tickets/cubit/tickets_state.dart';
import 'package:swoony/common/tickets/model/ticket_model.dart';
import 'package:swoony/common/tickets/widgets/ticket_filter_widget.dart';
import 'package:swoony/common/tickets/widgets/ticket_widget.dart';
import 'package:swoony/core/app_bar/common_app_bar.dart'; 
import 'package:swoony/core/component/other_widgets/smart_staggered_loader.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/config/bloc/cubit_scope.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/constants/app_text_styles.dart';
import 'package:swoony/core/utils/extensions/extension.dart';
import 'package:swoony/core/utils/grid_child_postion.dart';
import 'package:swoony/core/utils/log/app_log.dart';

@RoutePage()
class TicketsScreen extends StatelessWidget {
  const TicketsScreen({
    super.key,
    required this.onTap,
    required this.filters,
    this.subTitle,
    this.title,
    this.titleSize,
    this.appBar,
  });
  final Function(TicketModel event, TicketFilter ticketFilter) onTap;
  final List<TicketFilter> filters;
  final String? subTitle;
  final String? title;
  final double? titleSize;
  final CommonAppBar? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: CubitScope(
            create: () => TicketsCubit()..initalize(filters.first),
            builder: (context, cubit, state) => Column(
              children: [
                if (appBar == null) 20.height,
                CommonText(
                  text: title ?? AppString.tickets,
                  style: AppTextStyles.headlineSmall,
                  fontSize: titleSize,
                  textColor: AppColors.primaryColor,
                ).start,
                if (subTitle != null)
                  CommonText(text: subTitle!, style: AppTextStyles.bodyMedium).start,
                10.height,
                if (filters.length > 1)
                  TicketFilterWidget(
                    filters: filters,
                    selectedFilter: state.selectedFilter,
                    onTap: context.read<TicketsCubit>().filter,
                  ),
                10.height,

                Expanded(
                  child: !state.isLoading && state.tickets.isEmpty
                      ? const CommonText(text: 'Oops !\nNo Event Found', maxLines: 2, fontSize: 24)
                      : SmartStaggeredLoader(
                          itemCount: state.tickets.length,
                          isLoading: state.isLoading,
                          onLoadMore: cubit.fetch,
                          onRefresh: () {
                            cubit.fetch(isRefresh: true);
                          },
                          aspectRatio: 0.6434,
                          isSeperated: true,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          itemBuilder: (context, index) {
                            final ticket = state.tickets[index];
                            return TicketWidget(
                              filter: state.selectedFilter,
                              ticketModel: ticket,
                              onTap: () {
                                onTap(ticket, state.selectedFilter!);
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          )
            
          
        ),
      ),
    );
  }
}
