import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_fixed_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/widgets/brand/app_brand.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_icon_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_provider_button.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_spinner.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_strength_meter.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_search_field.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_secret_field.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_text_field.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_typed_fields.dart';
import 'package:keeperpass/presentation/common/widgets/text/secret_text.dart';

import '../../../helpers/component_harness.dart';

void main() {
  group('AppButton', () {
    testWidgets('fills per variant in both themes', (
      WidgetTester tester,
    ) async {
      await inBothThemes((Brightness brightness) async {
        await pumpComponent(
          tester,
          Column(
            children: <Widget>[
              AppButton(label: 'Unlock', onPressed: () {}, key: const Key('p')),
              AppButton(
                label: 'Start a new vault',
                variant: AppButtonVariant.destructive,
                onPressed: () {},
                key: const Key('t'),
              ),
              AppButton(
                label: 'Delete item',
                variant: AppButtonVariant.destructiveSolid,
                onPressed: () {},
                key: const Key('s'),
              ),
            ],
          ),
          brightness: brightness,
        );
        final AppColors colors = tester
            .element(find.byType(Column).first)
            .colors;
        expect(fillUnder(tester, find.byKey(const Key('p'))), colors.primary);
        expect(
          fillUnder(tester, find.byKey(const Key('t'))),
          colors.destructiveTint,
        );
        expect(
          fillUnder(tester, find.byKey(const Key('s'))),
          colors.destructive,
        );
        expect(
          tester.widget<Text>(find.text('Delete item')).style!.color,
          AppFixedColors.onDestructive,
        );
        expect(
          tester.widget<Text>(find.text('Unlock')).style!.color,
          colors.primaryForeground,
        );
      });
    });

    testWidgets('busy shows the spinner, fades and ignores taps', (
      WidgetTester tester,
    ) async {
      int taps = 0;
      await pumpComponent(
        tester,
        AppButton(label: 'Unlocking…', busy: true, onPressed: () => taps++),
        settle: false,
      );
      expect(find.byType(AppSpinner), findsOneWidget);
      expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 0.5);
      await tester.tap(find.text('Unlocking…'), warnIfMissed: false);
      expect(taps, 0);
    });

    testWidgets('is 52 pt (44 medium) and disabled when onPressed is null', (
      WidgetTester tester,
    ) async {
      await pumpComponent(
        tester,
        const Column(
          children: <Widget>[
            AppButton(label: 'Large', onPressed: null, key: Key('l')),
            AppButton(
              label: 'Medium',
              size: AppButtonSize.medium,
              onPressed: null,
              key: Key('m'),
            ),
          ],
        ),
      );
      expect(tester.getSize(find.byKey(const Key('l'))).height, 52);
      expect(tester.getSize(find.byKey(const Key('m'))).height, 44);
      expect(
        tester.getSemantics(find.byKey(const Key('l'))),
        matchesSemantics(isButton: true, hasEnabledState: true, label: 'Large'),
      );
    });
  });

  testWidgets('AppLinkButton.back shows the chevron and the previous title', (
    WidgetTester tester,
  ) async {
    await pumpComponent(
      tester,
      AppLinkButton.back(label: 'All Vaults', onPressed: () {}),
    );
    expect(findAppIcon(AppIconName.chevronLeft), findsOneWidget);
    expect(
      tester.getSize(find.byType(AppLinkButton)).height,
      greaterThanOrEqualTo(44),
    );
  });

  testWidgets(
    'AppProviderButton: logo and arrow at rest; spinner and accent ring when busy',
    (WidgetTester tester) async {
      await pumpComponent(
        tester,
        AppProviderButton(
          provider: AppProvider.google,
          label: 'Continue with Google',
          onPressed: () {},
        ),
      );
      expect(find.byType(AppProviderLogo), findsOneWidget);
      expect(findAppIcon(AppIconName.arrowRight), findsOneWidget);

      await pumpComponent(
        tester,
        AppProviderButton(
          provider: AppProvider.google,
          label: 'Connecting to Google…',
          busy: true,
          onPressed: () {},
        ),
        settle: false,
      );
      expect(find.byType(AppSpinner), findsOneWidget);
      expect(findAppIcon(AppIconName.arrowRight), findsNothing);
    },
  );

  group('AppCopyButton', () {
    testWidgets(
      'copies, plays the copy haptic, shows the check for 1 s',
      (WidgetTester tester) async {
        final List<String?> haptics = <String?>[];
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(SystemChannels.platform, (
              MethodCall call,
            ) async {
              if (call.method == 'HapticFeedback.vibrate') {
                haptics.add(call.arguments as String?);
              }
              return null;
            });
        addTearDown(
          () => TestDefaultBinaryMessengerBinding
              .instance
              .defaultBinaryMessenger
              .setMockMethodCallHandler(SystemChannels.platform, null),
        );

        int copies = 0;
        await pumpComponent(
          tester,
          AppCopyButton(
            semanticLabel: 'Copy password for GitHub',
            onCopy: () => copies++,
          ),
        );
        await tester.tap(find.bySemanticsLabel('Copy password for GitHub'));
        await tester.pump();
        expect(copies, 1);
        expect(haptics, <String>['HapticFeedbackType.lightImpact']);
        expect(findAppIcon(AppIconName.check), findsOneWidget);
        expect(find.bySemanticsLabel('Copied'), findsOneWidget);

        await tester.pump(const Duration(seconds: 1));
        expect(findAppIcon(AppIconName.copy), findsOneWidget);
        // AppHaptics follows the device platform: iOS plays a light impact.
      },
      variant: TargetPlatformVariant.only(TargetPlatform.iOS),
    );

    testWidgets(
      'icon buttons keep a 44 pt target on iOS and 48 dp on Android',
      (WidgetTester tester) async {
        await pumpComponent(
          tester,
          AppIconButton(
            icon: AppIconName.lockKeyhole,
            semanticLabel: 'Lock',
            onPressed: () {},
          ),
        );
        expect(tester.getSize(find.byType(AppIconButton)), const Size(44, 44));
        await pumpComponent(
          tester,
          AppIconButton(
            icon: AppIconName.lockKeyhole,
            semanticLabel: 'Lock',
            onPressed: () {},
          ),
          platform: TargetPlatform.android,
        );
        expect(tester.getSize(find.byType(AppIconButton)), const Size(48, 48));
        await pumpComponent(tester, AppCloseButton(onPressed: () {}));
        expect(find.bySemanticsLabel('Close'), findsOneWidget);
      },
    );
  });

  group('AppTextField', () {
    testWidgets('error: red ring and the sentence; dimmed: 60 %', (
      WidgetTester tester,
    ) async {
      await inBothThemes((Brightness brightness) async {
        await pumpComponent(
          tester,
          Column(
            children: <Widget>[
              AppTextField(
                controller: TextEditingController(text: 'jane@icloud'),
                errorText: 'That does not look like an email address.',
              ),
              AppTextField(
                controller: TextEditingController(text: 'janedoe-dev'),
                readOnly: true,
                dimmed: true,
              ),
            ],
          ),
          brightness: brightness,
        );
        expect(
          find.text('That does not look like an email address.'),
          findsOneWidget,
        );
        expect(findAppIcon(AppIconName.circleAlert), findsOneWidget);
        expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 0.6);
      });
    });

    testWidgets('focus draws the accent ring', (WidgetTester tester) async {
      await pumpComponent(
        tester,
        AppTextField(
          controller: TextEditingController(),
          placeholder: 'e.g. GitHub',
        ),
      );
      List<BoxShadow> ring() =>
          (tester
                      .widget<Container>(
                        find
                            .descendant(
                              of: find.byType(AppTextField),
                              matching: find.byType(Container),
                            )
                            .first,
                      )
                      .decoration!
                  as ShapeDecoration)
              .shadows!;
      expect(ring(), hasLength(2)); // shadow-xs + hairline
      await tester.tap(find.byType(TextField));
      await tester.pump();
      expect(ring(), hasLength(2)); // --focus: the 1.5 pt ring + its glow
      expect(ring().first.spreadRadius, 1.5);
    });
  });

  testWidgets('AppSecretField reveals, hides and shows its meter', (
    WidgetTester tester,
  ) async {
    await pumpComponent(
      tester,
      AppSecretField(
        controller: SecretTextEditingController(text: 'Tq7#vR'),
        label: 'Secret',
        strength: AppStrength.veryStrong,
      ),
    );
    TextField field() => tester.widget<TextField>(find.byType(TextField));
    expect(field().obscureText, isTrue);
    expect(find.text('Very strong'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Show secret'));
    await tester.pump();
    expect(field().obscureText, isFalse);
    expect(find.bySemanticsLabel('Hide secret'), findsOneWidget);
  });

  testWidgets('AppSearchField shows the clear button once there is a query', (
    WidgetTester tester,
  ) async {
    final TextEditingController query = TextEditingController();
    await pumpComponent(
      tester,
      AppSearchField(controller: query, placeholder: 'Search 23 items'),
    );
    expect(find.bySemanticsLabel('Clear search'), findsNothing);
    await tester.enterText(find.byType(TextField), 'work');
    await tester.pump();
    await tester.tap(find.bySemanticsLabel('Clear search'));
    await tester.pump();
    expect(query.text, isEmpty);
  });

  testWidgets('AppDateField opens its picker from the field and the button', (
    WidgetTester tester,
  ) async {
    int picks = 0;
    await pumpComponent(
      tester,
      AppDateField(
        semanticLabel: 'Birthday',
        valueText: 'Apr 12, 1992',
        onPick: () => picks++,
      ),
    );
    await tester.tap(find.bySemanticsLabel('Choose a date'));
    await tester.tap(find.byType(TextField));
    expect(picks, 2);
  });

  testWidgets('AppPhoneField says the country and code', (
    WidgetTester tester,
  ) async {
    await pumpComponent(
      tester,
      AppPhoneField(
        controller: TextEditingController(),
        dialCode: '+1',
        countryName: 'United States',
        flag: const SizedBox(),
        onPickCountry: () {},
        semanticLabel: 'Phone number',
      ),
    );
    expect(
      find.bySemanticsLabel('Country code: United States, +1'),
      findsOneWidget,
    );
  });
}
