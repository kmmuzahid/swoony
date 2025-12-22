import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/component/text_field/common_date_input_text_field.dart';
import 'package:swoony/core/component/text_field/common_text_field.dart';
import 'package:swoony/core/component/text_field/input_helper.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/extensions/extension.dart';
import 'package:swoony/core/utils/log/app_log.dart';
import 'package:swoony/organizer/createTicket/cubit/create_ticket_cubit.dart';
import 'package:swoony/organizer/createTicket/model/create_event_model.dart';

class PromoBuilderWidget extends StatefulWidget {
  const PromoBuilderWidget({
    super.key,
    required this.cubit,
    required this.isReadOnly,
    required this.onSaved,
    this.initalValue,
  });
  final CreateTicketCubit cubit;
  final bool isReadOnly;
  final DiscountCodeModel? initalValue;
  final Function(String code, int discount, DateTime? expire) onSaved;

  @override
  State<PromoBuilderWidget> createState() => _PromoBuilderWidgetState();
}

class _PromoBuilderWidgetState extends State<PromoBuilderWidget> {
  late TextEditingController promoCodeController;
  late TextEditingController promoCodeDiscountController;
  DateTime? expire;

  @override
  void initState() {
    super.initState();
    promoCodeController = TextEditingController();
    promoCodeController.text = widget.initalValue?.code ?? '';
    promoCodeDiscountController = TextEditingController();
    promoCodeDiscountController.text = widget.initalValue?.discountPercentage.toString() ?? '';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _promoBuilder();
  }

  Widget _promoBuilder() {
    return Row(
      children: [
        Expanded(
          child: CommonTextField(
            controller: promoCodeController,
            hintText: 'Promo Code',
            showValidationMessage: false,
            maxLength: 10,
            isReadOnly:
                widget.isReadOnly ||
                widget.cubit.state.createEventModel.isFreeEvent ||
                !widget.cubit.state.createEventModel.offerPreSale,
            validationType: ValidationType.validateAlphaNumeric,
            backgroundColor: AppColors.backgroundWhite,
          ),
        ),
        10.width,
        Expanded(
          child: Column(
            children: [
              CommonDateInputTextField(
                initialValue: widget.initalValue?.expireDate?.toLocal().toString().split(' ')[0],
                isReadOnly:
                    widget.isReadOnly ||
                    widget.cubit.state.createEventModel.isFreeEvent ||
                    !widget.cubit.state.createEventModel.offerPreSale,
                hints: 'Expire Date',
                minDate: DateTime.now(),
                backgroundColor: AppColors.backgroundWhite,
                onChanged: (date) {
                  AppLogger.debug(date?.toIso8601String() ?? '', tag: 'PromoBuilderWidget');
                  expire = date;
                },
              ),
              20.height,
            ],
          ),
        ),
        // SizedBox(
        //   width: 30.w,
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       CommonTextField(
        //         paddingHorizontal: 0,
        //         initialText: '%',
        //         textAlign: TextAlign.center,
        //         showValidationMessage: false,
        //         validationType: ValidationType.validateCurrency,
        //         isReadOnly: true,
        //         borderColor: AppColors.background,
        //         backgroundColor: AppColors.background,
        //       ),
        //       20.height,
        //     ],
        //   ),
        // ),
        10.width,
        SizedBox(
          width: 90.w,
          child: CommonTextField(
            controller: promoCodeDiscountController,
            hintText: '10',
            suffixIcon: Icon(Icons.percent, size: 20.w),
            isReadOnly:
                widget.isReadOnly ||
                widget.cubit.state.createEventModel.isFreeEvent ||
                !widget.cubit.state.createEventModel.offerPreSale,

            onSaved: (value, controller) {
              widget.onSaved(promoCodeController.text, int.tryParse(value.trim()) ?? 0, expire);
            },
            showValidationMessage: false,
            maxLength: 2,
            validationType: ValidationType.validateCurrency,
            backgroundColor: AppColors.backgroundWhite,
          ),
        ),
      ],
    );
  }
}
