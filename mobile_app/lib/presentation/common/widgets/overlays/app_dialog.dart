import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_fixed_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_radius.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_surface.dart';

/// A dialog's tone (board C5).
enum AppDialogTone {
  /// A safe confirmation: accent tile and button.
  accent,

  /// Destructive, but not final: red tint.
  tint,

  /// The final step of something irreversible: solid red button.
  solid,
}

/// Shows a confirmation dialog (board C5): a centred card with an icon tile,
/// the question as the title, the consequence, and two equal buttons —
/// Cancel first. Resolves to true when confirmed.
Future<bool> showAppDialog(
  BuildContext context, {
  required AppIconName icon,
  required String title,
  required String message,
  required String confirmLabel,
  AppDialogTone tone = AppDialogTone.accent,
  String? cancelLabel,
  bool smallTitle = false,
}) async {
  final AppColors colors = context.colors;
  final bool reduceMotion = AppMotion.reduceMotion(context);
  // Keep the caller's theme inside the dialog route.
  final CapturedThemes themes = InheritedTheme.capture(
    from: context,
    to: Navigator.of(context).context,
  );
  final bool? confirmed = await showGeneralDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierLabel: cancelLabel ?? t.common.cancel,
    barrierColor: colors.scrim,
    transitionDuration: reduceMotion ? Duration.zero : AppMotion.enter,
    pageBuilder: (BuildContext dialogContext, _, _) => themes.wrap(
      Center(
        child: AppDialog(
          icon: icon,
          title: title,
          message: message,
          confirmLabel: confirmLabel,
          cancelLabel: cancelLabel,
          tone: tone,
          smallTitle: smallTitle,
          onCancel: () => Navigator.of(dialogContext).pop(false),
          onConfirm: () => Navigator.of(dialogContext).pop(true),
        ),
      ),
    ),
    transitionBuilder:
        (BuildContext context, Animation<double> animation, _, Widget child) {
          final CurvedAnimation curved = CurvedAnimation(
            parent: animation,
            curve: AppMotion.easeOut,
          );
          return FadeTransition(
            opacity: curved,
            child: ScaleTransition(
              scale: Tween<double>(
                begin: AppMotion.dialogStartScale,
                end: 1,
              ).animate(curved),
              child: child,
            ),
          );
        },
  );
  return confirmed ?? false;
}

/// The dialog card (`.dlg`): 300 pt wide.
class AppDialog extends StatelessWidget {
  const AppDialog({
    required this.icon,
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.onCancel,
    required this.onConfirm,
    this.cancelLabel,
    this.tone = AppDialogTone.accent,
    this.smallTitle = false,
    super.key,
  });

  final AppIconName icon;

  /// The question ("Restore this version?").
  final String title;

  /// The consequence.
  final String message;
  final String confirmLabel;
  final String? cancelLabel;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final AppDialogTone tone;

  /// 18 / 24 for a long question (the board's "Are you sure you want to
  /// remove this field?").
  final bool smallTitle;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final (Color confirmFill, Color confirmText) = switch (tone) {
      AppDialogTone.accent => (colors.primary, colors.primaryForeground),
      AppDialogTone.tint => (colors.destructiveTint, colors.destructiveStrong),
      AppDialogTone.solid => (colors.destructive, AppFixedColors.onDestructive),
    };

    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      label: title,
      child: Material(
        type: MaterialType.transparency,
        child: SizedBox(
          width: 300.w,
          child: AppSurface(
            elevation: AppElevation.floating,
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AppIconTile(
                  AppTileIcon(icon),
                  size: AppTileSize.dialog,
                  tone: tone == AppDialogTone.accent
                      ? AppTileTone.accent
                      : AppTileTone.destructive,
                ),
                SizedBox(height: 14.h),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style:
                      (smallTitle
                              ? styles.title().resized(18, line: 24)
                              : styles.title())
                          .copyWith(color: colors.foreground),
                ),
                SizedBox(height: 6.h),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: styles.body().copyWith(color: colors.mutedForeground),
                ),
                SizedBox(height: 18.h),
                Row(
                  spacing: 10.w,
                  children: <Widget>[
                    Expanded(
                      child: _DialogButton(
                        label: cancelLabel ?? t.common.cancel,
                        background: colors.secondary,
                        foreground: colors.foreground,
                        onPressed: onCancel,
                      ),
                    ),
                    Expanded(
                      child: _DialogButton(
                        label: confirmLabel,
                        background: confirmFill,
                        foreground: confirmText,
                        onPressed: onConfirm,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// `.b44` — the dialog's 44 pt buttons.
class _DialogButton extends StatelessWidget {
  const _DialogButton({
    required this.label,
    required this.background,
    required this.foreground,
    required this.onPressed,
  });

  final String label;
  final Color background;
  final Color foreground;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final OutlinedBorder shape = AppRadius.shape(context, AppRadius.xl);
    return AppPressable(
      onTap: onPressed,
      shape: shape,
      child: Container(
        height: 44.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        alignment: Alignment.center,
        decoration: ShapeDecoration(color: background, shape: shape),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles(context).button().copyWith(color: foreground),
        ),
      ),
    );
  }
}
