import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swoony/core/config/api/api_end_point.dart';
import 'package:swoony/core/utils/log/app_log.dart';
import 'package:swoony/gen/assets.gen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CommonImage extends StatelessWidget {
  const CommonImage({
    required this.imageSrc,
    this.imageColor,
    this.height,
    this.borderRadius = 0,
    this.width,
    this.size,
    this.fill = BoxFit.cover,
    this.defaultImage,
    this.enableGrayscale = false,
    super.key,
  });
  final String imageSrc;
  final String? defaultImage;
  final Color? imageColor;
  final double? height;
  final double? width;
  final double borderRadius;
  final double? size;
  final bool enableGrayscale;
  final BoxFit fill;

  void checkImageType() {}

  @override
  Widget build(BuildContext context) {
    if (imageSrc.isEmpty) return const SizedBox();

    if (!enableGrayscale) return getImage();

    return ColorFiltered(
      colorFilter: const ColorFilter.matrix(<double>[
        0.2126, 0.7152, 0.0722, 0, 0, // red
        0.2126, 0.7152, 0.0722, 0, 0, // green
        0.2126, 0.7152, 0.0722, 0, 0, // blue
        0, 0, 0, 1, 0, // alpha
      ]),
      child: getImage(),
    );
  }

  Widget getImage() {
    if (imageSrc.startsWith('assets/svg') || imageSrc.endsWith('.svg')) {
      return _buildSvgImage();
    } else if (imageSrc.startsWith('assets/')) {
      return _buildPngImage();
    } else if (imageSrc.startsWith('http') || imageSrc.startsWith('/image')) {
      return _buildNetworkImage();
    } else {
      return _buildFileImage();
    }
  }

  Widget _buildErrorWidget() {
    return Image.asset(defaultImage ?? Assets.images.appIcon);
  }

  Widget _buildNetworkImage() {
    final path = imageSrc.startsWith('http') ? imageSrc : '${ApiEndPoint.instance.domain}$imageSrc';
    return CachedNetworkImage(
      height: size ?? height,
      width: size ?? width,
      imageUrl: path,
      fit: fill,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          image: DecorationImage(image: imageProvider, fit: fill),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) {
        return Skeletonizer(
          enabled: (downloadProgress.progress ?? 0) < 1,
          child: CommonImage(imageSrc: Assets.images.appIcon),
        );
      },
      errorWidget: (context, url, error) {
        AppLogger.error(error.toString(), tag: 'Common Image');

        return _buildErrorWidget();
      },
    );
  }

  Widget _buildSvgImage() {
    return SvgPicture.asset(
      imageSrc,
      colorFilter: imageColor != null ? ColorFilter.mode(imageColor!, BlendMode.srcIn) : null,
      height: size ?? height,
      width: size ?? width,
      fit: fill,
    );
  }

  Widget _buildFileImage() {
    return Image.file(
      File(imageSrc),
      color: imageColor,
      height: size ?? height,
      width: size ?? width,
      fit: fill,
    );
  }

  Widget _buildPngImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        imageSrc,
        color: imageColor,
        height: size ?? height,
        width: size ?? width,
        fit: fill,
        errorBuilder: (context, error, stackTrace) {
          AppLogger.error(error.toString(), tag: 'Common Image');
          return _buildErrorWidget();
        },
      ),
    );
  }
}
