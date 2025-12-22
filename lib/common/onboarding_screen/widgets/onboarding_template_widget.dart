// Reusable Onboarding Template Widget
import 'package:flutter/material.dart';
import 'package:swoony/core/component/image/common_image.dart';

class OnboardingTemplateWidget extends StatelessWidget {
  final String imageUrl;
  final String? imageAsset;
  final List<Color> gradientColors;
  final double imageHeightRatio;
  final double curveHeightRatio;
  final CurveStyle curveStyle;
  final Widget child; // 🔥 Required child

  const OnboardingTemplateWidget({
    Key? key,
    this.imageUrl = '',
    this.imageAsset,
    required this.gradientColors,
    required this.child,
    this.imageHeightRatio = 0.6,
    this.curveHeightRatio = 0.45,
    this.curveStyle = CurveStyle.wave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: height * imageHeightRatio,
            child: CommonImage(imageSrc: imageAsset!, fill: BoxFit.cover),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: height * imageHeightRatio,
            child: Container(color: Colors.black.withAlpha(100)),
          ),

          // Curved Gradient Section
          Positioned(
            top: height * curveHeightRatio,
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipPath(
              clipper: _getCurveClipper(curveStyle),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: gradientColors,
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(child: SafeArea(child: child)),
        ],
      ),
    );
  }

  CustomClipper<Path> _getCurveClipper(CurveStyle style) {
    switch (style) {
      case CurveStyle.wave:
        return WaveCurveClipper();
      case CurveStyle.diagonal:
        return DiagonalCurveClipper();
      case CurveStyle.smooth:
        return SmoothCurveClipper();
    }
  }
}

// Curve Style Enum
enum CurveStyle { wave, diagonal, smooth }

// Wave Curve Clipper - Enhanced with more dramatic curves
class WaveCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start from top right
    path.moveTo(size.width, size.height * 0.11);

    // First wave (reversed)
    path.quadraticBezierTo(size.width * 0.75, 0, size.width * 0.5, size.height * 0.10);

    // Second wave (reversed)
    path.quadraticBezierTo(size.width * 0.22, size.height * 0.24, 0, size.height * 0.08);

    // Left side down
    path.lineTo(0, size.height);

    // Bottom
    path.lineTo(size.width, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Diagonal Curve Clipper - Enhanced with smooth curve
class DiagonalCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start from top right
    path.moveTo(size.width, size.height * 0.15);

    // Curved diagonal (reversed)
    path.quadraticBezierTo(size.width * 0.5, -size.height * 0.05, 0, size.height * 0.05);

    // Left side down
    path.lineTo(0, size.height);

    // Bottom
    path.lineTo(size.width, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Smooth Curve Clipper - Enhanced with elegant arc
class SmoothCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start from top right
    path.moveTo(size.width, size.height * 0.2);

    // Smooth cubic curve (reversed)
    path.cubicTo(
      size.width * 0.75,
      -size.height * 0.05,
      size.width * 0.25,
      size.height * 0.1,
      0,
      size.height * 0.05,
    );

    // Left side down
    path.lineTo(0, size.height);

    // Bottom
    path.lineTo(size.width, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
