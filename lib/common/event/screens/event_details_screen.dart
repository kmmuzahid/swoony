import 'package:auto_route/auto_route.dart' show RoutePage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/common/auth/model/user_login_info_model.dart';
import 'package:swoony/common/chat/model/chat_list_item_model.dart';
import 'package:swoony/common/event/cubit/event_details_cubit.dart';
import 'package:swoony/common/event/cubit/event_details_state.dart';
import 'package:swoony/common/event/model/event_details_model.dart';
import 'package:swoony/core/app_bar/common_app_bar.dart';
import 'package:swoony/core/component/button/common_button.dart';
import 'package:swoony/core/component/image/common_image.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/config/api/api_end_point.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/config/route/app_router.gr.dart';
import 'package:swoony/core/utils/app_utils.dart';
import 'package:swoony/core/utils/common_share.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/constants/app_text_styles.dart';
import 'package:swoony/core/utils/extensions/extension.dart';
import 'package:swoony/gen/assets.gen.dart';

@RoutePage()
class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({
    required this.eventId,
    super.key,
    this.showEventActions = true,
    this.isEventAvailable = true,
    this.isEventUnderReview = false,
    this.details,
    this.image,
  });

  final String eventId;
  final bool showEventActions;
  final bool isEventAvailable;
  final bool isEventUnderReview;
  final String? details;
  final String? image;

  @override
  Widget build(BuildContext context) {
    final showButton = showEventActions == false ? false : Utils.getRole() == Role.ATTENDEE;
    return BlocProvider(
      create: (context) => EventDetailsCubit()..fetch(eventId: eventId),
      child: BlocBuilder<EventDetailsCubit, EventDetailsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CommonAppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    if (state.eventDetails?.eventName != null && state.eventDetails?.image != null)
                      CommonShare.instance.shareContent(
                        title: state.eventDetails!.eventName ?? '',
                        imageUrl: state.eventDetails!.image!,
                        deepLinkUrl:
                            '${ApiEndPoint.instance.domain}/event/${state.eventDetails!.id}',
                      );
                  },
                  icon: Icon(Icons.ios_share_outlined, color: AppColors.primaryColor),
                ),
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    if (state.showDetails)
                      SizedBox(
                        height: 60.h,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.read<EventDetailsCubit>().showDetails(false);
                              },
                              child: CommonText(
                                top: 5,
                                text: AppString.moreMinus,
                                style: AppTextStyles.titleLarge?.copyWith(
                                  color: AppColors.primaryColor,
                                  fontSize: 24.sp,
                                ),
                              ).start,
                            ),
                            Utils.divider(),
                          ],
                        ),
                      ),
                    Expanded(
                      child: state.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : SingleChildScrollView(
                              child: AnimatedCrossFade(
                                duration: const Duration(milliseconds: 300),
                                sizeCurve: Curves.easeInToLinear,
                                firstChild: _firstChild(state.eventDetails, context, showButton),
                                secondChild: _scondChild(context, state, showButton),
                                crossFadeState: state.showDetails
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _scondChild(BuildContext context, EventDetailsState state, bool showButton) {
    return Column(
      children: [
        CommonText(
          text: details ?? (state.eventDetails?.description ?? ''),
          isDescription: true,
          textAlign: TextAlign.left,
          fontSize: 16,
        ),
        10.height,
        if (showButton) Divider(color: AppColors.disable, thickness: 2),
        10.height,
        if (showButton)
          Padding(
            padding: EdgeInsets.only(bottom: 50.h),
            child: _buttons(state.eventDetails),
          ),
      ],
    );
  }

  Column _firstChild(EventDetailsModel? eventDetails, BuildContext context, bool showButton) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 0.562499994567678,
          child: Stack(
            children: [
              Positioned.fill(
                child: CommonImage(
                  imageSrc: image ?? (eventDetails?.image ?? Assets.sample.sample1),
                  enableGrayscale: !isEventAvailable,
                  borderRadius: 12,
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryText.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),

              Positioned(
                left: 10.w,
                top: 30.h,
                width: Utils.deviceSize.width * .7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _textBuilder(
                      title: eventDetails?.eventName ?? '',
                      maxLine: 7,
                      preventScalling: true,
                    ),
                    if (eventDetails?.eventDate != null)
                      _textBuilder(
                        title:
                            '${Utils.formatDateToShortMonth(eventDetails!.eventDate!)} ${eventDetails.startTime?.to12HourString()}',
                      ),
                    _textBuilder(
                      title: '${eventDetails?.streetAddress}',
                      maxLine: 2,
                      preventScalling: true,
                    ),
                    if (eventDetails?.streetAddress2 != null &&
                        eventDetails?.streetAddress?.isNotEmpty == true)
                      _textBuilder(
                        title: '${eventDetails?.streetAddress2}',
                        maxLine: 2,
                        preventScalling: true,
                      ),
                    if (eventDetails?.ticketSaleStart != null &&
                        eventDetails!.ticketSaleStart!.isAfter(DateTime.now()) &&
                        eventDetails.eventDate != null)
                      _textBuilder(
                        title:
                            'Pre-Order available ${Utils.formatDateToShortMonth(eventDetails.eventDate!)}',
                        maxLine: 2,
                      ),
                    if (Utils.getRole() == Role.ORGANIZER)
                      _textBuilder(title: 'Event Code: ${eventDetails?.eventCode ?? ''}'),
                  ],
                ),
              ),
              if (isEventUnderReview)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CommonText(
                    left: 10.w,
                    right: 10.w,
                    bottom: 20.w,
                    maxLines: 4,
                    text: AppString.yourEventIsUnderReview,
                    style: AppTextStyles.titleLarge,
                    textColor: AppColors.textWhite,
                    fontSize: 20,
                  ),
                ),
              if (showButton)
                Positioned(left: 0, right: 0, bottom: 50.h, child: _buttons(eventDetails)),
            ],
          ),
        ),

        GestureDetector(
          onTap: () {
            context.read<EventDetailsCubit>().showDetails(true);
          },
          child: CommonText(
            left: 10,
            top: 5,
            text: AppString.morePlus,
            style: AppTextStyles.titleLarge?.copyWith(
              color: AppColors.primaryColor,
              fontSize: 24.sp,
            ),
          ).start,
        ),
        Utils.divider(),
      ],
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
      fontSize: 20.5,
      textAlign: TextAlign.left,
      textColor: AppColors.textWhite,
    );
  }

  Widget _buttons(EventDetailsModel? eventDetails) {
    return Column(
      children: [
        CommonButton(
          buttonWidth: 250,
          titleText: AppString.getOrganizerTicket,
          borderColor: AppColors.primaryColor,
          onTap: () {
            //   appRouter.push(
            //     TicketPurchaseRoute(
            //       ticketOwnerType: TicketOwnerType.organizer,
            //       id: eventDetails?.id ?? '',
            //       title: eventDetails?.eventName ?? '',
            //       type: TicketOwnerType.organizer,
            //     ),
            //   );
          },
        ),
        10.height,
        CommonButton(
          buttonWidth: 250,
          titleText: AppString.viewAttendeeTickets,
          borderColor: AppColors.primaryColor,
          onTap: () {
            // appRouter.push(
            //   AttendieTicketAvailablityRoute(
            //     eventId: eventId,
            //     eventName: eventDetails?.eventName ?? '',
            //   ),
            // );
          },
        ),
        10.height,
        CommonButton(
          buttonWidth: 250,
          titleText: AppString.messageOrganizer,
          borderColor: AppColors.primaryColor,
          onTap: () {
            appRouter.push(
              ChatRoute(
                chatListItemModel: ChatListItemModel(
                  chatId: '',
                  userImage: Assets.sample.sample1,
                  userName: 'Organizer XYZ',
                  userStatus: UserStatus.online,
                  lastSendMessageTime: DateTime.now(),
                  lastMessage: '',
                  isRead: false,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
