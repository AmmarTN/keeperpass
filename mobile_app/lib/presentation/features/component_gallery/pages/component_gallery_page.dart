import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_theme_data.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_bars.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_segmented_control.dart';
import 'package:keeperpass/presentation/features/component_gallery/widgets/gallery_c1_buttons_fields.dart';
import 'package:keeperpass/presentation/features/component_gallery/widgets/gallery_c2_rows_lists.dart';
import 'package:keeperpass/presentation/features/component_gallery/widgets/gallery_c3_c4_selection_navigation.dart';
import 'package:keeperpass/presentation/features/component_gallery/widgets/gallery_c5_overlays.dart';
import 'package:keeperpass/presentation/features/component_gallery/widgets/gallery_c6_c7_feedback_data.dart';

/// Debug builds only (see the router): every component of boards C1–C7, in
/// Light or Dark. Labels are specimen captions for developers, not
/// user-facing copy.
@RoutePage()
class ComponentGalleryPage extends StatefulWidget {
  const ComponentGalleryPage({super.key});

  @override
  State<ComponentGalleryPage> createState() => _ComponentGalleryPageState();
}

class _ComponentGalleryPageState extends State<ComponentGalleryPage> {
  Brightness _brightness = Brightness.light;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppThemeData.getAppThemeData(
        brightness: _brightness,
        context: context,
      ),
      child: Builder(
        builder: (BuildContext context) {
          final AppColors colors = context.colors;
          return Scaffold(
            backgroundColor: colors.background,
            body: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.paddingOf(context).top),
                AppCompactBar(
                  title: 'Components',
                  leading: AppLinkButton.back(
                    label: 'Back',
                    onPressed: () => context.router.maybePop(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: AppSegmentedControl<Brightness>(
                    semanticLabel: 'Theme',
                    segments: const <AppSegment<Brightness>>[
                      AppSegment<Brightness>(Brightness.light, 'Light'),
                      AppSegment<Brightness>(Brightness.dark, 'Dark'),
                    ],
                    selected: _brightness,
                    onChanged: (Brightness value) =>
                        setState(() => _brightness = value),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(
                      bottom: 48.h + MediaQuery.paddingOf(context).bottom,
                    ),
                    children: const <Widget>[
                      GalleryButtonsFields(),
                      GalleryRowsLists(),
                      GallerySelection(),
                      GalleryNavigation(),
                      GalleryOverlays(),
                      GalleryFeedback(),
                      GalleryData(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
