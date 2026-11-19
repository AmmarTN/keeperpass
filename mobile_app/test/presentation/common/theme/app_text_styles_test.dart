import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';

import '../../../helpers/design_size.dart';

/// One row of the Typography board: size / line · weight · tracking.
typedef _Spec = (double size, double line, FontWeight weight, double tracking);

Map<String, (TextStyle, _Spec)> _table(AppTextStyles s) =>
    <String, (TextStyle, _Spec)>{
      'display': (s.display(), (56, 56, FontWeight.w800, -0.02)),
      'stat': (s.stat(), (30, 34, FontWeight.w800, -0.015)),
      'large-title': (s.largeTitle(), (32, 38, FontWeight.w800, -0.015)),
      'item-title': (s.itemTitle(), (26, 32, FontWeight.w800, -0.01)),
      'app-bar-title': (s.appBarTitle(), (22, 28, FontWeight.w800, 0)),
      'title': (s.title(), (20, 26, FontWeight.w800, -0.005)),
      'nav-title': (s.navTitle(), (17, 22, FontWeight.w800, 0)),
      'row-title': (s.rowTitle(), (16, 22, FontWeight.w700, 0)),
      'body': (s.body(), (15, 22, FontWeight.w400, 0)),
      'body-strong': (s.bodyStrong(), (15, 22, FontWeight.w600, 0)),
      'button-lg': (s.buttonLg(), (16, 20, FontWeight.w700, 0)),
      'button': (s.button(), (15, 20, FontWeight.w700, 0)),
      'form-label': (s.formLabel(), (14, 20, FontWeight.w600, 0)),
      'secondary': (s.secondary(), (13, 18, FontWeight.w400, 0)),
      'field-label': (s.fieldLabel(), (12, 16, FontWeight.w600, 0)),
      'section-label': (s.sectionLabel(), (12, 16, FontWeight.w700, 0.08)),
      'badge': (s.badge(), (12, 16, FontWeight.w700, 0)),
      'secret': (s.secret(), (16, 24, FontWeight.w400, 0.02)),
      'code': (s.code(), (22, 28, FontWeight.w700, 0.04)),
      'code-lg': (s.codeLg(), (28, 34, FontWeight.w700, 0.04)),
      'generated': (s.generated(), (24, 34, FontWeight.w400, 0.02)),
      'large-type': (s.largeType(), (44, 56, FontWeight.w700, 0)),
      'file-name': (s.fileName(), (13, 18, FontWeight.w400, 0)),
    };

void _expectSpec(String name, TextStyle style, _Spec spec) {
  final (double size, double line, FontWeight weight, double tracking) = spec;
  expect(style.fontSize, size, reason: '$name size');
  expect(
    style.height! * style.fontSize!,
    closeTo(line, 1e-9),
    reason: '$name line',
  );
  expect(style.fontWeight, weight, reason: '$name weight');
  expect(
    style.letterSpacing,
    closeTo(tracking * size, 1e-9),
    reason: '$name tracking',
  );
}

void main() {
  testWidgets('every style matches the Typography board at the design size', (
    WidgetTester tester,
  ) async {
    final BuildContext context = await designContext(tester);
    _table(AppTextStyles(context)).forEach(
      (String name, (TextStyle, _Spec) row) =>
          _expectSpec(name, row.$1, row.$2),
    );
  });

  testWidgets('Nunito for interface text, Space Mono for values', (
    WidgetTester tester,
  ) async {
    final AppTextStyles styles = AppTextStyles(await designContext(tester));
    expect(styles.body().fontFamily, startsWith('Nunito'));
    expect(styles.secret().fontFamily, startsWith('SpaceMono'));
  });

  testWidgets('tab label is 11 / 13 on iOS and 12 / 16 on Android', (
    WidgetTester tester,
  ) async {
    BuildContext context = await designContext(tester);
    _expectSpec('tab-label iOS', AppTextStyles(context).tabLabel(), (
      11,
      13,
      FontWeight.w700,
      0,
    ));

    context = await designContext(tester, platform: TargetPlatform.android);
    _expectSpec('tab-label Android', AppTextStyles(context).tabLabel(), (
      12,
      16,
      FontWeight.w700,
      0,
    ));
  });

  testWidgets('large styles grow with the system text size only up to 1.3x', (
    WidgetTester tester,
  ) async {
    late TextScaler scaler;
    await pumpAtDesignSize(
      tester,
      MediaQuery(
        data: const MediaQueryData(textScaler: TextScaler.linear(2)),
        child: Builder(
          builder: (BuildContext context) {
            scaler = AppTextStyles.largeStyleTextScaler(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    expect(scaler.scale(10), closeTo(13, 1e-9));
  });
}
