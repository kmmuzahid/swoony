import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swoony/core/utils/constants/app_colors.dart';
// Using bundled font family 'Selawik' configured in pubspec.yaml

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  fontFamily: 'Selawik',

  // Color scheme aligned with AppColors
  colorScheme: const ColorScheme(
    brightness: Brightness.light,

    primary: Color(0xFFC64C86), // 🟦 Primary: Buttons, active tabs
    onPrimary: Colors.black, // 🔳 Text/icons on primary

    secondary: Color(0xFF8322D3), // 🟢 Secondary: Chips, toggles
    onSecondary: Color(0xFFFFFFFF), // ⚪ Text/icons on secondary

    error: Color(0xFFEF4444), // 🔴 Error containers
    onError: Color(0xFFFFFFFF), // ⚪ Text/icons on error

    surface: Color.fromARGB(255, 255, 255, 255), // 🔲 Base surface: cards, modals
    onSurface: Color(0xFF333333), // 🔳 Text/icons on surface

    surfaceContainerLowest: Color(0xFFF9F9F9), // 🪵 Scaffold background / lowest elevation
    surfaceContainerLow: Color(0xFFF1F4F4), // 🪵 Lower elevation (forms, lists)
    surfaceContainer: Color(0xFFE6F1F1), // 🪵 Mid elevation surfaces
    surfaceContainerHigh: Color(0xFFDDEBEB), // 🪵 Higher elevation
    surfaceContainerHighest: Color(0xFFD2E5E5), // 🪵 Highest elevation: dialogs

    onSurfaceVariant: Color(0xFF666666), // 📝 Subtle/inactive text/icons

    inverseSurface: Color(0xFF333333), // 🔄 Reverse surface (e.g. pull-to-refresh)
    onInverseSurface: Color(0xFFFFFFFF), // ⚪ Text on inverseSurface

    inversePrimary: Color(0xFF4DB8BF), // 🔄 For contrast on dark background

    outline: Color(0xFFA1A1A1), // 📏 Borders, outlines
    outlineVariant: Color(0xFFEDF1F3), // 📏 Lower emphasis outlines

    shadow: Color(0x1F000000), // 🧱 Shadows for elevation
    scrim: Color(0x80000000), // 🚪 Overlays, modals
    surfaceTint: Color(0xFF00B050), // 🎨 Tint applied on elevated surfaces
  ),

  scaffoldBackgroundColor: const Color(0xFFF4F4F4), // 📱 Screen background

  searchBarTheme: SearchBarThemeData(
    hintStyle: const WidgetStatePropertyAll(
      TextStyle(color: Color(0xFF979797), fontStyle: FontStyle.italic),
    ),

    backgroundColor: WidgetStatePropertyAll(AppColors.background),
  ),

  appBarTheme: const AppBarTheme(
    surfaceTintColor: Colors.transparent, // 🧼 Disable elevation tint
    backgroundColor: Colors.white, // 🎛 AppBar surface
    foregroundColor: Color(0xFF333333), // 📝 AppBar text/icon color
    elevation: 0,
  ),

  // Typography mapped to provided scale (Selawik)
  textTheme: TextTheme(
    // Headings
    /// headlineLarge — size: 32.sp, weight: w600, color: #333333
    headlineLarge: TextStyle(
      overflow: TextOverflow.fade,
      color: const Color(0xFF1F1F1F),
      fontSize: 32.sp, // H3 32/38
      height: 38 / 32,
      fontWeight: FontWeight.w600,
    ),

    /// headlineMedium — size: 28.sp, weight: w600, color: #333333
    headlineMedium: TextStyle(
      overflow: TextOverflow.fade,
      color: const Color(0xFF1F1F1F),
      fontSize: 28.sp, // H4 28/34
      height: 34 / 28,
      fontWeight: FontWeight.w600,
    ),

    /// headlineSmall — size: 24.sp, weight: w600, color: #333333
    headlineSmall: TextStyle(
      overflow: TextOverflow.fade,
      color: const Color(0xFF1F1F1F),
      fontSize: 24.sp, // H5 24/28
      height: 28 / 24,
      fontWeight: FontWeight.w600,
    ),

    // Subtitles
    /// titleLarge — size: 18.sp, weight: w600, color: #333333
    titleLarge: TextStyle(
      overflow: TextOverflow.fade,
      color: const Color(0xFF1F1F1F),
      fontSize: 18.sp, // S1 18/28
      height: 28 / 18,
      fontWeight: FontWeight.w600,
    ),

    /// titleMedium — size: 16.sp, weight: w600, color: #333333
    titleMedium: TextStyle(
      overflow: TextOverflow.fade,
      color: const Color(0xFF1F1F1F),
      fontSize: 16.sp, // S2 16/24
      height: 24 / 16,
      fontWeight: FontWeight.w600,
    ),

    // Body
    /// bodyLarge — size: 16.sp, weight: w500, color: #333333
    bodyLarge: TextStyle(
      overflow: TextOverflow.fade,
      color: const Color(0xFF1F1F1F),
      fontSize: 16.sp, // B1 16/24
      height: 24 / 16,
      fontWeight: FontWeight.w500,
    ),

    /// bodyMedium — size: 16.sp, weight: w400, color: #333333
    bodyMedium: TextStyle(
      overflow: TextOverflow.fade,
      color: const Color(0xFF1F1F1F),
      fontSize: 16.sp, // B2 16/24
      height: 24 / 16,
      fontWeight: FontWeight.w400,
    ),

    /// bodySmall — size: 14.sp, weight: w400, color: #858585
    bodySmall: TextStyle(
      overflow: TextOverflow.fade,
      color: const Color(0xFF999999),
      fontSize: 14.sp, // B3 14/20
      height: 20 / 14,
      fontWeight: FontWeight.w400,
    ),

    /// titleSmall — size: 14.sp, weight: w500, color: #333333
    titleSmall: TextStyle(
      overflow: TextOverflow.fade,
      color: const Color(0xFF1F1F1F),
      fontSize: 14.sp, // B4 14/20
      height: 20 / 14,
      fontWeight: FontWeight.w500,
    ),

    // Buttons (label* in M3)
    /// labelLarge — size: 18.sp, weight: w700, color: #FFFFFF
    labelLarge: TextStyle(
      overflow: TextOverflow.fade,
      color: const Color(0xFFFFFFFF),
      fontSize: 18.sp, // Giant 18/24
      height: 24 / 18,
      fontWeight: FontWeight.w700,
    ),

    /// labelMedium — size: 14.sp, weight: w600, color: #FFFFFF
    labelMedium: TextStyle(
      overflow: TextOverflow.fade,
      color: const Color(0xFFFFFFFF),
      fontSize: 14.sp, // Medium 14/16
      height: 16 / 14,
      fontWeight: FontWeight.w600,
    ),

    /// labelSmall — size: 12.sp, weight: w600, color: #FFFFFF
    labelSmall: TextStyle(
      overflow: TextOverflow.fade,
      color: const Color(0xFF999999),
      fontSize: 12.sp, // Tiny 10/12
      height: 14 / 12,
      fontWeight: FontWeight.w600,
    ),
  ),

  cardColor: const Color(0xFFE6F1F1), // 🃏 Card surfaces

  dividerColor: const Color(0xFFCCCCCC), // ➖ Dividers

  textSelectionTheme: TextSelectionThemeData(
    cursorColor: const Color(0xFF00B050),
    selectionColor: const Color(0xFF00B050).withOpacity(0.33),
    selectionHandleColor: const Color(0xFF00B050),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.transparent, // 🧾 TextField background
    border: _buildBorder(color: const Color(0xFFC2C2C2)),
    enabledBorder: _buildBorder(color: const Color(0xFFC2C2C2)),
    focusedBorder: _buildBorder(color: const Color(0xFF00B050)),
    disabledBorder: _buildBorder(color: const Color(0xFFC2C2C2)),
    errorBorder: _buildBorder(color: const Color(0xFFE53935)),
    hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF979797)),
    labelStyle: const TextStyle(fontSize: 14, color: Color(0xffBFBFBF)),
  ),
);

OutlineInputBorder _buildBorder({required Color color}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: color),
  );
}
