import 'package:flutter/material.dart';
import 'package:swoony/core/utils/extensions/extension.dart';

/// Author: Km Muzahid
/// Email: km.muzahid@gmail.com
/// Date: 2025-12-22
/// Version: 1.0.0
/// Description: Dual field row widget for the app
class DualFieldRow extends StatelessWidget {
  const DualFieldRow({
    required this.left,
    required this.right,
    super.key,
    this.enableSpacer = true,
    this.space = 10,
    this.spaceBetween = false
  });
  final Widget left;
  final Widget right;
  final bool enableSpacer;
  final double space;
  final bool spaceBetween;

  @override
  Widget build(BuildContext context) {
    if (spaceBetween) {
      return Row(children: [left, const Spacer(), right]).paddingOnly(bottom: 10);
    }
    return (enableSpacer ? _withSpacer() : _withoutSpacer()).paddingOnly(bottom: 10);
  }

  Row _withoutSpacer() {
    return Row(
      children: [
        left,
        SizedBox(width: space),
        Expanded(child: right),
      ],
    );
  }

  Row _withSpacer() {
    return Row(
      children: [
        Expanded(child: left),
        SizedBox(width: space),
        Expanded(child: right),
      ],
    );
  }
}
