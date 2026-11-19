import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_radius.dart';
import 'package:keeperpass/presentation/common/theme/app_shadows.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_icon_button.dart';

/// Shows a bottom sheet (board C5): one style on both platforms — 22 pt top
/// corners, a grab bar, swipe down to dismiss. Short forms ride on the
/// keyboard.
Future<T?> showAppSheet<T>(
  BuildContext context, {
  required WidgetBuilder builder,
}) {
  final AppColors colors = context.colors;
  final bool reduceMotion = AppMotion.reduceMotion(context);
  return showModalBottomSheet<T>(
    context: context,
    // Over the tab bar too, as the boards draw every sheet.
    useRootNavigator: true,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    barrierColor: colors.scrim,
    elevation: 0,
    sheetAnimationStyle: AnimationStyle(
      duration: reduceMotion ? Duration.zero : AppMotion.enter,
      reverseDuration: reduceMotion ? Duration.zero : AppMotion.base,
      curve: AppMotion.easeOut,
    ),
    builder: (BuildContext sheetContext) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(sheetContext).bottom,
      ),
      child: _SheetFrame(child: builder(sheetContext)),
    ),
  );
}

/// The sheet's card: 22 pt top corners and the floating shadow (`.sheet.i`).
class _SheetFrame extends StatelessWidget {
  const _SheetFrame({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = BorderRadius.vertical(
      top: Radius.circular(AppRadius.sheetTop.r),
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.card,
        borderRadius: radius,
        boxShadow: context.shadows.shadowFloat,
      ),
      child: ClipRRect(borderRadius: radius, child: child),
    );
  }
}

/// The content of a sheet: grab bar, title and close, then [child], then the
/// bottom safe area.
class AppSheet extends StatelessWidget {
  const AppSheet({
    required this.child,
    this.title,
    this.showClose = true,
    this.onClose,
    this.padding,
    super.key,
  });

  final Widget child;

  /// 20 pt ExtraBold (`.t20`).
  final String? title;
  final bool showClose;

  /// Pops the sheet by default.
  final VoidCallback? onClose;

  /// Around [child]; the board's 12 pt top and 16 pt sides by default.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 6.h),
          child: Center(
            child: Container(
              width: 36.w,
              height: 5.h,
              decoration: ShapeDecoration(
                color: colors.trackOff,
                shape: const StadiumBorder(),
              ),
            ),
          ),
        ),
        if (title != null || showClose)
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 6.h, 8.w, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: title == null
                      ? const SizedBox.shrink()
                      : Semantics(
                          header: true,
                          child: Text(
                            title!,
                            style: AppTextStyles(
                              context,
                            ).title().copyWith(color: colors.foreground),
                          ),
                        ),
                ),
                if (showClose)
                  AppCloseButton(
                    onPressed:
                        onClose ?? () => Navigator.of(context).maybePop(),
                  ),
              ],
            ),
          ),
        Flexible(
          child: Padding(
            padding: padding ?? EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
            child: child,
          ),
        ),
        SizedBox(height: 16.h + MediaQuery.paddingOf(context).bottom),
      ],
    );
  }
}
