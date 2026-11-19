import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_fixed_colors.dart';

/// The storage providers.
enum AppProvider {
  google('assets/icons/svg/google_logo.svg'),
  dropbox('assets/icons/svg/dropbox_logo.svg');

  const AppProvider(this.logoAsset);

  final String logoAsset;
}

/// The provider's own logo, in its own colours (`.glogo`, `.dblogo`).
class AppProviderLogo extends StatelessWidget {
  const AppProviderLogo(this.provider, {this.size = 20, super.key});

  final AppProvider provider;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      provider.logoAsset,
      width: size.r,
      height: size.r,
      excludeFromSemantics: true,
    );
  }
}

/// The KeeperPass wordmark in the foreground colour (`.wm`); under 96 pt wide
/// the mark stands alone (board Brand).
class AppWordmark extends StatelessWidget {
  const AppWordmark({
    this.height = 26,
    this.color,
    this.semanticLabel = 'KeeperPass',
    super.key,
  });

  final double height;
  final Color? color;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/svg/keeperpass_wordmark.svg',
      height: height.r,
      semanticsLabel: semanticLabel,
      colorFilter: ColorFilter.mode(
        color ?? context.colors.foreground,
        BlendMode.srcIn,
      ),
    );
  }
}

/// The app icon: the white mark on black (`.appicon`), with the hairline ring.
/// Corners follow the board: 30 → 7, 40 → 9, 56 → 13.
class AppAppIcon extends StatelessWidget {
  const AppAppIcon({
    this.size = 40,
    this.semanticLabel = 'KeeperPass',
    super.key,
  });

  final double size;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      label: semanticLabel,
      child: Container(
        width: size.r,
        height: size.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppFixedColors.markBackground,
          borderRadius: BorderRadius.circular((size * 0.225).r),
          boxShadow: <BoxShadow>[
            BoxShadow(color: context.colors.hairline, spreadRadius: 1.r),
          ],
        ),
        child: SvgPicture.asset(
          'assets/icons/svg/keeperpass_mark.svg',
          width: (size * 0.52).r,
          excludeFromSemantics: true,
        ),
      ),
    );
  }
}
