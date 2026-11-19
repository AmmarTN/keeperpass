import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/routes/router.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_bars.dart';

/// Temporary: a screen a later part builds (your answer, Part 7) — a tab
/// root, or pushed in a tab with Back. Replaced part by part.
class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({
    required this.title,
    required this.part,
    this.pushed = false,
    this.developerLinks = false,
    super.key,
  });

  final String title;
  final int part;

  /// Pushed in a tab: Back returns to the list.
  final bool pushed;

  /// Debug builds only: the design tokens and component gallery (Settings).
  final bool developerLinks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: AppLargeTitleScrollView(
        title: title,
        leading: pushed
            ? AppLinkButton.back(
                label: t.common.back,
                onPressed: () => Navigator.of(context).maybePop(),
              )
            : null,
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    t.comingSoon.body(part: part),
                    style: AppTextStyles(
                      context,
                    ).body().copyWith(color: context.colors.mutedForeground),
                  ),
                  // Debug-only developer links, never shown in release builds.
                  if (developerLinks && kDebugMode) ...<Widget>[
                    SizedBox(height: 12.h),
                    AppLinkButton(
                      label: 'Design tokens',
                      horizontalPadding: 0,
                      onPressed: () =>
                          context.router.push(const DesignTokensRoute()),
                    ),
                    AppLinkButton(
                      label: 'Components',
                      horizontalPadding: 0,
                      onPressed: () =>
                          context.router.push(const ComponentGalleryRoute()),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
