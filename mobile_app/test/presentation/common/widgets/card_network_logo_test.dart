import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/utils/validation/card_number.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_card_network_logo.dart';

import '../../../helpers/component_harness.dart';

CardBrand network(String id) =>
    kCardBrands.firstWhere((CardBrand b) => b.id == id);

/// The asset the logo on screen draws.
String? drawnAsset(WidgetTester tester) {
  final Finder svg = find.byType(SvgPicture);
  if (svg.evaluate().isEmpty) return null;
  final BytesLoader loader = tester.widget<SvgPicture>(svg).bytesLoader;
  return (loader as SvgAssetLoader).assetName;
}

void main() {
  test('every logo in the table is bundled, draws, and has the size the '
      'table says, light and dark (your answer, 2026-11-05)', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    for (final MapEntry<String, (double, bool)> logo
        in AppCardNetworkLogo.logos.entries) {
      final (double aspect, bool hasDark) = logo.value;
      for (final String file in <String>[
        logo.key,
        if (hasDark) '${logo.key}-dark',
      ]) {
        final String svg = await rootBundle.loadString(
          'assets/card_networks/$file.svg',
        );
        final RegExpMatch frame = RegExp(
          r'<svg[^>]*\swidth="([\d.]+)"\s+height="([\d.]+)"',
        ).firstMatch(svg)!;
        expect(
          double.parse(frame[1]!) / double.parse(frame[2]!),
          closeTo(aspect, 0.001),
          reason: file,
        );
        expect(svg, isNot(contains('<style')), reason: file);
        final PictureInfo picture = await vg.loadPicture(
          SvgStringLoader(svg),
          null,
        );
        expect(picture.size.isEmpty, isFalse, reason: file);
        picture.picture.dispose();
      }
    }
  });

  test('wide and round logos come out about the same size, within '
      '72 × 28 pt', () {
    for (final (double aspect, bool _) in AppCardNetworkLogo.logos.values) {
      final Size size = AppCardNetworkLogo.sizeFor(aspect);
      expect(size.width, lessThanOrEqualTo(72));
      expect(size.height, lessThanOrEqualTo(28));
      expect(size.width / size.height, closeTo(aspect, 0.001));
    }
    expect(AppCardNetworkLogo.sizeFor(664 / 218).width, closeTo(56.3, 0.1));
    expect(AppCardNetworkLogo.sizeFor(566 / 352).height, closeTo(25.4, 0.1));
  });

  testWidgets('the dark card takes the white-letter version where there is '
      'one', (WidgetTester tester) async {
    Future<String?> drawn(String id, Brightness brightness) async {
      await pumpComponent(
        tester,
        AppCardNetworkLogo(network(id)),
        brightness: brightness,
        settle: false,
      );
      return drawnAsset(tester);
    }

    expect(
      await drawn('visa', Brightness.light),
      'assets/card_networks/visa.svg',
    );
    expect(
      await drawn('visa', Brightness.dark),
      'assets/card_networks/visa-dark.svg',
    );
    expect(
      await drawn('mastercard', Brightness.dark),
      'assets/card_networks/mastercard.svg',
    );
  });

  testWidgets('a network without a logo shows its name, as before', (
    WidgetTester tester,
  ) async {
    await pumpComponent(tester, AppCardNetworkLogo(network('troy')));
    expect(find.text('Troy'), findsOneWidget);
    expect(find.byType(SvgPicture), findsNothing);
  });

  testWidgets('a logo that cannot be drawn shows the name instead', (
    WidgetTester tester,
  ) async {
    await pumpComponent(
      tester,
      AppCardNetworkLogo(network('visa'), folder: 'assets/nowhere'),
      settle: false,
    );
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
    await tester.pump();
    expect(find.text('Visa'), findsOneWidget);
  });
}
