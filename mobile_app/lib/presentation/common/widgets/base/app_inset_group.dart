import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_radius.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_surface.dart';

/// Where the hairline between two rows starts, in design points.
abstract final class AppDividerInset {
  /// Full width (`.frow`, `.srow`, `.qrow`, `.frow2`).
  static const double none = 0;

  /// Rows without a tile (`.sgrp.nt`).
  static const double text = 14;

  /// Settings rows with a 30 pt tile (`.srw`).
  static const double settings = 56;

  /// Item rows with a 40 pt tile (`.r`).
  static const double item = 66;
}

/// The rounded group of rows with inset hairlines (`.lst`, `.flist`, `.sgrp`,
/// `.grp`): item lists, field lists, settings groups and sheet groups.
class AppInsetGroup extends StatelessWidget {
  const AppInsetGroup({
    required this.children,
    this.dividerInset = AppDividerInset.none,
    this.flat = false,
    super.key,
  });

  /// `.grp` — a sheet group: the background colour, no ring or shadow.
  const AppInsetGroup.sheet({required this.children, super.key})
    : dividerInset = AppDividerInset.none,
      flat = true;

  final List<Widget> children;

  /// Left inset of the hairline between rows (see [AppDividerInset]).
  final double dividerInset;
  final bool flat;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final Widget divider = Padding(
      padding: EdgeInsets.only(left: dividerInset.w),
      child: SizedBox(height: 1, child: ColoredBox(color: colors.border)),
    );

    return AppSurface(
      radius: AppRadius.xxl,
      clip: true,
      color: flat ? colors.background : colors.card,
      elevation: flat ? AppElevation.flat : AppElevation.resting,
      ring: !flat,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int i = 0; i < children.length; i++) ...<Widget>[
            if (i > 0) divider,
            children[i],
          ],
        ],
      ),
    );
  }
}
