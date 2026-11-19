import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/presentation/features/component_gallery/pages/component_gallery_page.dart';

import '../../../helpers/design_size.dart';

void main() {
  testWidgets(
    'the gallery builds every board in Light and Dark without errors',
    (WidgetTester tester) async {
      await pumpAtDesignSize(
        tester,
        const ComponentGalleryPage(),
        settle: false,
      );

      Future<void> scrollThrough() async {
        for (final String board in <String>[
          'C2 · Rows, lists and cards',
          'C3 · Selection controls',
          'C4 · Navigation and bars',
          'C5 · Sheets, menus and dialogs',
          'C6 · Feedback and status',
          'C7 · Tiles, badges and data',
        ]) {
          // Move the gallery's own list (a drag could land on the large-title
          // demo, which scrolls by itself).
          final ScrollableState list = tester.state<ScrollableState>(
            find
                .descendant(
                  of: find.byType(ListView),
                  matching: find.byType(Scrollable),
                )
                .first,
          );
          while (find.text(board).evaluate().isEmpty &&
              list.position.pixels < list.position.maxScrollExtent) {
            list.position.jumpTo(list.position.pixels + 400);
            await tester.pump(const Duration(milliseconds: 50));
          }
          expect(find.text(board), findsOneWidget);
        }
      }

      expect(find.text('C1 · Buttons and fields'), findsOneWidget);
      await scrollThrough();

      await tester.tap(find.text('Dark'));
      await tester.pump(const Duration(milliseconds: 300));
      expect(
        Theme.of(
          tester.element(find.text('C7 · Tiles, badges and data')),
        ).brightness,
        Brightness.dark,
      );
      expect(tester.takeException(), isNull);
    },
  );
}
