import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_fixed_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_story_theme.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/brand/app_brand.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_unlock_dial.dart';

/// The story's pictures are laid out on the board's own canvas (the sheet's
/// 349 pt inner width) and scaled as one, so they keep their proportions on
/// every phone.
const double kStoryCanvasWidth = 349;

class _Canvas extends StatelessWidget {
  const _Canvas({required this.height, required this.children});

  final double height;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: FittedBox(
        child: SizedBox(
          width: kStoryCanvasWidth,
          height: height,
          child: Stack(clipBehavior: Clip.none, children: children),
        ),
      ),
    );
  }
}

/// Step 1, "Your vault lives in your cloud": a cloud holding the encrypted
/// file, with Google Drive and Dropbox beside it (board
/// `ALT-HW1-1-Story-First`).
class StoryCloudPicture extends StatelessWidget {
  const StoryCloudPicture({super.key});

  static const double height = 290;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppStoryTheme story = context.story;
    return _Canvas(
      height: height,
      children: <Widget>[
        Positioned(
          left: (kStoryCanvasWidth - 320) / 2,
          top: 0,
          width: 320,
          height: 214,
          child: CustomPaint(painter: _CloudPainter(colors.primary)),
        ),
        Positioned(
          left: 86,
          top: 96,
          width: 178,
          child: Container(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
            decoration: BoxDecoration(
              color: story.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: story.fileCard,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  spacing: 10,
                  children: <Widget>[
                    Container(
                      width: 34,
                      height: 34,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppFixedColors.markBackground,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/svg/keeperpass_mark.svg',
                        width: 16,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // As on the board, the name may run past the card's
                          // padding rather than be cut.
                          Text(
                            'vault.json.enc',
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.visible,
                            style: _code(context, 12.5, 16, story.ink),
                          ),
                          Row(
                            spacing: 4,
                            children: <Widget>[
                              AppIcon(
                                AppIconName.lock,
                                size: 10,
                                stroke: 2.6,
                                color: colors.accentStrong,
                              ),
                              Text(
                                t.howItWorks.encrypted,
                                style: AppTextStyles(context)
                                    .secondary()
                                    .resized(
                                      11,
                                      line: 14,
                                      weight: FontWeight.w800,
                                    )
                                    .copyWith(color: colors.accentStrong),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Opacity(
                  opacity: 0.75,
                  child: Text(
                    'Q2lwaGVyVGV4dE9ubHlZb3Vy U2VjcmV0Q2FuT3Blbg7f3a9c',
                    style: _code(context, 9, 12, colors.mutedForeground),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          left: 0,
          top: 220,
          child: _StoryChip(AppProvider.google, 'Google Drive'),
        ),
        const Positioned(
          right: 0,
          top: 236,
          child: _StoryChip(AppProvider.dropbox, 'Dropbox'),
        ),
      ],
    );
  }
}

/// Step 2, "Choose a secret" — not drawn on the boards (D8): built from the
/// story's own pieces (your decision, 2026-10-31): the "Your secret · Opens
/// the file" node from step 3 above a card like step 1's, holding the
/// hidden secret.
class StorySecretPicture extends StatelessWidget {
  const StorySecretPicture({super.key});

  static const double height = 276;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppStoryTheme story = context.story;
    return _Canvas(
      height: height,
      children: <Widget>[
        _Wash(story.wash),
        const Positioned(
          left: 0,
          right: 0,
          top: 20,
          child: Center(
            child: _StoryNode(
              icon: AppIconName.keyRound,
              titleKey: _NodeText.secret,
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 82,
          height: 66,
          child: CustomPaint(painter: _DashPainter.straight(colors.primary)),
        ),
        Positioned(
          left: (kStoryCanvasWidth - 178) / 2,
          top: 152,
          width: 178,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: story.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: story.fileCard,
            ),
            child: Row(
              spacing: 10,
              children: <Widget>[
                Container(
                  width: 34,
                  height: 34,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colors.primary15,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: AppIcon(
                    AppIconName.keyRound,
                    size: 18,
                    stroke: 2,
                    color: colors.accentStrong,
                  ),
                ),
                Expanded(
                  child: Text(
                    '••••••••',
                    maxLines: 1,
                    style: _code(
                      context,
                      14,
                      20,
                      story.ink,
                    ).copyWith(letterSpacing: 0.14 * 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Step 3, "It takes both": the storage account and the secret, joined at
/// the vault dial (board `ALT-HW1-2-Story-Last`).
class StoryBothPicture extends StatelessWidget {
  const StoryBothPicture({super.key});

  static const double height = 276;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return _Canvas(
      height: height,
      children: <Widget>[
        _Wash(context.story.wash),
        Positioned(
          left: 0,
          top: 0,
          width: kStoryCanvasWidth,
          height: 270,
          child: CustomPaint(painter: _DashPainter.joined(colors.primary)),
        ),
        const Positioned(
          left: 0,
          top: 20,
          child: _StoryNode(
            icon: AppIconName.cloud,
            titleKey: _NodeText.storage,
          ),
        ),
        const Positioned(
          right: 0,
          top: 20,
          child: _StoryNode(
            icon: AppIconName.keyRound,
            titleKey: _NodeText.secret,
          ),
        ),
        const Positioned(left: 99, top: 112, child: _FixedDial()),
      ],
    );
  }
}

/// The dial at the board's 150 pt.
class _FixedDial extends StatelessWidget {
  const _FixedDial();

  @override
  Widget build(BuildContext context) {
    // The dial and the icon size themselves with ScreenUtil; fitting them
    // into 150 canvas points undoes that, keeping their proportions.
    return const SizedBox.square(
      dimension: 150,
      child: FittedBox(
        child: AppUnlockDial(
          size: 150,
          state: AppDialState.joined,
          child: AppAppIcon(size: 58),
        ),
      ),
    );
  }
}

enum _NodeText { storage, secret }

/// `.al-node`: an icon tile, a bold name and a muted line.
class _StoryNode extends StatelessWidget {
  const _StoryNode({required this.icon, required this.titleKey});

  final AppIconName icon;
  final _NodeText titleKey;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppStoryTheme story = context.story;
    final AppTextStyles styles = AppTextStyles(context);
    final (String title, String line) = switch (titleKey) {
      _NodeText.storage => (
        t.howItWorks.storageAccount,
        t.howItWorks.reachesFile,
      ),
      _NodeText.secret => (t.howItWorks.yourSecret, t.howItWorks.opensFile),
    };
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 14, 10),
      decoration: BoxDecoration(
        color: story.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: story.card,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: <Widget>[
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.primary15,
              borderRadius: BorderRadius.circular(12),
            ),
            child: AppIcon(
              icon,
              size: 20,
              stroke: 2,
              color: colors.accentStrong,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: styles
                    .body()
                    .resized(15, line: 20, weight: FontWeight.w800)
                    .copyWith(color: story.ink),
              ),
              Text(
                line,
                style: styles
                    .secondary()
                    .resized(12.5, line: 17)
                    .copyWith(color: colors.mutedForeground),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// `.al-chip`: a provider's logo and storage name.
class _StoryChip extends StatelessWidget {
  const _StoryChip(this.provider, this.label);

  final AppProvider provider;
  final String label;

  @override
  Widget build(BuildContext context) {
    final AppStoryTheme story = context.story;
    return Container(
      height: 36,
      padding: const EdgeInsets.only(left: 8, right: 14),
      decoration: ShapeDecoration(
        color: story.surface,
        shape: const StadiumBorder(),
        shadows: story.card,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: <Widget>[
          AppProviderLogo(provider, size: 20),
          Text(
            label,
            style: AppTextStyles(context)
                .body()
                .resized(13.5, line: 18, weight: FontWeight.w800)
                .copyWith(color: story.ink),
          ),
        ],
      ),
    );
  }
}

/// `.x-wash`: a soft accent pool behind the picture.
class _Wash extends StatelessWidget {
  const _Wash(this.color);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: -0.2 * kStoryCanvasWidth,
      right: -0.2 * kStoryCanvasWidth,
      top: -40,
      height: 360,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[color, color.withValues(alpha: 0)],
          ),
        ),
      ),
    );
  }
}

TextStyle _code(BuildContext context, double size, double line, Color color) =>
    AppTextStyles(context)
        .fileName()
        .resized(size, line: line, weight: FontWeight.w700)
        .copyWith(color: color, letterSpacing: 0.04 * size);

/// Step 1's cloud: the board's path (viewBox 320 × 200), a soft accent fill
/// and a light outline.
class _CloudPainter extends CustomPainter {
  _CloudPainter(this.primary);

  final Color primary;

  @override
  void paint(Canvas canvas, Size size) {
    // "meet" scaling: 320 × 200 drawn into 320 × 214, centred vertically.
    canvas.translate(0, (size.height - 200) / 2);
    final Path path = Path()
      ..moveTo(66, 188)
      ..cubicTo(34, 188, 12, 166, 16, 138)
      ..cubicTo(20, 112, 42, 98, 66, 100)
      ..cubicTo(66, 68, 92, 44, 124, 44)
      ..cubicTo(144, 44, 160, 54, 170, 68)
      ..cubicTo(182, 52, 202, 44, 222, 46)
      ..cubicTo(252, 50, 272, 76, 268, 106)
      ..cubicTo(292, 112, 306, 134, 302, 158)
      ..cubicTo(298, 176, 282, 188, 262, 188)
      ..close();
    canvas
      ..drawPath(
        path,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              primary.withValues(alpha: 0.34),
              primary.withValues(alpha: 0.12),
            ],
          ).createShader(path.getBounds()),
      )
      ..drawPath(
        path,
        Paint()
          ..color = primary.withValues(alpha: 0.35)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
  }

  @override
  bool shouldRepaint(_CloudPainter old) => old.primary != primary;
}

/// The dotted connectors (stroke 2.5, dashes 2 / 7, round caps).
class _DashPainter extends CustomPainter {
  _DashPainter.joined(this.color) : straight = false;
  _DashPainter.straight(this.color) : straight = true;

  final Color color;
  final bool straight;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    final List<Path> paths = straight
        ? <Path>[
            Path()
              ..moveTo(size.width / 2, 0)
              ..lineTo(size.width / 2, size.height),
          ]
        : <Path>[
            Path()
              ..moveTo(70, 92)
              ..cubicTo(70, 150, 110, 170, 150, 176),
            Path()
              ..moveTo(279, 92)
              ..cubicTo(279, 150, 239, 170, 199, 176),
          ];
    for (final Path path in paths) {
      for (final PathMetric metric in path.computeMetrics()) {
        for (double d = 0; d < metric.length; d += 9) {
          canvas.drawPath(metric.extractPath(d, d + 2), paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(_DashPainter old) => old.color != color;
}
