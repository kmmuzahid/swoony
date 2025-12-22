import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/app.dart';
import 'package:swoony/common/notifications/firebase/firebase_notification_handler.dart'
    show FirebaseNotificationHandler;
import 'package:swoony/core/component/text/common_text.dart';
import 'package:swoony/core/config/bloc/app_bloc_observer.dart';
import 'package:swoony/core/config/dependency/dependency_injection.dart';
import 'package:swoony/core/config/route/app_router.dart';
import 'package:swoony/core/config/storage/storage_service.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
import 'package:swoony/core/utils/extensions/extension.dart';
import 'package:flutter/scheduler.dart';

//git add remote client
//git remote set-url client https://githubAccessToken@github.com/gallorobbie7-cmd/The-Leaderboard-App.git

//flutter pub run build_runner build --delete-conflicting-outputs
//dart run build_runner watch
//create a new feature through
//emulator -list-avds
//emulator -avd Pixel_9a

//dart run flutter_launcher_icons:generate

//rename import//Get-ChildItem -Recurse -Filter "*.dart" | ForEach-Object { (Get-Content $_.FullName) -replace 'package:bai_serve_agent', 'package:bai_serve_agent' | Set-Content $_.FullName }
//git remote -v
//git push sta main
//git push origin main

//push notification
//npm install -g firebase-tools
//logout
//firebase logout

//firebase login
//flutterfire configure

//masion init
//mason add bloc_feature
// mason make getx_feature --name packageName
// mason make bloc_feature --name packageName
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

enum SnackBarType { success, error, warning }

String versionCode = '1.0.0';

void main() async {
  Bloc.observer = AppBlocObserver();

  ErrorWidget.builder = (FlutterErrorDetails details) {
    debugPrint('Flutter error: ${details.exception}');
    return const Center(child: Text('Oops, something went wrong'));
  };

  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  await init();
  await getIt.isReady<StorageService>();
  // await Firebase.initializeApp();
  // await FirebaseNotificationHandler.instance.init();
  runApp(const MyApp());
}

Future<void> init() async {
  _diInit();
  await Future.wait([dotenv.load()]);
}

void _diInit() {
  final DependencyInjection dI = DependencyInjection();
  dI.dependencies();
}

void showSnackBar(String text, {required SnackBarType type}) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    final scaffoldMessenger = rootScaffoldMessengerKey.currentState;
    if (scaffoldMessenger == null) return;

    scaffoldMessenger.hideCurrentSnackBar();

    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: const TextStyle(color: AppColors.textWhite, fontWeight: FontWeight.bold),
        ),
        backgroundColor: _getSnackBarColor(type),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 2),
        elevation: 4,
      ),
    );
  });
}

Color _getSnackBarColor(SnackBarType type) {
  switch (type) {
    case SnackBarType.success:
      return AppColors.primaryColor;
    case SnackBarType.error:
      return AppColors.error;
    case SnackBarType.warning:
      return AppColors.warning;
    default:
      return AppColors.primaryColor;
  }
}
