import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/common/event/cubit/all_event_cubit.dart';
import 'package:swoony/common/event/cubit/all_event_state.dart';
import 'package:swoony/common/tickets/model/ticket_model.dart';
import 'package:swoony/common/tickets/widgets/ticket_widget.dart';
import 'package:swoony/core/app_bar/common_app_bar.dart'; 
import 'package:swoony/core/component/other_widgets/smart_staggered_loader.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/config/bloc/cubit_scope.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/config/route/app_router.gr.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/extensions/extension.dart'; 

@RoutePage()
class AllEventScreen extends StatelessWidget {
  const AllEventScreen({super.key, required this.title, this.ticketFilter, this.onTap});

  final String title;
  final TicketFilter? ticketFilter;
  final Function(String eventId, String title)? onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      body: CubitScope<AllEventCubit, AllEventState>(
        create: () => AllEventCubit()..fetch(ticketFilter: ticketFilter ?? TicketFilter.Live),
        builder: (context, cubit, state) => Column(
          children: [
            CommonText(
              left: 20,
              bottom: 10,
              text: title,
              textColor: AppColors.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ).start,
            Expanded(
              child: SmartStaggeredLoader(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 30.h),
                itemCount: state.events.length,
                crossAxisSpacing: 10,
                aspectRatio: 0.6434,
                mainAxisSpacing: 10,
                isSeperated: true,
                isLoading: state.isLoading,
                onRefresh: () {
                  cubit.fetch(isRefresh: true);
                },
                onLoadMore: cubit.fetch,
                itemBuilder: (context, index) {
                  final event = state.events[index];
                  return TicketWidget(
                    onTap: () {
                      if (onTap != null) {
                        onTap?.call(event.id ?? '', event.eventName ?? '');
                        return;
                      }
                      appRouter.push(EventDetailsRoute(eventId: event.id ?? ''));
                    },
                    ticketModel: event,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
