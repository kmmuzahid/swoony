import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,

  colorScheme: const ColorScheme(
    brightness: Brightness.dark,

    primary: Color(0xFF00B050), // Brand green
    onPrimary: Color(0xFFFFFFFF), // White text on primary in dark mode

    secondary: Color(0xFF00B050),
    onSecondary: Color(0xFFFFFFFF),

    error: Color(0xFFFF6B6B),
    onError: Color(0xFF000000),

    surface: Color(0xFF1A1A1A),
    onSurface: Color(0xFFEFEFEF),

    surfaceContainerLowest: Color(0xFF121212),
    surfaceContainerLow: Color(0xFF1C1C1C),
    surfaceContainer: Color(0xFF222222),
    surfaceContainerHigh: Color(0xFF2A2A2A),
    surfaceContainerHighest: Color(0xFF303030),

    onSurfaceVariant: Color(0xFFAAAAAA),

    inverseSurface: Color(0xFFEFEFEF),
    onInverseSurface: Color(0xFF1A1A1A),

    inversePrimary: Color(0xFF4DB8BF),

    outline: Color(0xFF444444),
    outlineVariant: Color(0xFF2D2D2D),

    shadow: Color(0xBF000000),
    scrim: Color(0x99000000),
    surfaceTint: Color(0xFF00B050),
  ),

  scaffoldBackgroundColor: const Color(0xFF121212),
  appBarTheme: const AppBarTheme(
    surfaceTintColor: Colors.transparent,
    backgroundColor: Color(0xFF121212),
    foregroundColor: Color(0xFFEFEFEF),
    elevation: 0,
  ),

  cardColor: const Color(0xFF1E1E1E),

  dividerColor: const Color(0xFF2C2C2C),

  // Typography (mirrors light theme sizes/weights, with dark colors)
  textTheme: TextTheme(
    // Headings
    /// headlineLarge — size: 32.sp, weight: w600, color: #EFEFEF
    headlineLarge: TextStyle(
      overflow: TextOverflow.fade,
      color: const Color(0xFFEFEFEF),
      fontSize: 32.sp,
      height: 38 / 32,
      fontWeight: FontWeight.w600,
    ),

    /// headlineMedium — size: 28.sp, weight: w600, color: #EFEFEF
    headlineMedium: TextStyle(
      overflow: TextOverflow.fade,
      color: const Color(0xFFEFEFEF),
      fontSize: 28.sp,
      height: 34 / 28,
      fontWeight: FontWeight.w600,
    ),

    /// headlineSmall — size: 24.sp, weight: w600, color: #EFEFEF
    headlineSmall: TextStyle(
      overflow: TextOverflow.fade,
      color: const Color(0xFFEFEFEF),
      fontSize: 24.sp,
      height: 28 / 24,
      fontWeight: FontWeight.w600,
    ),

    // Subtitles
    /// titleLarge — size: 18.sp, weight: w600, color: #EFEFEF
    titleLarge: TextStyle(
      overflow: TextOverflow.fade,
      color: const Color(0xFFEFEFEF),
      fontSize: 18.sp,
      height: 28 / 18,
      fontWeight: FontWeight.w600,
    ),

    /// titleMedium — size: 16.sp, weight: w600, color: #EFEFEF
    titleMedium: TextStyle(
      overflow: TextOverflow.fade,
      color: const Color(0xFFEFEFEF),
      fontSize: 16.sp,
      height: 24 / 16,
      fontWeight: FontWeight.w600,
    ),

    // Body
    /// bodyLarge — size: 16.sp, weight: w500, color: #EFEFEF
    bodyLarge: TextStyle(
      overflow: TextOverflow.fade,
      color: const Color(0xFFEFEFEF),
      fontSize: 16.sp,
      height: 24 / 16,
      fontWeight: FontWeight.w500,
    ),

    /// bodyMedium — size: 16.sp, weight: w400, color: #CCCCCC
    bodyMedium: TextStyle(
      overflow: TextOverflow.fade,
      color: const Color(0xFFCCCCCC),
      fontSize: 16.sp,
      height: 24 / 16,
      fontWeight: FontWeight.w400,
    ),
    /// bodySmall — size: 14.sp, weight: w400, color: #999999
    bodySmall: TextStyle(
      overflow: TextOverflow.fade,
      color: const Color(0xFF999999),
      fontSize: 14.sp,
      height: 20 / 14,
      fontWeight: FontWeight.w400,
    ),
    /// titleSmall — size: 14.sp, weight: w500, color: #EFEFEF
    titleSmall: TextStyle(
      overflow: TextOverflow.fade,
      color: const Color(0xFFEFEFEF),
      fontSize: 14.sp,
      height: 20 / 14,
      fontWeight: FontWeight.w500,
    ),

    // Buttons (label*)
    /// labelLarge — size: 18.sp, weight: w700, color: #FFFFFF
    labelLarge: TextStyle(
      overflow: TextOverflow.fade,
      color: const Color(0xFFFFFFFF),
      fontSize: 18.sp,
      height: 24 / 18,
      fontWeight: FontWeight.w700,
    ),
    /// labelMedium — size: 14.sp, weight: w600, color: #FFFFFF
    labelMedium: TextStyle(
      overflow: TextOverflow.fade,
      color: const Color(0xFFFFFFFF),
      fontSize: 14.sp,
      height: 16 / 14,
      fontWeight: FontWeight.w600,
    ),
    /// labelSmall — size: 12.sp, weight: w600, color: #FFFFFF
    labelSmall: TextStyle(
      overflow: TextOverflow.fade,
      color: const Color(0xFFFFFFFF),
      fontSize: 12.sp,
      height: 14 / 12,
      fontWeight: FontWeight.w600,
    ),
  ),

  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color(0xFF00B050),
    selectionColor: Color(0x5536CFCF),
    selectionHandleColor: Color(0xFF00B050),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF1E1E1E),
    border: _buildBorder(color: const Color(0xFF2D2D2D)),
    enabledBorder: _buildBorder(color: const Color(0xFF2D2D2D)),
    focusedBorder: _buildBorder(color: const Color(0xFF00B050)),
    disabledBorder: _buildBorder(color: const Color(0xFF2D2D2D)),
    errorBorder: _buildBorder(color: const Color(0xFFFF6B6B)),
    hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF888888)),
    labelStyle: const TextStyle(
      fontSize: 14,
      color: Color(0xFFAAAAAA),
    ),
  ),
)
;

OutlineInputBorder _buildBorder({required Color color}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: color),
  );
}
