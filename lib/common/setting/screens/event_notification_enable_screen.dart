import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/common/setting/cubit/event_notification_cubit.dart';
import 'package:swoony/common/setting/cubit/event_notification_state.dart';
import 'package:swoony/core/app_bar/common_app_bar.dart';
import 'package:swoony/core/component/button/common_button.dart';
import 'package:swoony/core/component/mainlad/event_title_widget.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/component/text_field/common_multiline_text_field.dart';
import 'package:swoony/core/component/text_field/custom_form.dart';
import 'package:swoony/core/component/text_field/input_helper.dart';
import 'package:swoony/core/config/bloc/cubit_scope.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/extensions/extension.dart';

@RoutePage()
class EventNotificationEnableScreen extends StatelessWidget {
  const EventNotificationEnableScreen({required this.id, required this.title, super.key});
  final String id;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      body: CustomForm(
        builder: (context, formKey) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: CubitScope<EventNotificationCubit, EventNotificationState>(
            create: () => EventNotificationCubit()..init(id: id),
            builder: (context, cubit, state) => SingleChildScrollView(
              child: Column(
                children: [
                  EventTitleWidget(title: title).start,
                  10.height,
                  // const CommonText(text: 'Notification', fontSize: 16).start,s
                  const CommonText(
                    textAlign: TextAlign.left,
                    fontSize: 14,
                    autoResize: false,
                    maxLines: 4,
                    text: 'Send one Message per issue. Avoid repeating Messages on the same issue to ensure quick Notification. '
                  ).start,
                  10.height,
                  CommonMultilineTextField(
                    height: 270.h,
                    initialText: state.notification,
                    hintText: AppString.writeYourMessageHere,
                    onSaved: (value, controller) {
                      cubit.updateWelcomeNotificaion(id: id, notification: value);
                    },
                    validationType: ValidationType.validateRequired,
                    maxLength: 150,
                  ),
                  20.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonButton(
                        buttonColor: AppColors.white400,
                        titleText: AppString.cancel,
                        onTap: () {
                          cubit.updateWelcomeNotificaion(id: id, notification: '');
                        },
                      ),
                      20.width,
                      CommonButton(
                        titleText: AppString.send,
                        onTap: () {
                          formKey.currentState?.save();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
