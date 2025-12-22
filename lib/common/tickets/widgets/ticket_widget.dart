import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/common/auth/model/user_login_info_model.dart' show Role;
import 'package:swoony/common/tickets/model/ticket_model.dart';
import 'package:swoony/common/tickets/widgets/ticket_filter_widget.dart';
import 'package:swoony/core/component/image/common_image.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/config/route/app_router.gr.dart';
import 'package:swoony/core/utils/app_utils.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/constants/app_text_styles.dart';
import 'package:swoony/core/utils/extensions/extension.dart';

class TicketWidget extends StatelessWidget {
  const TicketWidget({required this.ticketModel, required this.onTap, this.filter, super.key});
  final TicketModel ticketModel;
  final Function() onTap;
  final TicketFilter? filter;

  @override
  Widget build(BuildContext context) {
    return _content();
  }

  GestureDetector _content() {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: CommonImage(
                    enableGrayscale:
                        filter == TicketFilter.Closed ||
                        filter == TicketFilter.Used ||
                        filter == TicketFilter.Expired ||
                        filter == TicketFilter.UnderReview,
                    imageSrc: ticketModel.image ?? '',
                    borderRadius: 12,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryText.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _textBuilder(
                      title: ticketModel.eventName ?? '',
                      maxLine: 2,
                      preventScalling: true,
                    ),
                    if (ticketModel.eventDate != null && ticketModel.startTime != null)
                      _textBuilder(
                        title:
                            '${Utils.formatDateToShortMonth(ticketModel.eventDate!)} ${ticketModel.startTime?.to12HourString()}',
                      ),
                    _textBuilder(
                      title: '${ticketModel.streetAddress}, ${ticketModel.streetAddress2}',
                      maxLine: 2,
                      preventScalling: true,
                    ),
                    if (ticketModel.ticketSaleStart != null &&
                        ticketModel.ticketSaleStart!.isAfter(DateTime.now()))
                      _textBuilder(
                        title:
                            'Pre-Order available ${Utils.formatDateToShortMonth(ticketModel.eventDate!)}',
                        maxLine: 2,
                      ),

                    // if (!(ticketModel.ticketSaleStart.isAfter(DateTime.now())))
                    //   _textBuilder(
                    //     title:
                    //         'available ${Utils.formatDateTimeWithSHortMonth(ticketModel.eventDate)}',
                    //     maxLine: 2,
                    //   ),
                  ],
                ),
                if (filter == TicketFilter.Live ||
                    filter == TicketFilter.Upcoming ||
                    filter == TicketFilter.Used)
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 12.w,
                      height: 12.w,
                      margin: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: filter == TicketFilter.Used
                            ? AppColors.error
                            : AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              appRouter.push(
                EventDetailsRoute(
                  eventId: ticketModel.id ?? '',
                  showEventActions: Utils.getRole() == Role.ATTENDEE,
                  isEventAvailable:
                      filter != TicketFilter.Closed &&
                      filter != TicketFilter.UnderReview &&
                      filter != TicketFilter.Draft &&
                      filter != TicketFilter.Expired,
                  isEventUnderReview: filter == TicketFilter.UnderReview,
                ),
              );
            },
            child: CommonText(
              text: AppString.viewPlus,
              fontSize: 18,
              style: AppTextStyles.titleLarge?.copyWith(color: AppColors.primaryColor),
            ),
          ).start,
        ],
      ),
    );
  }

  Widget _textBuilder({required String title, int maxLine = 1, bool preventScalling = false}) {
    return CommonText(
      left: 10,
      right: 10,
      text: title,
      preventScaling: preventScalling,
      autoResize: false,
      overflow: TextOverflow.fade,
      maxLines: maxLine,
      fontSize: 16.5,
      textAlign: TextAlign.left,
      style: AppTextStyles.titleMedium?.copyWith(color: AppColors.textWhite),
    );
  }
}
