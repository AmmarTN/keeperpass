import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';

/// A board's block in the gallery: its name, then specimens with captions.
class GallerySection extends StatelessWidget {
  const GallerySection({
    required this.title,
    required this.children,
    super.key,
  });

  /// "C1 · Buttons and fields".
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 28.h, 16.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 12.h,
        children: <Widget>[
          Text(
            title,
            style: AppTextStyles(
              context,
            ).itemTitle().copyWith(color: context.colors.foreground),
          ),
          ...children,
        ],
      ),
    );
  }
}

/// One specimen: a caption and the component(s).
class GallerySpecimen extends StatelessWidget {
  const GallerySpecimen(this.caption, {required this.child, super.key});

  /// "Primary — default, disabled, busy".
  final String caption;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8.h,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Text(
            caption.toUpperCase(),
            style: AppTextStyles(
              context,
            ).sectionLabel().copyWith(color: context.colors.mutedForeground),
          ),
        ),
        child,
      ],
    );
  }
}

/// A wrap of specimens with the board's gaps.
class GalleryWrap extends StatelessWidget {
  const GalleryWrap({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: children,
    );
  }
}

/// The demos' callbacks: nothing to wire in the gallery.
void galleryNoop() {}
