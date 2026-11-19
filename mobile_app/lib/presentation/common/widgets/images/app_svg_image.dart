import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum AppSvgSource { asset, network, string }

class AppSvgImage extends StatelessWidget {
  const AppSvgImage({
    required this.data,
    this.source = AppSvgSource.asset,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.color,
    this.semanticLabel,
    super.key,
  });

  final String data;
  final AppSvgSource source;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final Color? color;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final ColorFilter? colorFilter = color == null
        ? null
        : ColorFilter.mode(color!, BlendMode.srcIn);

    return switch (source) {
      AppSvgSource.asset => SvgPicture.asset(
        data,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        colorFilter: colorFilter,
        semanticsLabel: semanticLabel,
      ),
      AppSvgSource.network => SvgPicture.network(
        data,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        colorFilter: colorFilter,
        semanticsLabel: semanticLabel,
      ),
      AppSvgSource.string => SvgPicture.string(
        data,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        colorFilter: colorFilter,
        semanticsLabel: semanticLabel,
      ),
    };
  }
}
