import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/component/text_field/common_text_field.dart';
import 'package:swoony/core/component/text_field/input_helper.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/extensions/extension.dart';
import 'package:swoony/organizer/createTicket/cubit/create_ticket_cubit.dart';
import 'package:swoony/organizer/createTicket/model/create_event_model.dart';

class EventFormTicketSelctor extends StatelessWidget {
  const EventFormTicketSelctor({
    super.key,
    required this.createEventModel,
    required this.isReadOnly,
    required this.cubit,
  });
  final CreateEventModel createEventModel;
  final bool isReadOnly;
  final CreateTicketCubit cubit;

  @override
  Widget build(BuildContext context) {
    return _buildTicketForm(isReadOnly: isReadOnly);
  }

  Widget _buildCheckBox({
    required bool isReadOnly,
    required Function(bool?) onChanged,
    bool? value,
  }) {
    final Color checkColor = (isReadOnly && value == true)
        ? AppColors.greay300
        : AppColors.primaryText;
    final Color fillColor = (isReadOnly && value == true) || value == false
        ? AppColors.white100
        : AppColors.primaryColor;
    return Checkbox(
      side: BorderSide(
        width: 2.w,
        color: (isReadOnly && value == true)
            ? AppColors.greay300
            : ((isReadOnly ? false : (value ?? cubit.state.createEventModel.isFreeEvent))
                  ? AppColors.primaryColor
                  : AppColors.greay300),
      ),
      checkColor: checkColor,
      fillColor: WidgetStateColor.resolveWith((e) => fillColor),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
      value: value ?? cubit.state.createEventModel.isFreeEvent,
      onChanged: (value) {
        if (isReadOnly) return;
        onChanged(value);
      },
    );
  }

  Widget _buildTicketForm({required bool isReadOnly}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white400,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Table(
        children: [
          TableRow(
            children: [
              CommonText(
                text: 'Type',
                fontSize: 14,
                left: 15,
                textColor: AppColors.greay300,
                alignment: MainAxisAlignment.center,
              ),
              CommonText(
                left: 10,
                fontSize: 14,
                text: 'Set Unit Price(\$)',
                textColor: AppColors.greay300,
                alignment: MainAxisAlignment.center,
              ),
              CommonText(
                left: 10,
                fontSize: 14,
                text: 'Available Unit',
                textColor: AppColors.greay300,
                alignment: MainAxisAlignment.center,
              ),
            ],
          ),
          _buildTicketFormRow(isReadOnly: isReadOnly, ticketName: TicketName.Premium),
          _buildTicketFormRow(isReadOnly: isReadOnly, ticketName: TicketName.VIP),
          _buildTicketFormRow(isReadOnly: isReadOnly, ticketName: TicketName.Standard),
          _buildTicketFormRow(isReadOnly: isReadOnly, ticketName: TicketName.Other),
        ],
      ),
    );
  }

  TableRow _buildTicketFormRow({required bool isReadOnly, required TicketName ticketName}) {
    final bool isSelected =
        cubit.state.createEventModel.ticketTypes.indexWhere((e) {
          return e.name == ticketName;
        }) !=
        -1;
    final TicketTypeModel? ticket = _getTicket(ticketName);
    return TableRow(
      children: [
        Row(
          children: [
            _buildCheckBox(
              isReadOnly: isReadOnly,
              value: isSelected,
              onChanged: (value) {
                cubit.updateTicket(ticketName: ticketName, isSelected: value);
              },
            ),
            CommonText(
              text: ticketName == TicketName.VIP ? 'VIP' : ticketName.name.capitalizeEachWord(),
              fontSize: 16,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          child: SizedBox(
            height: 35.h,
            child: CommonTextField(
              initialText: ticket?.setUnitPrice != null ? ticket?.setUnitPrice.toString() : '',
              paddingVertical: 0,
              showValidationMessage: false,
              validationType:
                  (cubit.state.createEventModel.isFreeEvent || isReadOnly || !isSelected)
                  ? ValidationType.notRequired
                  : ValidationType.validateCurrency,
              backgroundColor: cubit.state.createEventModel.isFreeEvent
                  ? AppColors.white100
                  : AppColors.backgroundWhite,
              isReadOnly: isReadOnly,
              borderColor: AppColors.backgroundWhite,
              onSaved: (value, controller) {
                cubit.updateTicket(ticketName: ticketName, unitPrice: double.tryParse(value));
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          child: SizedBox(
            height: 35.h,
            child: CommonTextField(
              initialText: ticket?.availableUnit != null ? ticket?.availableUnit.toString() : '',
              showValidationMessage: false,
              paddingVertical: 0,
              validationType:
                  (cubit.state.createEventModel.isFreeEvent || isReadOnly || !isSelected)
                  ? ValidationType.notRequired
                  : ValidationType.validateNumber,
              backgroundColor: cubit.state.createEventModel.isFreeEvent
                  ? AppColors.white100
                  : AppColors.backgroundWhite,
              borderColor: AppColors.backgroundWhite,
              isReadOnly: isReadOnly,
              onSaved: (value, controller) {
                cubit.updateTicket(ticketName: ticketName, availableUnit: int.tryParse(value));
              },
            ),
          ),
        ),
      ],
    );
  }

  TicketTypeModel? _getTicket(TicketName ticketName) {
    final index = createEventModel.ticketTypes.indexWhere((e) => e.name == ticketName);
    return index != -1 ? createEventModel.ticketTypes[index] : null;
  }
}
