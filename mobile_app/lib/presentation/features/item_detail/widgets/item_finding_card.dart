import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/enums/audit_type.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_surface.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/features/security/widgets/security_texts.dart';
import 'package:keeperpass/presentation/features/vault_list/widgets/vault_rows.dart';

/// What is wrong with an item's password, in one card (board `S4-20`): the
/// list's marker words ("Weak and reused password"), the web's description
/// of each kind found (your answer, Part 11), and the fix as its button.
class ItemFindingCard extends StatelessWidget {
  const ItemFindingCard({
    required this.findings,
    required this.onChangePassword,
    super.key,
  });

  /// In the web's order.
  final List<AuditType> findings;
  final VoidCallback onChangePassword;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    return AppSurface(
      padding: EdgeInsets.all(14.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12.h,
        children: <Widget>[
          MergeSemantics(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12.w,
              children: <Widget>[
                const AppIconTile(
                  AppTileIcon(AppIconName.shieldAlert),
                  size: AppTileSize.item,
                  tone: AppTileTone.destructive,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4.h,
                    children: <Widget>[
                      Text(
                        findingLabel(findings)!,
                        style: styles
                            .button()
                            .resized(15, line: 20, weight: FontWeight.w700)
                            .copyWith(color: colors.foreground),
                      ),
                      for (final AuditType type in findings)
                        Text(
                          auditDescription(type),
                          style: styles
                              .secondary()
                              .resized(14, line: 20)
                              .copyWith(color: colors.mutedForeground),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AppButton(
            label: t.report.changePassword,
            icon: AppIconName.wandSparkles,
            size: AppButtonSize.medium,
            onPressed: onChangePassword,
          ),
        ],
      ),
    );
  }
}
