import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/brand/app_brand.dart';

/// Which account a step belongs to (`.chip2`, boards `U2-Create`,
/// `U2-New-vault`): the provider's logo, an optional lead-in ("Setting up
/// for"), the address in bold, and an optional trailing lock.
class AppAccountChip extends StatelessWidget {
  const AppAccountChip({
    required this.provider,
    required this.email,
    this.prefix,
    this.locked = false,
    super.key,
  });

  final AppProvider provider;
  final String email;

  /// "Setting up for".
  final String? prefix;

  /// A lock at the end: the account cannot be changed here.
  final bool locked;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final TextStyle text = AppTextStyles(
      context,
    ).secondary().copyWith(color: colors.foreground);

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        constraints: BoxConstraints(minHeight: 32.h),
        padding: EdgeInsetsDirectional.fromSTEB(8.w, 6.h, 12.w, 6.h),
        decoration: ShapeDecoration(
          color: colors.secondary,
          shape: const StadiumBorder(),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8.w,
          children: <Widget>[
            AppProviderLogo(provider, size: 16),
            Flexible(
              child: Text.rich(
                TextSpan(
                  children: <InlineSpan>[
                    if (prefix != null) TextSpan(text: '$prefix '),
                    TextSpan(
                      text: email,
                      style: prefix == null
                          ? null
                          : const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                style: text,
              ),
            ),
            if (locked)
              AppIcon(
                AppIconName.lock,
                size: 14,
                stroke: 2,
                color: colors.mutedForeground,
              ),
          ],
        ),
      ),
    );
  }
}
