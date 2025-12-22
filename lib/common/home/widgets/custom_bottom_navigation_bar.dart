import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/common/auth/cubit/auth_cubit.dart';
import 'package:swoony/common/auth/model/user_login_info_model.dart';
import 'package:swoony/common/chat/cubit/chat_list/chat_list_cubit.dart';
import 'package:swoony/common/home/bloc/home_cubit.dart';
import 'package:swoony/core/component/image/common_image.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/extensions/extension.dart';
import 'package:swoony/core/utils/log/app_log.dart';
import 'package:swoony/gen/assets.gen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key, required this.homeState});
  final HomeState homeState;

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentIndex = 0;
  late HomeCubit _homeCubit;
  late Role role;

  @override
  void initState() {
    super.initState();
    _homeCubit = context.read<HomeCubit>();
  }

  List<BottomNavigationBarItem> organizer() => [
    _navBuilder(index: 0, image: Assets.images.home),
    _navBuilder(index: 1, image: Assets.images.event),
    _navBuilder(index: 2, image: Assets.images.chat),
    _navBuilder(index: 3, image: Assets.images.user),
  ];

  List<BottomNavigationBarItem> attendee() => [
    _navBuilder(index: 0, image: Assets.images.home),
    _navBuilder(index: 1, image: Assets.images.event),
    _navBuilder(index: 2, image: Assets.images.connection),
    _navBuilder(index: 3, image: Assets.images.user),
  ];

  @override
  Widget build(BuildContext context) {
    role = context.read<AuthCubit>().state.userLoginInfoModel.role ?? Role.ATTENDEE;
    final radius = Radius.circular(20.r);
    final bgColor =
        Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
        Theme.of(context).colorScheme.surface;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: radius, topRight: radius),
        color: bgColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (role == Role.ORGANIZER) ...[
            10.height,
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              height: 2,
              color: AppColors.primaryColor,
            ),
            2.height,
          ],
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            elevation: 0,
            backgroundColor: bgColor,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (index) => setState(() {
              _currentIndex = index;
              _homeCubit.changeIndex(index);
              final bool isChat = role == Role.ORGANIZER ? index == 3 : index == 4;
              if (isChat) {
                _homeCubit.resetMessageCount();
                // context.read<ChatListCubit>().init();
              }
            }),
            items: role == Role.ORGANIZER ? organizer() : attendee(),
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _navBuilder({required int index, required String image}) {
    final bool isSelected = index == _currentIndex;
    final bool isChat = role == Role.ORGANIZER ? index == 3 : index == 4;
    final Color color = isSelected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).iconTheme.color ?? Colors.grey;
    final icon = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonImage(size: 25, fill: BoxFit.contain, imageSrc: image, imageColor: color),
        const SizedBox(height: 4),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          height: 2,
          width: isSelected ? 20 : 0,
          decoration: BoxDecoration(
            color: isSelected ? color : Colors.transparent,
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ],
    );
    return BottomNavigationBarItem(
      label: '',
      icon: isChat && widget.homeState.unreadMessage > 0
          ? (Badge.count(count: widget.homeState.unreadMessage, child: icon))
          : icon,
    );
  }
}
