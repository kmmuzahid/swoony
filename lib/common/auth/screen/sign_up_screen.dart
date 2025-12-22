import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swoony/common/auth/cubit/auth_cubit.dart';
import 'package:swoony/core/app_bar/common_app_bar.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import '../widgets/sign_up_all_filed_widget.dart';

@RoutePage()
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: CommonAppBar(
        title: '',
        actions: const [],
        backgroundColor: AppColors.backgroundWhite,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SignUpAllField(state: context.read<AuthCubit>().state),
      ),
    );
  }
}
