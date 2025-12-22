import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swoony/common/auth/cubit/auth_cubit.dart';
import 'package:swoony/common/auth/cubit/auth_state.dart';
import 'package:swoony/common/auth/model/us_states_model.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/constants/app_text_styles.dart';

class StateSelector extends StatelessWidget {
  const StateSelector({super.key, this.onChanged});
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final currentStateCode = state.signUpModel.state;

        return DropdownButtonFormField<String>(
          value: currentStateCode.isNotEmpty ? currentStateCode : null,
          // hint: const Text('Select State'),
          items: usStates.entries.map<DropdownMenuItem<String>>((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Text('${entry.value} (${entry.key})'),
            );
          }).toList(),
          onChanged:
              onChanged ??
              (String? newValue) {
            if (newValue != null) {
              context.read<AuthCubit>().onChangeSignUpModel(
                state.signUpModel.copyWith(state: newValue),
              );
            }
          },
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: AppColors.disable,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.disable),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.disable),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
            hintText: 'Select State',
            hintStyle: TextStyle(color: AppColors.disable, fontStyle: FontStyle.italic),
          ),
          style: AppTextStyles.bodyMedium,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a state';
            }
            return null;
          },
        );
      },
    );
  }
}
