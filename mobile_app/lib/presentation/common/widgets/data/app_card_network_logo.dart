import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keeperpass/core/utils/validation/card_number.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';

/// A card network's logo on a card face (your answer, 2026-11-05: Aaron
/// Fagan's set, bundled in `assets/card_networks/`, see its NOTICE.md). The
/// dark card takes the white-letter version where there is one. A network
/// without a logo, or a logo that cannot be drawn, shows its name instead,
/// as the card did before.
class AppCardNetworkLogo extends StatelessWidget {
  const AppCardNetworkLogo(
    this.brand, {
    this.folder = 'assets/card_networks',
    super.key,
  });

  final CardBrand brand;

  /// Where the logos are; tests point it elsewhere to see the fallback.
  @visibleForTesting
  final String folder;

  /// Width ÷ height of each logo (its trimmed frame), and whether it has a
  /// `-dark` version.
  static const Map<String, (double, bool)> logos = <String, (double, bool)>{
    'visa': (664 / 218, true),
    'mastercard': (566 / 352, false),
    'amex': (784 / 278, true),
    'discover': (662 / 110, true),
    'diners': (424 / 338, false),
    'jcb': (490 / 378, false),
    'unionpay': (576 / 366, false),
    'maestro': (566 / 352, false),
    'mir': (700 / 202, false),
    'elo': (642 / 238, true),
    'hipercard': (572 / 141, true),
  };

  /// Every logo covers about the same area within 72 × 28 pt, so a wide
  /// wordmark and a round symbol look the same size.
  static Size sizeFor(double aspect) {
    const double area = 40 * 26;
    const double maxWidth = 72;
    const double maxHeight = 28;
    double height = math.min(math.sqrt(area / aspect), maxHeight);
    double width = height * aspect;
    if (width > maxWidth) {
      width = maxWidth;
      height = width / aspect;
    }
    return Size(width, height);
  }

  @override
  Widget build(BuildContext context) {
    final (double, bool)? logo = logos[brand.id];
    if (logo == null) return _NetworkName(brand.label);
    final (double aspect, bool hasDark) = logo;
    final bool dark = Theme.of(context).brightness == Brightness.dark;
    final Size size = sizeFor(aspect);
    return SvgPicture.asset(
      '$folder/${brand.id}${dark && hasDark ? '-dark' : ''}.svg',
      width: size.width.r,
      height: size.height.r,
      excludeFromSemantics: true,
      errorBuilder: (BuildContext context, Object error, StackTrace stack) =>
          _NetworkName(brand.label),
    );
  }
}

class _NetworkName extends StatelessWidget {
  const _NetworkName(this.label);

  final String label;

  @override
  Widget build(BuildContext context) => Text(
    label,
    maxLines: 1,
    style: AppTextStyles(context)
        .bodyStrong()
        .resized(16, line: 22, weight: FontWeight.w800)
        .copyWith(color: context.colors.foreground),
  );
}
