import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/common/auth/cubit/auth_cubit.dart';
import 'package:swoony/common/notifications/cubit/notification_cubit.dart';
import 'package:swoony/common/notifications/firebase/firebase_notification_handler.dart'
    show FirebaseNotificationHandler;
import 'package:swoony/core/config/languages/cubit/language_cubit.dart';
import 'package:swoony/core/config/languages/cubit/language_state.dart';
import 'package:swoony/core/config/languages/l10n/app_localizations.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/config/route/app_router_observer.dart';

import 'package:swoony/core/config/theme/cubit/theme_cubit.dart';
import 'package:swoony/core/config/theme/cubit/theme_state.dart';
import 'package:swoony/core/config/theme/dark_theme.dart';
import 'package:swoony/core/config/theme/system_theme_listener.dart';
import 'package:swoony/main.dart';

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics(); // or ClampingScrollPhysics, etc.
  }

  @override
  ScrollViewKeyboardDismissBehavior getKeyboardDismissBehavior(
    BuildContext context,
  ) {
    return ScrollViewKeyboardDismissBehavior.onDrag;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(
        428,
        926,
      ), // ✅ Use the size your UI was designed for
      // designSize: const Size(428, 926),
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit()..update(), lazy: false),
          BlocProvider(create: (_) => LanguageCubit()..init(), lazy: false),
          BlocProvider(create: (_) => AuthCubit()), 
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            // FirebaseNotificationHandler.instance.setNotificationCubit(
            //   context.read<NotificationCubit>(),
            // );

            return BlocBuilder<LanguageCubit, LanguageState>(
              builder: (context, languageState) {
                return SystemThemeListener(
                  child: MaterialApp.router( 
                    scaffoldMessengerKey: rootScaffoldMessengerKey,
                    scrollBehavior: CustomScrollBehavior(),
                    debugShowCheckedModeBanner: false,
                    routerConfig: appRouter.config(navigatorObservers: () => [AppRouterObserver()]),
                    themeMode: ThemeMode.light,
                    theme: themeState.themeData,
                    supportedLocales: const [
                      Locale('en'), // English
                    ],
                    localizationsDelegates: const [
                      ...GlobalMaterialLocalizations.delegates,
                      GlobalWidgetsLocalizations.delegate,
                      // Localization delegate for auto-generated messages
                      AppLocalizations.delegate, // Initialize with the locale
                    ],

                    locale: languageState.locale,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
