import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/brand/app_brand.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_vault_file_card.dart';

/// The ciphertext every vault card shows (boards `U2-*`).
const String kCipherPreview =
    'Q2lwaGVyVGV4dE9ubHlZb3VyU2VjcmV0Q2FuT3Blbg.7f3a9c2e1b8d4f60a5e2c9b1d7f4a8e3c6b0d9f2a1e5c8b7d4f3a6e9c2b5d8f1a4e7c0b3d6f9a2e5c8b1d4f7a0e3c6';

/// The top bar: the wordmark and the "How it works" pill.
class WelcomeTopBar extends StatelessWidget {
  const WelcomeTopBar({
    required this.onHowItWorks,
    this.wordmarkOpacity = 1,
    this.pillOpacity = 1,
    super.key,
  });

  final VoidCallback onHowItWorks;

  /// The launch motion fades the letters in as the mark lands.
  final double wordmarkOpacity;
  final double pillOpacity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h,
      child: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 16.w),
        child: Row(
          children: <Widget>[
            Opacity(
              opacity: wordmarkOpacity,
              child: const AppWordmark(height: 22),
            ),
            const Spacer(),
            Opacity(
              opacity: pillOpacity,
              child: GlassPill(
                icon: AppIconName.circleQuestionMark,
                iconSize: 16,
                label: t.welcome.howItWorks,
                height: 32,
                padding: EdgeInsets.only(left: 10.w, right: 12.w),
                gap: 6,
                fontSize: 13,
                lineHeight: 18,
                onTap: onHowItWorks,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The hero text: the badge, the headline and one line (`.bpill`, `.lt2`).
class WelcomeHeadline extends StatelessWidget {
  const WelcomeHeadline({
    required this.title,
    required this.description,
    this.showBadge = true,
    super.key,
  });

  final String title;
  final String description;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (showBadge) ...<Widget>[
            GlassPill(
              icon: AppIconName.lockKeyhole,
              iconSize: 14,
              label: t.welcome.badge,
              height: 30,
              padding: EdgeInsets.only(left: 12.w, right: 14.w),
              gap: 8,
              fontSize: 12,
              lineHeight: 16,
            ),
            SizedBox(height: 16.h),
          ],
          Semantics(
            header: true,
            child: Text(
              title,
              style: styles.largeTitle().copyWith(
                color: colors.foreground,
                letterSpacing: -0.02 * 32,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            description,
            style: styles.body().copyWith(color: colors.mutedForeground),
          ),
        ],
      ),
    );
  }
}

/// The hero's vault card, tilted 2° (`.vf` rotate −2deg).
class WelcomeCard extends StatelessWidget {
  const WelcomeCard({required this.card, super.key});

  final AppVaultFileCard card;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.h),
      child: Center(
        child: Transform.rotate(angle: -2 * math.pi / 180, child: card),
      ),
    );
  }
}

/// A frosted pill on the hero (`.hpill`, `.bpill`): 80 % card colour over a
/// 12 pt blur, with the hairline ring; clipped to the pill and grouped with
/// the screen's other pill ([BackdropGroup] on the page).
class GlassPill extends StatelessWidget {
  const GlassPill({
    required this.icon,
    required this.iconSize,
    required this.label,
    required this.height,
    required this.padding,
    required this.gap,
    required this.fontSize,
    required this.lineHeight,
    this.onTap,
    super.key,
  });

  final AppIconName icon;
  final double iconSize;
  final String label;
  final double height;
  final EdgeInsets padding;
  final double gap;
  final double fontSize;
  final double lineHeight;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final Widget pill = ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: BackdropFilter.grouped(
        // CSS `backdrop-filter: blur(12px)` is a σ of 12 (box shadows halve
        // their blur; filters do not).
        filter: ImageFilter.blur(sigmaX: 12.r, sigmaY: 12.r),
        child: Container(
          height: height.h,
          padding: padding,
          decoration: ShapeDecoration(
            color: colors.card.withValues(alpha: 0.8),
            shape: StadiumBorder(side: BorderSide(color: colors.hairline)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: gap.w,
            children: <Widget>[
              AppIcon(
                icon,
                size: iconSize,
                stroke: 2,
                color: colors.accentStrong,
              ),
              Text(
                label,
                style: AppTextStyles(context)
                    .secondary()
                    .resized(
                      fontSize,
                      line: lineHeight,
                      weight: FontWeight.w700,
                    )
                    .copyWith(color: colors.foreground),
              ),
            ],
          ),
        ),
      ),
    );
    if (onTap == null) return pill;
    return AppPressable(
      onTap: onTap,
      shape: const StadiumBorder(),
      child: pill,
    );
  }
}

/// The resting card: what the storage sees.
AppVaultFileCard restingCard() => AppVaultFileCard(
  fileName: 'vault.json.enc',
  meta: t.welcome.fileMeta,
  cipherPreview: kCipherPreview,
  tag: t.welcome.fileTag,
);
