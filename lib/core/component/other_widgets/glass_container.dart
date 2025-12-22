import 'dart:ui'; // Needed for ImageFilter.blur
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    this.width,
    this.height,
    required this.child,
    this.borderRadius = 20.0,
    this.sigmaX = 10.0,
    this.sigmaY = 10.0,
    this.opacity = 0.1,
    this.borderColor = Colors.white,
  });

  final double? width;
  final double? height;
  final Widget child;
  final double borderRadius;
  final double sigmaX;
  final double sigmaY;
  final double opacity;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    // 1. ClipRRect ensures the blur effect is contained within the rounded corners.
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        // 2. BackdropFilter applies the blur effect to the background content.
        filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            // 3. Decoration for the glass appearance (color, transparency, border).
            color: Colors.white.withOpacity(opacity),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              // 4. Subtle white border often enhances the glass look.
              color: borderColor.withOpacity(0.2),
              width: 1.0,
            ),
          ),
          // 5. Padding to provide space for the content (child widget).
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );
  }
}
