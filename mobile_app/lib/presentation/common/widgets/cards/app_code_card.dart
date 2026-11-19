import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_haptics.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_radius.dart';
import 'package:keeperpass/presentation/common/theme/app_shadows.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_totp_ring.dart';
import 'package:keeperpass/presentation/common/widgets/text/highlighted_text.dart';

/// A Codes-tab card (`.ccard`, board C2): the item's tile, name and line, the
/// ring, and the code at 34 pt. The whole card copies (and shows the tinted
/// "done" state for 1 s); an invalid setup key says so instead. In the last
/// five seconds the code turns amber and counts (board `Codes` 02); a new
/// code crossfades in and is announced politely (board `Motion`).
class AppCodeCard extends StatefulWidget {
  const AppCodeCard({
    required this.tile,
    required this.name,
    required this.subtitle,
    required this.code,
    required this.secondsLeft,
    required this.copyLabel,
    required this.onCopy,
    this.period = 30,
    this.highlight = const <String>[],
    super.key,
  }) : onFix = null;

  /// The setup key is not valid: no code, "Fix it in Edit".
  const AppCodeCard.invalid({
    required this.tile,
    required this.name,
    required this.subtitle,
    required this.onFix,
    this.highlight = const <String>[],
    super.key,
  }) : code = null,
       secondsLeft = 0,
       period = 30,
       copyLabel = null,
       onCopy = null;

  final Widget tile;
  final String name;
  final String subtitle;

  /// "482 913"; null when the setup key is invalid.
  final String? code;
  final int secondsLeft;
  final int period;

  /// "Copy code for GitHub".
  final String? copyLabel;
  final VoidCallback? onCopy;
  final VoidCallback? onFix;

  /// Search words marked in the name (board `S4-05`).
  final List<String> highlight;

  @override
  State<AppCodeCard> createState() => _AppCodeCardState();
}

class _AppCodeCardState extends State<AppCodeCard> {
  bool _copied = false;
  Timer? _reset;

  @override
  void dispose() {
    _reset?.cancel();
    super.dispose();
  }

  void _copy() {
    widget.onCopy!();
    _reset?.cancel();
    setState(() => _copied = true);
    _reset = Timer(AppMotion.copiedHold, () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final bool invalid = widget.code == null;
    final bool warning = !invalid && widget.secondsLeft <= kTotpWarningSeconds;
    final bool reduceMotion = AppMotion.reduceMotion(context);
    final OutlinedBorder shape = AppRadius.shape(context, AppRadius.xxl);

    final Widget header = Row(
      spacing: 12.w,
      children: <Widget>[
        widget.tile,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 1.h,
            children: <Widget>[
              Text.rich(
                highlightedSpan(widget.name, widget.highlight),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: styles.rowTitle().copyWith(color: colors.foreground),
              ),
              Text(
                widget.subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: styles.secondary().copyWith(
                  color: colors.mutedForeground,
                ),
              ),
            ],
          ),
        ),
        if (invalid)
          AppIcon(
            AppIconName.circleAlert,
            size: AppIconSizes.md,
            stroke: 2,
            color: colors.destructiveStrong,
          )
        else
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 6.w,
            children: <Widget>[
              // Amber plus the count, never colour alone (`.csec`).
              if (warning)
                ExcludeSemantics(
                  child: Text(
                    t.totp.secondsShort(count: widget.secondsLeft),
                    style: styles
                        .badge()
                        .resized(12, line: 16, weight: FontWeight.w800)
                        .copyWith(color: colors.warningStrong),
                  ),
                ),
              AppTotpRing(
                secondsLeft: widget.secondsLeft,
                period: widget.period,
                size: 24,
              ),
            ],
          ),
      ],
    );

    final Widget body = invalid
        ? Padding(
            padding: EdgeInsets.all(2.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2.h,
              children: <Widget>[
                Text(
                  t.totp.invalidCode,
                  style: styles
                      .rowTitle()
                      .resized(17, line: 24, weight: FontWeight.w800)
                      .copyWith(color: colors.foreground),
                ),
                Text(
                  t.totp.invalidKey,
                  style: styles.secondary().copyWith(
                    color: colors.mutedForeground,
                  ),
                ),
                AppLinkButton(
                  label: t.totp.fixInEdit,
                  onPressed: widget.onFix,
                  fontSize: 14,
                  horizontalPadding: 0,
                ),
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.only(left: 2.w),
            child: Row(
              children: <Widget>[
                Expanded(
                  // The amber eases in over 200 ms; a new code crossfades
                  // in 200 ms, or swaps at once with Reduce Motion.
                  child: TweenAnimationBuilder<Color?>(
                    tween: ColorTween(
                      end: warning ? colors.warningStrong : colors.foreground,
                    ),
                    duration: reduceMotion ? Duration.zero : AppMotion.base,
                    curve: Curves.linear,
                    builder: (BuildContext context, Color? color, _) =>
                        AnimatedSwitcher(
                          duration: reduceMotion
                              ? Duration.zero
                              : AppMotion.base,
                          layoutBuilder:
                              (Widget? current, List<Widget> previous) => Stack(
                                alignment: AlignmentDirectional.centerStart,
                                children: <Widget>[...previous, ?current],
                              ),
                          child: Text(
                            widget.code!,
                            key: ValueKey<String>(widget.code!),
                            style: styles
                                .codeLg()
                                .resized(
                                  34,
                                  line: 40,
                                  weight: FontWeight.w700,
                                  tracking: 0.06,
                                )
                                .copyWith(color: color),
                          ),
                        ),
                  ),
                ),
                Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    color: _copied ? colors.primary15 : colors.secondary,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: AppIcon(
                      _copied ? AppIconName.check : AppIconName.copy,
                      size: AppIconSizes.md,
                      stroke: _copied ? 2.25 : 1.75,
                      color: _copied
                          ? colors.accentStrong
                          : colors.mutedForeground,
                    ),
                  ),
                ),
              ],
            ),
          );

    final Widget card = Container(
      padding: EdgeInsets.fromLTRB(14.w, 14.h, 14.w, 12.h),
      decoration: ShapeDecoration(
        color: _copied
            ? Color.alphaBlend(colors.primary10, colors.card)
            : colors.card,
        shape: shape,
        shadows: <BoxShadow>[
          ...context.shadows.shadowXs,
          if (_copied)
            BoxShadow(color: colors.primary30, spreadRadius: 1.5.r)
          else
            BoxShadow(color: colors.hairline, spreadRadius: 1.r),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8.h,
        children: <Widget>[header, body],
      ),
    );

    if (invalid) return card;
    return AppPressable(
      onTap: _copy,
      haptic: AppHaptics.copy,
      semanticLabel: _copied ? t.common.copied : widget.copyLabel,
      semanticValue: _copied ? null : widget.code,
      liveRegion: true,
      shape: shape,
      child: card,
    );
  }
}
