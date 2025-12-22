import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/common/setting/cubit/contact_cubit.dart';
import 'package:swoony/common/setting/cubit/contact_state.dart';
import 'package:swoony/core/app_bar/common_app_bar.dart';
import 'package:swoony/core/component/button/common_button.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/component/text_field/common_multiline_text_field.dart';
import 'package:swoony/core/component/text_field/custom_form.dart';
import 'package:swoony/core/component/text_field/input_helper.dart';
import 'package:swoony/core/config/bloc/cubit_scope.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/constants/app_text_styles.dart';
import 'package:swoony/core/utils/extensions/extension.dart';

@RoutePage()
class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: CustomForm(
          builder: (context, formKey) => CubitScope<ContactCubit, ContactState>(
            create: ContactCubit.new,
            builder: (context, cubit, state) => Column(
              children: [
                CommonText(
                  text: AppString.contactUs,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  style: AppTextStyles.titleMedium?.copyWith(color: AppColors.primaryColor),
                ).start,
                CommonText(
                  textAlign: TextAlign.justify,
                  fontSize: 13,
                  maxLines: 5,
                  text: AppString
                      .forTheBestSupportExperiencePleaseDescribeYourIssueClearlyInASingleDetailedMessageOurTeamWillReviewItAndGetInTouchWithYouViaEmail,
                ),
                10.height,
                CommonMultilineTextField(
                  height: 290,
                  onSaved: (data, controller) {
                    if (formKey.currentState?.validate() == true) {
                      cubit.save(data);
                    }
                  },
                  validationType: ValidationType.validateRequired,
                ),
                20.height,
                CommonButton(
                  titleText: AppString.send,
                  onTap: () {
                    formKey.currentState?.save();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
