import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/features/design_tokens/pages/design_tokens_page.dart';

import '../../../helpers/design_size.dart';

void main() {
  testWidgets('lists every colour token in a Light and a Dark panel', (
    WidgetTester tester,
  ) async {
    await pumpAtDesignSize(tester, const DesignTokensPage());

    expect(find.text('Light'), findsOneWidget);
    for (final String name in AppColors.light.tokens.keys) {
      await tester.scrollUntilVisible(
        find.text(name).first,
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text(name), findsWidgets, reason: name);
    }

    await tester.scrollUntilVisible(
      find.text('Dark'),
      400,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Dark'), findsOneWidget);
  });
}
