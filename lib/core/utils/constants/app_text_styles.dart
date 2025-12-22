import 'package:flutter/material.dart';
import 'package:swoony/core/utils/extensions/extension.dart';

class AppTextStyles {
  // Headings
  /// headlineLarge — mirrors light_theme: 32.sp, w600, color from theme
  static TextStyle? get headlineLarge => getTheme.textTheme.headlineLarge;

  /// headlineMedium — mirrors light_theme: 28.sp, w600, color from theme
  static TextStyle? get headlineMedium => getTheme.textTheme.headlineMedium;

  /// headlineSmall — mirrors light_theme: 24.sp, w600, color from theme
  static TextStyle? get headlineSmall => getTheme.textTheme.headlineSmall;

  // Subtitles
  /// titleLarge — mirrors light_theme: 18.sp, w600, color from theme
  static TextStyle? get titleLarge => getTheme.textTheme.titleLarge;

  /// titleMedium — mirrors light_theme: 16.sp, w600, color from theme
  static TextStyle? get titleMedium => getTheme.textTheme.titleMedium;

  /// titleSmall — mirrors light_theme: 14.sp, w500, color from theme
  static TextStyle? get titleSmall => getTheme.textTheme.titleSmall;

  // Body
  /// bodyLarge — mirrors light_theme: 16.sp, w500, color from theme
  static TextStyle? get bodyLarge => getTheme.textTheme.bodyLarge;

  /// bodyMedium — mirrors light_theme: 16.sp, w400, color from theme
  static TextStyle? get bodyMedium => getTheme.textTheme.bodyMedium;

  /// bodySmall — mirrors light_theme: 14.sp, w400, color from theme
  static TextStyle? get bodySmall => getTheme.textTheme.bodySmall;

  /// bodySmall — mirrors light_theme: 14.sp, w400, color from theme
  static TextStyle? get label =>
      getTheme.textTheme.bodySmall?.copyWith(color: const Color(0xFF6C7278));

  // Buttons / Labels
  /// labelLarge — mirrors light_theme: 18.sp, w700, color from theme
  static TextStyle? get labelLarge => getTheme.textTheme.labelLarge;

  /// labelMedium — mirrors light_theme: 14.sp, w600, color from theme
  static TextStyle? get labelMedium => getTheme.textTheme.labelMedium;

  /// labelSmall — mirrors light_theme: 12.sp, w600, color from theme
  static TextStyle? get labelSmall => getTheme.textTheme.labelSmall;
}
