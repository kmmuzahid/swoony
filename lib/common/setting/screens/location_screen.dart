import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/common/auth/cubit/auth_cubit.dart';
import 'package:swoony/common/auth/model/us_states_model.dart';
import 'package:swoony/common/auth/widgets/state_selector.dart';
import 'package:swoony/core/app_bar/common_app_bar.dart';
import 'package:swoony/core/component/button/common_button.dart';
import 'package:swoony/core/component/image/common_image.dart';
import 'package:swoony/core/component/other_widgets/common_drop_down.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/component/text_field/common_text_field.dart';
import 'package:swoony/core/component/text_field/custom_form.dart';
import 'package:swoony/core/component/text_field/input_helper.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/constants/app_text_styles.dart';
import 'package:swoony/core/utils/extensions/extension.dart';

@RoutePage()
class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String? city;
  String? state;
  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return Scaffold(
      appBar: const CommonAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: CustomForm(
          builder: (context, formKey) => Column(
            children: [
              CommonText(
                textColor: AppColors.primaryColor,
                text: 'Location',
                fontSize: 24,
                fontWeight: FontWeight.w600,
                bottom: 20,
              ).start,
              CommonTextField(
                prefixIcon: _requiredIcon(),
                borderColor: AppColors.disable,
                backgroundColor: AppColors.disable,
                hintText: 'United States',
                isReadOnly: true,
                validationType: ValidationType.notRequired,
                onSaved: (value, controller) {},
              ),
              10.height,
              CommonDropDown<MapEntry<String, String>>(
                hint: AppString.state,
                items: usStates.entries.toList(),
                textStyle: AppTextStyles.bodyMedium,
                borderColor: AppColors.disable,
                initalValue:
                    usStates.isNotEmpty &&
                        authCubit.state.profileModel?.address.country != null &&
                        authCubit.state.profileModel!.address.country.isNotEmpty
                    ? usStates.entries.firstWhere(
                        (element) =>
                            element.key.toLowerCase() ==
                            authCubit.state.profileModel!.address.country.toLowerCase(),
                        orElse: () => usStates.entries.first,
                      )
                    : null,
                enableInitalSelection: false,
                backgroundColor: AppColors.disable,
                isRequired: true,
                onChanged: (states) {
                  state = states?.value;
                },
                nameBuilder: (states) {
                  return states.value;
                },
              ),
              10.height,
              CommonTextField(
                initialText: authCubit.state.profileModel?.address.city,
                prefixIcon: _requiredIcon(),
                borderColor: AppColors.disable,
                backgroundColor: AppColors.disable,
                hintText: AppString.city,
                validationType: ValidationType.validateFullName,
                onSaved: (value, controller) {
                  city = value;
                },
              ),
              20.height,
              CommonButton(
                titleText: 'Update',
                isLoading: context.watch<AuthCubit>().state.isLoading,
                onTap: () {
                  formKey.currentState?.save();
                  if (formKey.currentState?.validate() == true &&
                      authCubit.state.profileModel != null) {
                    final model = authCubit.state.profileModel!;
                    final updatedModel = model.copyWith(
                      address: model.address.copyWith(city: city, street: state),
                    );
                    authCubit.updateProfile(profileModel: updatedModel);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _requiredIcon() =>
      const CommonText(text: '*', textColor: AppColors.warning, fontSize: 20, top: 10);
}
