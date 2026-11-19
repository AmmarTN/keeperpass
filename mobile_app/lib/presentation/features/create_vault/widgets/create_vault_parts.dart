import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_surface.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_checks.dart';

/// The step heading: eyebrow, title, one line (`.eyb`, `.lt2`, `.bd15`).
class StepHeading extends StatelessWidget {
  const StepHeading({
    required this.eyebrow,
    required this.title,
    required this.body,
    super.key,
  });

  final String eyebrow;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          eyebrow.toUpperCase(),
          style: styles.sectionLabel().copyWith(
            color: colors.accentStrong,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 8.h),
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
          body,
          style: styles.body().copyWith(color: colors.mutedForeground),
        ),
      ],
    );
  }
}

/// "Choosing a good secret" (`.card` with a `.crow`): closed until tapped.
class SecretTipsCard extends StatefulWidget {
  const SecretTipsCard({super.key});

  @override
  State<SecretTipsCard> createState() => _SecretTipsCardState();
}

class _SecretTipsCardState extends State<SecretTipsCard> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    return AppSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AppPressable(
            onTap: () => setState(() => _open = !_open),
            toggled: _open,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 48.h),
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 12.w),
                child: Row(
                  spacing: 12.w,
                  children: <Widget>[
                    AppIcon(
                      AppIconName.lightbulb,
                      size: AppIconSizes.md,
                      color: colors.accentStrong,
                    ),
                    Expanded(
                      child: Text(
                        t.createVault.tipsTitle,
                        style: styles
                            .bodyStrong()
                            .resized(15, line: 20)
                            .copyWith(color: colors.foreground),
                      ),
                    ),
                    AppIcon(
                      _open ? AppIconName.chevronUp : AppIconName.chevronDown,
                      size: 18,
                      stroke: 2,
                      color: colors.mutedForeground,
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedSize(
            duration: AppMotion.reduceMotion(context)
                ? Duration.zero
                : AppMotion.base,
            curve: AppMotion.easeOut,
            alignment: Alignment.topCenter,
            child: _open
                ? Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                    child: Column(
                      spacing: 10.h,
                      children: <Widget>[
                        for (final String tip in <String>[
                          t.createVault.tip1,
                          t.createVault.tip2,
                          t.createVault.tip3,
                        ])
                          _Bullet(
                            text: tip,
                            dot: colors.mutedForeground,
                            style: styles
                                .secondary()
                                .resized(14, line: 20)
                                .copyWith(color: colors.mutedForeground),
                          ),
                      ],
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}

/// "Your secret · 5 words" with Show / Hide: generated words as numbered
/// tiles (`.words`), a typed secret whole in one block (your decision,
/// 2026-10-31). Hidden until Show, like every secret.
class SecretWordsCard extends StatefulWidget {
  const SecretWordsCard({
    required this.secret,
    required this.generated,
    super.key,
  });

  final String secret;
  final bool generated;

  @override
  State<SecretWordsCard> createState() => _SecretWordsCardState();
}

class _SecretWordsCardState extends State<SecretWordsCard> {
  bool _shown = false;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final List<String> words = widget.generated
        ? widget.secret.split('-')
        : <String>[widget.secret];
    final TextStyle mono = styles
        .fileName()
        .resized(16, line: 22, weight: FontWeight.w700)
        .copyWith(color: colors.foreground);
    final TextStyle hidden = mono.copyWith(
      color: colors.mutedForeground,
      letterSpacing: 0.14 * 16,
    );

    return AppSurface(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  (widget.generated
                          ? t.createVault.secretWords(count: words.length)
                          : t.createVault.secretWhole)
                      .toUpperCase(),
                  style: styles.sectionLabel().copyWith(
                    color: colors.mutedForeground,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(8.w, 0),
                child: AppLinkButton(
                  label: _shown ? t.common.hide : t.common.show,
                  icon: _shown ? AppIconName.eyeOff : AppIconName.eye,
                  iconSize: 18,
                  fontSize: 14,
                  onPressed: () => setState(() => _shown = !_shown),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Semantics(
            label: _shown
                ? '${t.createVault.secretShown}: ${widget.secret}'
                : t.createVault.secretHidden,
            child: ExcludeSemantics(
              child: widget.generated
                  ? GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 8.h,
                      crossAxisSpacing: 8.w,
                      childAspectRatio: 140.5 / 44,
                      children: <Widget>[
                        for (int i = 0; i < words.length; i++)
                          _WordTile(
                            index: i + 1,
                            child: Text(
                              _shown ? words[i] : '••••••',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: _shown ? mono : hidden,
                            ),
                          ),
                      ],
                    )
                  : _WordTile(
                      child: Text(
                        _shown
                            ? widget.secret
                            : '•' * widget.secret.length.clamp(6, 24),
                        style: _shown ? mono : hidden,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

/// `.wt`: a word on the background colour with the hairline inset.
class _WordTile extends StatelessWidget {
  const _WordTile({required this.child, this.index});

  final int? index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return Container(
      constraints: BoxConstraints(minHeight: 44.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: ShapeDecoration(
        color: colors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(color: colors.hairline),
        ),
      ),
      child: Row(
        spacing: 10.w,
        children: <Widget>[
          if (index != null)
            SizedBox(
              width: 14.w,
              child: Text(
                '$index',
                style: AppTextStyles(context)
                    .fileName()
                    .resized(11, line: 11, weight: FontWeight.w700)
                    .copyWith(color: colors.mutedForeground),
              ),
            ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

/// "Please read this before you continue" (`.ban.info` with bullets and the
/// acknowledgement).
class ReadBeforeNotice extends StatelessWidget {
  const ReadBeforeNotice({
    required this.acknowledged,
    required this.onAcknowledged,
    super.key,
  });

  final bool acknowledged;
  final ValueChanged<bool> onAcknowledged;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: ShapeDecoration(
        color: colors.primary10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: BorderSide(color: colors.primary30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12.h,
        children: <Widget>[
          Row(
            spacing: 10.w,
            children: <Widget>[
              AppIcon(
                AppIconName.info,
                size: AppIconSizes.md,
                color: colors.accentStrong,
              ),
              Expanded(
                child: Text(
                  t.createVault.readBefore,
                  style: styles
                      .bodyStrong()
                      .resized(15, line: 20, weight: FontWeight.w700)
                      .copyWith(color: colors.foreground),
                ),
              ),
            ],
          ),
          for (final String bullet in <String>[
            t.createVault.bullet1,
            t.createVault.bullet2,
            t.createVault.bullet3,
          ])
            _Bullet(
              text: bullet,
              dot: colors.accentStrong,
              style: styles
                  .secondary()
                  .resized(14, line: 20)
                  .copyWith(color: colors.foreground),
            ),
          SizedBox(height: 1, child: ColoredBox(color: colors.primary30)),
          AppCheckRow(
            label: t.createVault.acknowledge,
            checked: acknowledged,
            onChanged: onAcknowledged,
          ),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text, required this.dot, required this.style});

  final String text;
  final Color dot;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.w,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 7.h),
          child: Container(
            width: 6.r,
            height: 6.r,
            decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
          ),
        ),
        Expanded(child: Text(text, style: style)),
      ],
    );
  }
}

/// The bottom action (`.sticky`): the content fades out under it.
class StickyAction extends StatelessWidget {
  const StickyAction({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            colors.background.withValues(alpha: 0),
            colors.background,
          ],
          stops: <double>[0, 26.h / (28.h + 52.h + 16.h)],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          24.w,
          28.h,
          24.w,
          16.h + MediaQuery.paddingOf(context).bottom,
        ),
        child: child,
      ),
    );
  }
}
