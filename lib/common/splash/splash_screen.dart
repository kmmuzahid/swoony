import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swoony/common/auth/cubit/auth_cubit.dart';
import 'package:swoony/core/component/image/common_image.dart';
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/config/route/app_router.gr.dart';
import 'package:swoony/core/utils/app_utils.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/extensions/extension.dart';
import 'package:swoony/gen/assets.gen.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Use context safely here
      Utils.deviceSize = MediaQuery.of(context).size;
      context.read<AuthCubit>().init();

      // Optional: Navigate after splash
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.containerGradient()),
        child: Column(
          children: [
            const Spacer(),
            CommonImage(imageSrc: Assets.images.appIcon, width: 208, height: 142).center,
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 108),
              child: CommonImage(imageSrc: Assets.images.splashName, fill: BoxFit.fitWidth).center,
            ),
            65.height,
          ],
        ),
      ),
    );
  }
}
