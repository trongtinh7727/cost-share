/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconGen {
  const $AssetsIconGen();

  /// Directory path: assets/icon/svg
  $AssetsIconSvgGen get svg => const $AssetsIconSvgGen();
}

class $AssetsImageGen {
  const $AssetsImageGen();

  /// Directory path: assets/image/svg
  $AssetsImageSvgGen get svg => const $AssetsImageSvgGen();
}

class $AssetsIconSvgGen {
  const $AssetsIconSvgGen();

  /// File path: assets/icon/svg/icon_google.svg
  SvgGenImage get iconGoogle =>
      const SvgGenImage('assets/icon/svg/icon_google.svg');

  /// List of all assets
  List<SvgGenImage> get values => [iconGoogle];
}

class $AssetsImageSvgGen {
  const $AssetsImageSvgGen();

  /// File path: assets/image/svg/intro1.svg
  SvgGenImage get intro1 => const SvgGenImage('assets/image/svg/intro1.svg');

  /// File path: assets/image/svg/intro2.svg
  SvgGenImage get intro2 => const SvgGenImage('assets/image/svg/intro2.svg');

  /// File path: assets/image/svg/intro3.svg
  SvgGenImage get intro3 => const SvgGenImage('assets/image/svg/intro3.svg');

  /// File path: assets/image/svg/launch_screen.svg
  SvgGenImage get launchScreen =>
      const SvgGenImage('assets/image/svg/launch_screen.svg');

  /// List of all assets
  List<SvgGenImage> get values => [intro1, intro2, intro3, launchScreen];
}

class Assets {
  Assets._();

  static const $AssetsIconGen icon = $AssetsIconGen();
  static const $AssetsImageGen image = $AssetsImageGen();
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

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
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

  String get keyName => _assetName;
}
