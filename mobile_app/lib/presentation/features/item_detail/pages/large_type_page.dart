import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_radius.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/text/secret_text.dart';
import 'package:keeperpass/presentation/features/item_detail/widgets/item_fields.dart';

/// Opens a secret in large type over everything (board `S3-21`).
Future<void> openLargeType(
  BuildContext context, {
  required Field field,
  required String itemName,
}) => Navigator.of(context, rootNavigator: true).push(
  MaterialPageRoute<void>(
    fullscreenDialog: true,
    builder: (_) => LargeTypePage(
      label: fieldLabel(field),
      itemName: itemName,
      value: field.value,
    ),
  ),
);

/// Each character numbered, for reading a secret onto another device. The
/// only screen that turns sideways (your answer, Part 8: one line in
/// landscape); it hides again when it is left.
class LargeTypePage extends StatefulWidget {
  const LargeTypePage({
    required this.label,
    required this.itemName,
    required this.value,
    super.key,
  });

  final String label;
  final String itemName;
  final String value;

  @override
  State<LargeTypePage> createState() => _LargeTypePageState();
}

class _LargeTypePageState extends State<LargeTypePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // The rest of the app is portrait-only (decision D11).
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final List<String> chars = widget.value.characters.toList();
    final bool sideways =
        MediaQuery.orientationOf(context) == Orientation.landscape;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // 64 pt, or taller when the text needs it (sideways, large text).
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: 64.r),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.r),
                child: Row(
                  spacing: 2.r,
                  children: <Widget>[
                    AppPressable(
                      onTap: () => Navigator.of(context).maybePop(),
                      semanticLabel: t.common.close,
                      shape: const CircleBorder(),
                      child: SizedBox.square(
                        dimension: 48.r,
                        child: Center(
                          child: AppIcon(
                            AppIconName.x,
                            size: 24,
                            stroke: 2,
                            color: colors.foreground,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 4.r),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Semantics(
                              header: true,
                              child: Text(
                                widget.label,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: styles
                                    .title()
                                    .resized(
                                      20,
                                      line: 24,
                                      weight: FontWeight.w800,
                                    )
                                    .copyWith(color: colors.foreground),
                              ),
                            ),
                            Text(
                              widget.itemName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: styles.secondary().copyWith(
                                color: colors.mutedForeground,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  16.r,
                  20.r,
                  16.r,
                  MediaQuery.paddingOf(context).bottom + 20.r,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Semantics(
                      container: true,
                      label: t.itemDetail.largeTypeLabel(
                        field: widget.label,
                        n: chars.length,
                      ),
                      image: true,
                      excludeSemantics: true,
                      child: _Grid(
                        chars: chars,
                        columns: sideways ? chars.length : 5,
                      ),
                    ),
                    SizedBox(height: 20.r),
                    Text(
                      '${t.itemDetail.largeTypeTurn}\n'
                      '${t.itemDetail.largeTypeHides}',
                      textAlign: TextAlign.center,
                      style: styles.secondary().copyWith(
                        color: colors.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// `.lgt`: cells of [columns], 8 pt apart.
class _Grid extends StatelessWidget {
  const _Grid({required this.chars, required this.columns});

  final List<String> chars;
  final int columns;

  @override
  Widget build(BuildContext context) {
    final double gap = 8.r;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final int perRow = columns.clamp(1, chars.isEmpty ? 1 : chars.length);
        final double width =
            (constraints.maxWidth - gap * (perRow - 1)) / perRow;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: <Widget>[
            for (int i = 0; i < chars.length; i++)
              SizedBox(
                width: width,
                child: _Cell(char: chars[i], number: i + 1),
              ),
          ],
        );
      },
    );
  }
}

/// `.lgc`: the character at 40 pt in Space Mono — digits in the accent,
/// symbols muted — over its position.
class _Cell extends StatelessWidget {
  const _Cell({required this.char, required this.number});

  final String char;
  final int number;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final Color color = switch (secretCharKind(char)) {
      SecretCharKind.digit => colors.accentStrong,
      SecretCharKind.symbol => colors.mutedForeground,
      SecretCharKind.letter => colors.foreground,
    };
    return Container(
      padding: EdgeInsets.only(top: 10.r, bottom: 8.r),
      decoration: ShapeDecoration(
        color: colors.card,
        shape: AppRadius.shape(
          context,
          12,
          side: BorderSide(color: colors.hairline, width: 1.r),
        ),
      ),
      child: Column(
        spacing: 2.r,
        children: <Widget>[
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              char,
              textScaler: TextScaler.noScaling,
              style: styles
                  .largeType()
                  .resized(40, line: 48)
                  .copyWith(color: color),
            ),
          ),
          Text(
            '$number',
            textScaler: TextScaler.noScaling,
            style: styles
                .badge()
                .resized(11, line: 14, weight: FontWeight.w700)
                .copyWith(color: colors.mutedForeground),
          ),
        ],
      ),
    );
  }
}
