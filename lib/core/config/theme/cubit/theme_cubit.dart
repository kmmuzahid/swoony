import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:swoony/core/config/theme/light_theme.dart';
import 'package:swoony/core/utils/log/app_log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dark_theme.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(themeData: lightTheme));
  Future<void> update({Brightness? brightness}) async {
    brightness ??= WidgetsBinding.instance.platformDispatcher.platformBrightness;
    // emit(ThemeState(themeData: brightness == Brightness.dark ? darkTheme : lightTheme));
    emit(ThemeState(themeData: lightTheme));
    AppLogger.debug('Theme has been changed', tag: 'ThemeCubit');
  }
}
