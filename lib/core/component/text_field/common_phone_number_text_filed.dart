import 'package:swoony/core/component/text_field/input_helper.dart';
import 'package:swoony/core/utils/extensions/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field_v2/intl_phone_field.dart';
import 'package:intl_phone_field_v2/phone_number.dart';

class CommonPhoneNumberTextFiled extends StatelessWidget {
  const CommonPhoneNumberTextFiled({
    required this.controller,
    required this.countryChange,
    super.key,
  });

  final TextEditingController controller;
  final Function(PhoneNumber value) countryChange;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      initialCountryCode: 'US',
      controller: controller,
      validator: (value) =>
          InputHelper.validate(ValidationType.validatePhone, value?.completeNumberWithPlus ?? ''),
      style: getTheme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 16.sp),
      keyboardType: InputHelper.getKeyboardType(ValidationType.validatePhone),
      inputFormatters: InputHelper.getInputFormatters(ValidationType.validatePhone),

      decoration: InputDecoration(
        labelText: '',
        prefixIcon: Container(
          padding: const EdgeInsets.only(right: 8),
          decoration: const BoxDecoration(
            border: Border(right: BorderSide(color: Colors.grey)),
          ),
        ),
      ),
      flagsButtonPadding: const EdgeInsets.only(left: 8, right: 8),
      dropdownIconPosition: IconPosition.trailing,
      dropdownTextStyle: getTheme.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
      ),
      // disableLengthCheck: false,
      textAlignVertical: TextAlignVertical.center,
      onChanged: countryChange,
    );
  }
}
