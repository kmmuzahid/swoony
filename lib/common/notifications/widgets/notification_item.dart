import 'package:flutter/material.dart';
import 'package:swoony/core/component/mainlad/event_title_widget.dart';
import 'package:swoony/core/component/other_widgets/common_dialog.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/config/socket/notification_model.dart';
import 'package:swoony/core/utils/app_utils.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/extensions/extension.dart';
import 'package:swoony/main.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({required this.item, super.key});

  final NotificationModel item;

  @override
  Widget build(BuildContext context) => _content(context);
  GestureDetector _content(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.type == NotificationType.EVENT) {
          commonDialog(
            isDismissible: true,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  EventTitleWidget(title: item.eventTitle ?? ''),
                  10.height,
                  CommonText(text: item.message ?? ''),
                ],
              ),
            ),
            context: context,
          );
        } else
          showSnackBar(AppString.noDetailsAvailableForThisNotification, type: SnackBarType.warning);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CommonImage(imageSrc: _getImage(), size: 26, imageColor: getTheme.primaryColor),
          10.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: item.title ?? '',
                  fontSize: 16,
                  maxLines: 1,
                  fontWeight: FontWeight.w600,
                  textColor: item.type == NotificationType.EVENT && item.read == false
                      ? AppColors.primaryColor
                      : item.read
                      ? AppColors.greay200
                      : AppColors.greay400,
                ),
                CommonText( 
                  text: item.message ?? '',
                  maxLines: 2,
                  preventScaling: true,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  textColor: item.read ? AppColors.greay200 : AppColors.greay400,
                ),
                Utils.divider(),
              ],
            ),
          ),
          10.width,
        ],
      ),
    );
  }
}
