import 'package:flutter/material.dart';

/// Author: Km Muzahid
/// Email: km.muzahid@gmail.com
/// Date: 2025-12-22
/// Version: 1.0.0
/// Description: Common wavy gradient container widget for the app
class CommonWavyContainer extends StatelessWidget {
  final double width;
  final double height;
  final List<Color> gradientColors;
  final double opacity;
  final Alignment begin;
  final Alignment end;
  final Widget? child;

  const CommonWavyContainer({
    super.key,
    required this.width,
    required this.height,
    required this.gradientColors,
    this.opacity = 1.0,
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
    this.child,
  }) : assert(gradientColors.length >= 2, 'Gradient must have at least two colors.');

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _WavyTopClipper(),
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: gradientColors, begin: begin, end: end),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _WavyTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double w = size.width;
    final double h = size.height;

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);

    path.lineTo(size.width, 0);
    path.moveTo(w, 0);

    path.quadraticBezierTo(w * 0.75, 0, w * 0.5, h * 0.05);
    path.quadraticBezierTo(w * 0.25, h * 0.1, 0, h * 0.05);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
