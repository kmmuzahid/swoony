import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/common/auth/widgets/common_logo.dart';
import 'package:swoony/core/component/button/common_button.dart';
import 'package:swoony/core/component/other_widgets/common_dialog.dart';
import 'package:swoony/core/component/pop_up/common_popup_menu.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/component/text_field/common_date_input_text_field.dart';
import 'package:swoony/core/component/text_field/common_text_field.dart';
import 'package:swoony/core/component/text_field/custom_form.dart';
import 'package:swoony/core/component/text_field/input_helper.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/utils/app_utils.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/extensions/extension.dart';
import 'package:swoony/core/utils/log/app_log.dart';
import 'package:swoony/organizer/createTicket/cubit/create_ticket_cubit.dart';
import 'package:swoony/organizer/createTicket/model/create_event_model.dart';
import 'package:swoony/organizer/createTicket/widgets/event_form_ticket_selctor.dart';
import 'package:swoony/organizer/createTicket/widgets/form_label.dart';
import 'package:swoony/organizer/createTicket/widgets/promo_builder_widget.dart';

import 'create_ticket_titlebar.dart';

class TicketFormTwo extends StatelessWidget {
  const TicketFormTwo({
    super.key,
    required this.createEventModel,
    required this.isReadOnly,
    required this.cubit,
    required this.isExpanded,
  });
  final CreateEventModel createEventModel;
  final bool isReadOnly;
  final CreateTicketCubit cubit;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) { 
    // print(createEventModel.discountCodes.isEmpty);
    return CustomForm(
      builder: (context, formKey) {
        return Column(
          children: [
            CreateTicketTitlebar(title: 'Tickets', showSaveButton: !isExpanded, formKey: formKey),
            Row(
              children: [
                _buildCheckBox(
                  isReadOnly: isReadOnly,
                  value: cubit.state.createEventModel.isFreeEvent,
                  onChanged: (value) {
                    cubit.updateField(
                      cubit.state.createEventModel.copyWith(isFreeEvent: value ?? false),
                    );
                  },
                ),
                CommonText(text: 'Free Event', fontSize: 18),
              ],
            ),
            Utils.divider(),
            EventFormTicketSelctor(
              cubit: cubit,
              createEventModel: createEventModel,
              isReadOnly: isReadOnly || cubit.state.createEventModel.isFreeEvent,
            ),

            _ticketStartSaleLabel(context),
            CommonDateInputTextField(
              isReadOnly: isReadOnly || cubit.state.createEventModel.isFreeEvent,
              initialValue: createEventModel.ticketSaleStartDate?.toLocal().toString().split(
                ' ',
              )[0],
              minDate: DateTime.now(),
              onSave: (value) {
                cubit.updateField(
                  cubit.state.createEventModel.copyWith(
                    ticketSaleStartDate: value,
                  ),
                );
              },
              backgroundColor: AppColors.backgroundWhite,
            ),
            10.height,
            CommonText(
              text: 'Pre-Sale length: Max 3 days. Must end before the Ticket sale start date',
              textColor: AppColors.greay200,
              fontSize: 16,
              textAlign: TextAlign.left,
              textHeight: 24,
              bottom: 10,
            ),
            _enablerBuilder(
              label: 'Offer Pre-Sale',
              onChange: (value) { 
                cubit.updateField(cubit.state.createEventModel.copyWith(offerPreSale: value));
              },
              initalValue: createEventModel.offerPreSale,
            ),

            FormLabel(isRequired: false, label: 'Pre-Sale start date').start,
            2.height,
            CommonDateInputTextField(
              initialValue: createEventModel.preSaleStartDate?.toLocal().toString().split(' ')[0],
              minDate: DateTime.now(),
              isReadOnly:
                  isReadOnly ||
                  cubit.state.createEventModel.isFreeEvent ||
                  !cubit.state.createEventModel.offerPreSale,
              onSave: (value) {
                cubit.updateField(
                  cubit.state.createEventModel.copyWith(preSaleStartDate: value),
                );
              },
              backgroundColor: AppColors.backgroundWhite,
            ),
            10.height,
            FormLabel(isRequired: false, label: 'Pre-Sale end date').start,
            CommonDateInputTextField(
              initialValue: createEventModel.preSaleEndDate?.toLocal().toString().split(' ')[0],
              minDate: DateTime.now(),
              isReadOnly:
                  isReadOnly ||
                  cubit.state.createEventModel.isFreeEvent ||
                  !cubit.state.createEventModel.offerPreSale,
              onSave: (value) {
                cubit.updateField(
                  cubit.state.createEventModel.copyWith(preSaleEndDate: value),
                );
              },
              backgroundColor: AppColors.backgroundWhite,
            ),
            10.height,
            _enablerBuilder(
              label: 'Offer Discount by Code',
              onChange: (value) {
                cubit.updateField(
                  cubit.state.createEventModel.copyWith(offerDiscountByCode: value),
                );
              },
              initalValue: createEventModel.discountCodes.isNotEmpty,
            ),
            CommonText(
              text: 'Max 3 unique Promo Codes; specify a % Discount for each.',
              textColor: AppColors.greay200,
              fontSize: 16,
              textAlign: TextAlign.left,
              textHeight: 24,
              bottom: 10,
            ),
            10.height,
            PromoBuilderWidget(
              cubit: cubit,
              isReadOnly: isReadOnly,
              initalValue: createEventModel.discountCodes.isNotEmpty
                  ? createEventModel.discountCodes[0]
                  : null,
              onSaved: (code, discount, expire) {
                cubit.updatePromoCode(
                  code: code,
                  discountPercentage: discount,
                  filedId: 1,
                  expireDate: expire,
                );
              },
            ),
            10.height,
            PromoBuilderWidget(
              cubit: cubit,
              isReadOnly: isReadOnly,
              initalValue: createEventModel.discountCodes.length > 1
                  ? createEventModel.discountCodes[1]
                  : null,
              onSaved: (code, discount, expire) {
                cubit.updatePromoCode(
                  code: code,
                  discountPercentage: discount,
                  filedId: 2,
                  expireDate: expire,
                );
              },
            ),
            10.height,
            PromoBuilderWidget(
              cubit: cubit,
              isReadOnly: isReadOnly,
              initalValue: createEventModel.discountCodes.length > 2
                  ? createEventModel.discountCodes[2]
                  : null,
              onSaved: (code, discount, expire) {
                cubit.updatePromoCode(
                  code: code,
                  discountPercentage: discount,
                  filedId: 3,
                  expireDate: expire,
                );
              },
            ),

            if (!isExpanded) ...[
              20.height,

              CommonButton(
                titleText: AppString.next,
                onTap: () {
                  context.read<CreateTicketCubit>().nextPage();
                },
              ).center,
              40.height,
            ],
          ],
        );
      },
    );
  }

  Container _enablerBuilder({
    required String label,
    required Function(bool) onChange,
    required bool initalValue,
  }) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: AppColors.white400,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          CommonText(text: label, fontSize: 16, left: 10),
          const Spacer(),
          CommonPopupMenu(
            items: const ['Yes', 'No'],
            onItemSelected: (value) {
              onChange(value == 'Yes');
            },
            initialText: initalValue ? 'Yes' : 'No',
          ),
        ],
      ),
    );
  }

  Row _ticketStartSaleLabel(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FormLabel(isRequired: true, label: 'Ticket sale start date'),
        IconButton(
          padding: EdgeInsets.zero,
          alignment: Alignment.bottomCenter,
          onPressed: () {
            commonDialog(
              isDismissible: true,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  24.height,
                  const CommonLogo(),
                  CommonText(
                    text: AppString.appName,
                    fontSize: 20,
                    textColor: AppColors.primaryColor,
                  ),
                  10.height,
                  CommonText(
                    text:
                        'Select the date your ticket becomes available for sale to potential Attendees on Mainland — this must be before your Event Date.',
                    fontSize: 20,
                    maxLines: 5,
                    textColor: AppColors.greay400,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.left,
                  ),
                  10.height,
                  CommonButton(titleText: AppString.cancel, onTap: appRouter.pop),
                  24.height,
                ],
              ),
              context: context,
            );
          },
          icon: const Icon(Icons.info_outline, size: 16),
        ),
      ],
    );
  }

  Widget _buildCheckBox({
    required bool isReadOnly,
    bool? value,
    required Function(bool?) onChanged,
  }) {
    return Checkbox(
      side: BorderSide(
        width: 2.w,
        color: cubit.state.createEventModel.isFreeEvent
            ? AppColors.primaryColor
            : AppColors.greay300,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
      value: value ?? cubit.state.createEventModel.isFreeEvent,
      onChanged: (value) {
        print(value);
        if (isReadOnly) return;
        onChanged(value);
      },
    );
  }
}
