import 'package:flutter/material.dart';
import 'package:swoony/core/utils/extensions/extension.dart';

class AppColors {
  static List<Color> predefinedColors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
    Colors.white,
  ];

  static const Color transparent = Colors.transparent;
  // Theme-sourced colors (use getters to avoid early init and allow live theme changes)
  static Color get surfaceBG => getTheme.colorScheme.surface;
  // DEPRECATED: use surfaceBG
  static Color get serfeceBG => surfaceBG;
  static Color get primaryText => getTheme.colorScheme.onSurface;
  // Brand primary (sourced from ColorScheme.primary for M3 correctness)
  static Color get primaryColor => getTheme.colorScheme.primary;
  static Color get primary100 => const Color(0xFFB0DCBD);
  static Color get onPrimaryColor => getTheme.colorScheme.onPrimary;
  static const textWhite = Color(0xffFFFFFF);
  // Neutrals (some mapped to theme for better consistency)
  static Color get iconColorBlack => getTheme.colorScheme.onSurface;
  // Surfaces
  static Color get secondaryColor => getTheme.colorScheme.surface;
  // Buttons / states
  static Color get primaryButton => getTheme.colorScheme.primary;
  static Color get secondaryText => getTheme.colorScheme.onSurfaceVariant;
  static Color get disable => getTheme.colorScheme.outlineVariant;
  static Color get outlineColor => getTheme.colorScheme.outline;
  static const primary50 = Color(0xFFE6F4EA);
  static const success = Color(0xFF22C55E);
  static const warning = Color(0xFFF59E0B);
  static Color get error => getTheme.colorScheme.error;
  static Color get background => const Color(0xFFF4F4F4);
  static Color get greay500 => const Color(0xFF333333);
  static Color get white300 => const Color(0xFFF0F0F0);
  static Color get backgroundWhite => const Color.fromARGB(255, 255, 255, 255);
  static Color get greay50 => const Color(0xFFEBEBEB);
  static Color get greay100 => const Color(0xFFC0C0C0);
  static Color get greay200 => const Color(0xFFA1A1A1);
  static Color get greay => const Color(0xFF979797);
  static Color get greay300 => const Color(0xFF767676);
  static Color get greay400 => const Color(0xFF5C5C5C);
  static Color get white100 => const Color(0xFFF2F2F2);
  static Color get white400 => const Color(0xFFEDEDED);
  static Color get white500 => const Color(0xFFE8E8E8);
  static Color get white600 => const Color(0xFFD3D3D3);
  static Color get white50 => const Color(0xFFEBEBEB);

  //swoony
  static LinearGradient brandButton({
    AlignmentGeometry begin = Alignment.topCenter,
    AlignmentGeometry end = Alignment.bottomCenter,
  }) => LinearGradient(begin: begin, end: end, colors: [Color(0xFFFF6B60), Color(0xFFFF1A60)]);

  static LinearGradient secondaryBrandButton({
    AlignmentGeometry begin = Alignment.topCenter,
    AlignmentGeometry end = Alignment.bottomCenter,
  }) => LinearGradient(
    begin: begin,
    end: end,
    colors: [Color(0xFFFF6B60), Color(0xFFFF1A60), Color(0xFFFF1A60)],
  );

  static LinearGradient containerGradient() {
    final colorA = Color(0xFFFF947D).withValues(alpha: .1);
    final colorB = Color(0xFFFF1A60).withValues(alpha: .1);
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: const [0, .3, .8, .98],
      colors: [colorA, Color.lerp(colorA, colorB, .5)!, colorB, colorA],
    );
  }

  static const notification = Color(0xFFF03971);
  static const cta = Color(0xFFF8792B);
  static const highlights = Color(0xFFF8BE53);
  static const bgColor = Color(0xFFEDC8D9);
  static const subText = Color(0xFF999999);
}
