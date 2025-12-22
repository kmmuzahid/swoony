import 'package:auto_route/auto_route.dart';
import 'package:swoony/core/app_bar/common_app_bar.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: CommonAppBar(title: AppString.termsOfuse));
}
