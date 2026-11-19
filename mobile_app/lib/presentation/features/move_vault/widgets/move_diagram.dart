import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/constants/vault_file_names.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_shadows.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/utils/provider_ui.dart';
import 'package:keeperpass/presentation/common/widgets/brand/app_brand.dart';

/// "Your vault moves from Google Drive to Dropbox" (`.mvd`, boards `S5-25`,
/// `S5-28`): both storages, and the file on a dashed lane between them.
/// One image for screen readers.
class MoveDiagram extends StatelessWidget {
  const MoveDiagram({required this.from, required this.to, super.key});

  final ProviderId from;
  final ProviderId to;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return Semantics(
      image: true,
      label: t.moveVault.diagram(from: from.storageName, to: to.storageName),
      child: ExcludeSemantics(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.w,
          children: <Widget>[
            _Node(provider: from, caption: t.moveVault.from),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 31.r),
                child: Column(
                  spacing: 8.h,
                  children: <Widget>[
                    SizedBox(
                      height: 2.r,
                      width: double.infinity,
                      child: CustomPaint(
                        painter: _DashPainter(colors.primary60),
                      ),
                    ),
                    Container(
                      height: 26.r,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: ShapeDecoration(
                        color: colors.card,
                        shape: StadiumBorder(
                          side: BorderSide(color: colors.hairline, width: 1.r),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 6.w,
                        children: <Widget>[
                          AppIcon(
                            AppIconName.lock,
                            size: 12,
                            stroke: 2.5,
                            color: colors.accentStrong,
                          ),
                          Flexible(
                            child: Text(
                              VaultFileNames.vault,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles(context)
                                  .fileName()
                                  .resized(
                                    11,
                                    line: 14,
                                    weight: FontWeight.w700,
                                  )
                                  .copyWith(color: colors.foreground),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _Node(provider: to, caption: t.moveVault.to),
          ],
        ),
      ),
    );
  }
}

/// A storage (`.mvn`): its logo in a lifted circle, its name, From or To.
class _Node extends StatelessWidget {
  const _Node({required this.provider, required this.caption});

  final ProviderId provider;
  final String caption;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    return SizedBox(
      width: 92.w,
      child: Column(
        spacing: 8.h,
        children: <Widget>[
          Container(
            width: 64.r,
            height: 64.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.card,
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(color: colors.hairline, spreadRadius: 1.r),
                ...context.shadows.lift,
              ],
            ),
            child: AppProviderLogo(provider.logo, size: 26),
          ),
          Text(
            provider.storageName,
            textAlign: TextAlign.center,
            style: styles
                .badge()
                .resized(13, line: 18, weight: FontWeight.w800)
                .copyWith(color: colors.foreground),
          ),
          Text(
            caption.toUpperCase(),
            textAlign: TextAlign.center,
            style: styles
                .sectionLabel()
                .resized(11, line: 14, weight: FontWeight.w700, tracking: 0.06)
                .copyWith(color: colors.mutedForeground),
          ),
        ],
      ),
    );
  }
}

/// The lane (`.mvl .ln`): 6 pt dashes, 6 pt gaps.
class _DashPainter extends CustomPainter {
  _DashPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;
    final double dash = 6.r;
    for (double x = 0; x < size.width; x += dash * 2) {
      canvas.drawRect(
        Rect.fromLTWH(x, 0, (size.width - x).clamp(0, dash), size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_DashPainter old) => old.color != color;
}
