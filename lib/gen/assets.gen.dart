// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconGen {
  const $AssetsIconGen();

  /// File path: assets/icon/icon.png
  AssetGenImage get icon => const AssetGenImage('assets/icon/icon.png');

  /// List of all assets
  List<AssetGenImage> get values => [icon];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/app_icon.svg
  String get appIcon => 'assets/images/app_icon.svg';

  /// File path: assets/images/apple.svg
  String get apple => 'assets/images/apple.svg';

  /// File path: assets/images/back_icon.svg
  String get backIcon => 'assets/images/back_icon.svg';

  /// File path: assets/images/camera_circular.svg
  String get cameraCircular => 'assets/images/camera_circular.svg';

  /// File path: assets/images/chat.svg
  String get chat => 'assets/images/chat.svg';

  /// File path: assets/images/close_circle.svg
  String get closeCircle => 'assets/images/close_circle.svg';

  /// File path: assets/images/congrats_icon.svg
  String get congratsIcon => 'assets/images/congrats_icon.svg';

  /// File path: assets/images/connection.svg
  String get connection => 'assets/images/connection.svg';

  /// File path: assets/images/event.svg
  String get event => 'assets/images/event.svg';

  /// File path: assets/images/facebook.svg
  String get facebook => 'assets/images/facebook.svg';

  /// File path: assets/images/favoourtie_active.svg
  String get favoourtieActive => 'assets/images/favoourtie_active.svg';

  /// File path: assets/images/favorite_circle.svg
  String get favoriteCircle => 'assets/images/favorite_circle.svg';

  /// File path: assets/images/favourite_deactive.svg
  String get favouriteDeactive => 'assets/images/favourite_deactive.svg';

  /// File path: assets/images/google.svg
  String get google => 'assets/images/google.svg';

  /// File path: assets/images/home.svg
  String get home => 'assets/images/home.svg';

  /// File path: assets/images/likedin.svg
  String get likedin => 'assets/images/likedin.svg';

  /// File path: assets/images/onboard_1.png
  AssetGenImage get onboard1 =>
      const AssetGenImage('assets/images/onboard_1.png');

  /// File path: assets/images/onboard_2.svg
  String get onboard2 => 'assets/images/onboard_2.svg';

  /// File path: assets/images/play.svg
  String get play => 'assets/images/play.svg';

  /// File path: assets/images/qr_code.svg
  String get qrCode => 'assets/images/qr_code.svg';

  /// File path: assets/images/splash_name.svg
  String get splashName => 'assets/images/splash_name.svg';

  /// File path: assets/images/submit_status.svg
  String get submitStatus => 'assets/images/submit_status.svg';

  /// File path: assets/images/telegram.svg
  String get telegram => 'assets/images/telegram.svg';

  /// File path: assets/images/user.svg
  String get user => 'assets/images/user.svg';

  /// List of all assets
  List<dynamic> get values => [
    appIcon,
    apple,
    backIcon,
    cameraCircular,
    chat,
    closeCircle,
    congratsIcon,
    connection,
    event,
    facebook,
    favoourtieActive,
    favoriteCircle,
    favouriteDeactive,
    google,
    home,
    likedin,
    onboard1,
    onboard2,
    play,
    qrCode,
    splashName,
    submitStatus,
    telegram,
    user,
  ];
}

class $AssetsSampleGen {
  const $AssetsSampleGen();

  /// File path: assets/sample/sample_1.svg
  String get sample1 => 'assets/sample/sample_1.svg';

  /// File path: assets/sample/sample_2.jpg
  AssetGenImage get sample2 =>
      const AssetGenImage('assets/sample/sample_2.jpg');

  /// List of all assets
  List<dynamic> get values => [sample1, sample2];
}

class Assets {
  const Assets._();

  static const String aEnv = '.env';
  static const $AssetsIconGen icon = $AssetsIconGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSampleGen sample = $AssetsSampleGen();

  /// List of all assets
  static List<String> get values => [aEnv];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
