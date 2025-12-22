// File: home_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swoony/common/auth/cubit/auth_cubit.dart';
import 'package:swoony/common/auth/model/user_login_info_model.dart';
import 'package:swoony/common/chat/cubit/chat/chat_cubit.dart';
import 'package:swoony/common/chat/screens/chat_list_screen.dart';
import 'package:swoony/common/home/bloc/home_cubit.dart';
import 'package:swoony/common/home/widgets/custom_bottom_navigation_bar.dart';
import 'package:swoony/common/setting/screens/setting_screen.dart';
import 'package:swoony/common/tickets/model/ticket_model.dart';
import 'package:swoony/common/tickets/screens/tickets_screen.dart';
import 'package:swoony/core/config/bloc/cubit_scope.dart';
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/config/route/app_router.gr.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';

import '../../chat/cubit/chat_list/chat_list_cubit.dart';

//  AutoRoute(page: HomeRoute.page),

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  //user page list
  List<Widget> userPagesList(HomeState homeState) => [];

  //organizer page list
  List<Widget> oranizerPageList(HomeState homeState) => [
    const SettingScreen(),
    const ChatListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit()..init(), lazy: false),
        // BlocProvider(create: (_) => ChatListCubit()),
      ],
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(systemStatusBarContrastEnforced: true),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: AppColors.background,
              body: SafeArea(
                child: context.read<AuthCubit>().state.userLoginInfoModel.role == Role.ORGANIZER
                    ? oranizerPageList(state)[state.currentIndex]
                    : userPagesList(state)[state.currentIndex],
              ),
              bottomNavigationBar: CustomBottomNavigationBar(homeState: state),
            );
          },
        ),
      ),
    );
  }
}
