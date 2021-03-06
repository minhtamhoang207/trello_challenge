/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/img_login.jpg
  AssetGenImage get imgLogin =>
      const AssetGenImage('assets/images/img_login.jpg');
}

class $AssetsLottiesGen {
  const $AssetsLottiesGen();

  /// File path: assets/lotties/img_login.json
  String get imgLogin => 'assets/lotties/img_login.json';

  /// File path: assets/lotties/lottie_empty_box.json
  String get lottieEmptyBox => 'assets/lotties/lottie_empty_box.json';

  /// File path: assets/lotties/lottie_error.json
  String get lottieError => 'assets/lotties/lottie_error.json';

  /// File path: assets/lotties/lottie_loading.json
  String get lottieLoading => 'assets/lotties/lottie_loading.json';
}

class $AssetsSvgsGen {
  const $AssetsSvgsGen();

  /// File path: assets/svgs/ic_dot_menu.svg
  String get icDotMenu => 'assets/svgs/ic_dot_menu.svg';

  /// File path: assets/svgs/ic_lock.svg
  String get icLock => 'assets/svgs/ic_lock.svg';

  /// File path: assets/svgs/ic_person.svg
  String get icPerson => 'assets/svgs/ic_person.svg';

  /// File path: assets/svgs/ic_success.svg
  String get icSuccess => 'assets/svgs/ic_success.svg';

  /// File path: assets/svgs/ic_warning.svg
  String get icWarning => 'assets/svgs/ic_warning.svg';
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottiesGen lotties = $AssetsLottiesGen();
  static const $AssetsSvgsGen svgs = $AssetsSvgsGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}
