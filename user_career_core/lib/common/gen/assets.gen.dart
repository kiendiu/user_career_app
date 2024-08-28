/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';
import 'package:lottie/lottie.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/.icon
  String get aIcon => 'packages/user_career_core/assets/icons/.icon';

  /// File path: assets/icons/ic_tabbar_home.svg
  SvgGenImage get icTabbarHome =>
      const SvgGenImage('assets/icons/ic_tabbar_home.svg');

  /// File path: assets/icons/ic_tabbar_message.svg
  SvgGenImage get icTabbarMessage =>
      const SvgGenImage('assets/icons/ic_tabbar_message.svg');

  /// File path: assets/icons/ic_tabbar_request.svg
  SvgGenImage get icTabbarRequest =>
      const SvgGenImage('assets/icons/ic_tabbar_request.svg');

  /// File path: assets/icons/ic_tabbar_unselected_home.svg
  SvgGenImage get icTabbarUnselectedHome =>
      const SvgGenImage('assets/icons/ic_tabbar_unselected_home.svg');

  /// File path: assets/icons/ic_tabbar_unselected_message.svg
  SvgGenImage get icTabbarUnselectedMessage =>
      const SvgGenImage('assets/icons/ic_tabbar_unselected_message.svg');

  /// File path: assets/icons/ic_tabbar_unselected_request.svg
  SvgGenImage get icTabbarUnselectedRequest =>
      const SvgGenImage('assets/icons/ic_tabbar_unselected_request.svg');

  /// File path: assets/icons/ic_tabbar_unselected_user.svg
  SvgGenImage get icTabbarUnselectedUser =>
      const SvgGenImage('assets/icons/ic_tabbar_unselected_user.svg');

  /// File path: assets/icons/ic_tabbar_user.svg
  SvgGenImage get icTabbarUser =>
      const SvgGenImage('assets/icons/ic_tabbar_user.svg');

  /// List of all assets
  List<dynamic> get values => [
        aIcon,
        icTabbarHome,
        icTabbarMessage,
        icTabbarRequest,
        icTabbarUnselectedHome,
        icTabbarUnselectedMessage,
        icTabbarUnselectedRequest,
        icTabbarUnselectedUser,
        icTabbarUser
      ];
}

class $AssetsJsonsGen {
  const $AssetsJsonsGen();

  /// File path: assets/jsons/sample.json
  String get sample => 'packages/user_career_core/assets/jsons/sample.json';

  /// File path: assets/jsons/worm_loading.json
  LottieGenImage get wormLoading =>
      const LottieGenImage('assets/jsons/worm_loading.json');

  /// List of all assets
  List<dynamic> get values => [sample, wormLoading];
}

class Assets {
  Assets._();

  static const String package = 'user_career_core';

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsJsonsGen jsons = $AssetsJsonsGen();
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  static const String package = 'user_career_core';

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    @Deprecated('Do not specify package for a generated library asset')
    String? package = package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final BytesLoader loader;
    if (_isVecFormat) {
      loader = AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => 'packages/user_career_core/$_assetName';
}

class LottieGenImage {
  const LottieGenImage(
    this._assetName, {
    this.flavors = const {},
  });

  final String _assetName;
  final Set<String> flavors;

  static const String package = 'user_career_core';

  LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    LottieDelegates? delegates,
    LottieOptions? options,
    void Function(LottieComposition)? onLoaded,
    LottieImageProviderFactory? imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(BuildContext, Widget, LottieComposition?)? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    @Deprecated('Do not specify package for a generated library asset')
    String? package = package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
    void Function(String)? onWarning,
  }) {
    return Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
    );
  }

  String get path => _assetName;

  String get keyName => 'packages/user_career_core/$_assetName';
}
