import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_strength_meter.dart';
import 'package:keeperpass/presentation/features/generator/cubit/generator_cubit.dart';
import 'package:keeperpass/presentation/features/generator/pages/generator_page.dart';

import '../../../helpers/screen_harness.dart';
import '../../../helpers/vault_world.dart';

void main() {
  late VaultWorld world;
  late GeneratorCubit cubit;

  Future<void> pumpGenerator(
    WidgetTester tester, {
    Brightness brightness = Brightness.light,
  }) async {
    world = VaultWorld();
    await tester.runAsync(world.open);
    cubit = world.generatorCubit();
    await tester.runAsync(cubit.start);
    addTearDown(() async {
      await cubit.close();
      await tester.runAsync(world.close);
    });
    await pumpScreen(
      tester,
      BlocProvider<GeneratorCubit>.value(
        value: cubit,
        child: const GeneratorScreen(),
      ),
      providers: world.providers,
      brightness: brightness,
    );
    await tester.pump();
  }

  /// Runs a cubit change (word lists load from files) and shows it.
  Future<void> change(WidgetTester tester, Future<void> Function() body) async {
    await tester.runAsync(body);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
  }

  AppButton button(WidgetTester tester, String label) =>
      tester.widget<AppButton>(find.widgetWithText(AppButton, label));

  for (final Brightness brightness in Brightness.values) {
    testWidgets('S4-07 Passphrase (${brightness.name}): 4 words, Dash, '
        'English; strength and size under it', (WidgetTester tester) async {
      await pumpGenerator(tester, brightness: brightness);

      expect(find.text('Password Generator'), findsWidgets);
      expect(
        find.text('Random passwords and passphrases, made on this device'),
        findsOneWidget,
      );
      expect(cubit.state.value.split('-'), hasLength(4));
      expect(find.text('· 4 words'), findsOneWidget);
      expect(find.byType(AppStrengthMeter), findsOneWidget);
      expect(find.text('Regenerate'), findsOneWidget);
      expect(find.text('Copy'), findsOneWidget);
      expect(find.text('Words'), findsOneWidget);
      expect(find.text('Word separator'), findsOneWidget);
      expect(find.text('Dash ( - )'), findsOneWidget);
      expect(find.text('Language'), findsOneWidget);
      expect(find.text('English'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('the result is read when reached, never announced (your '
      'answer, Part 10: as the web)', (WidgetTester tester) async {
    final SemanticsHandle semantics = tester.ensureSemantics();
    await pumpGenerator(tester);
    final SemanticsNode result = tester.getSemantics(
      find.bySemanticsLabel('Generated password'),
    );
    expect(result.value, cubit.state.value);
    expect(result.flagsCollection.isLiveRegion, isFalse);
    semantics.dispose();
  });

  testWidgets('Regenerate: a new value, with the selection haptic', (
    WidgetTester tester,
  ) async {
    final List<MethodCall> haptics = <MethodCall>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (MethodCall call) async {
        haptics.add(call);
        return null;
      },
    );
    await pumpGenerator(tester);
    final String before = cubit.state.value;
    await tester.tap(find.text('Regenerate'));
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(cubit.state.value, isNot(before));
    expect(
      haptics.map((MethodCall c) => c.arguments),
      contains('HapticFeedbackType.selectionClick'),
    );
  });

  testWidgets('S4-08 Language: five lists, each named in its own language', (
    WidgetTester tester,
  ) async {
    await pumpGenerator(tester);
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();
    for (final String name in <String>[
      'Deutsch',
      'Español',
      'Français',
      'Português',
    ]) {
      expect(find.text(name), findsOneWidget, reason: name);
    }
    await tester.tap(find.text('Français'));
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
    await tester.pumpAndSettle();
    expect(cubit.state.language, 'fr');
    expect(find.text('Français'), findsOneWidget);
  });

  testWidgets('Word separator: the web\'s four, by name', (
    WidgetTester tester,
  ) async {
    await pumpGenerator(tester);
    await tester.tap(find.text('Dash ( - )'));
    await tester.pumpAndSettle();
    for (final String name in <String>[
      'Underscore ( _ )',
      'Slash ( / )',
      'Space',
    ]) {
      expect(find.text(name), findsOneWidget, reason: name);
    }
    await tester.tap(find.text('Slash ( / )'));
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
    await tester.pumpAndSettle();
    expect(cubit.state.separator, '/');
    expect(cubit.state.value.split('/'), hasLength(4));
  });

  testWidgets('S4-09 Random string: 20 characters, four tiles, symbols off', (
    WidgetTester tester,
  ) async {
    await pumpGenerator(tester);
    await tester.tap(find.text('Random string'));
    await change(tester, () => Future<void>.delayed(Duration.zero));

    expect(cubit.state.value, hasLength(20));
    expect(find.text('· 20 characters'), findsOneWidget);
    expect(find.text('Length'), findsOneWidget);
    for (final String tile in <String>['a–z', 'A–Z', '0–9', '?()/%…']) {
      expect(find.text(tile), findsOneWidget, reason: tile);
    }
    expect(find.text('Word separator'), findsNothing);
  });

  testWidgets('S4-10 Copied: on the button for 1 s, and the toast', (
    WidgetTester tester,
  ) async {
    await pumpGenerator(tester);
    await tester.tap(find.bySemanticsLabel('Copy password'));
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));

    expect(world.clipboard.copied, <String>[cubit.state.value]);
    expect(find.text('Copied'), findsOneWidget);
    expect(find.text('Password copied'), findsOneWidget);
    expect(find.text('From the generator · Clears in 30 s'), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(milliseconds: 250));
    expect(find.text('Copied'), findsNothing);
    expect(find.text('Copy'), findsOneWidget);
    // The clipboard's 30 s run out.
    await tester.pump(const Duration(seconds: 30));
  });

  for (final Brightness brightness in Brightness.values) {
    testWidgets('S4-11 Nothing to generate (${brightness.name}): the card '
        'says so and both buttons rest', (WidgetTester tester) async {
      await pumpGenerator(tester, brightness: brightness);
      await change(tester, () async {
        await cubit.setMode(GeneratorMode.randomString);
      });
      final double cardBottom = tester.getBottomLeft(find.text('Copy')).dy;

      await change(tester, () async {
        await cubit.setLowercase(false);
        await cubit.setUppercase(false);
        await cubit.setDigits(false);
      });
      expect(find.text('Nothing to generate.'), findsOneWidget);
      expect(find.text('Pick at least one kind of character.'), findsOneWidget);
      expect(button(tester, 'Regenerate').onPressed, isNull);
      expect(button(tester, 'Copy').onPressed, isNull);
      expect(
        tester.widget<AppStrengthMeter>(find.byType(AppStrengthMeter)).strength,
        isNull,
      );
      // The result card keeps its height, so nothing below it jumps.
      expect(tester.getBottomLeft(find.text('Copy')).dy, cardBottom);
    });
  }

  testWidgets('S4-12 Deutsch, 6 words: Space, German words, wrapped at '
      'the separators', (WidgetTester tester) async {
    await pumpGenerator(tester);
    await change(tester, () async {
      await cubit.setLanguage('de');
      await cubit.setWordCount(6);
      await cubit.setSeparator(' ');
    });
    final List<String> german = (await tester.runAsync(
      () => FileBundledData().wordList('de'),
    ))!.getOrElse(() => const <String>[]);
    final List<String> words = cubit.state.value.split(' ');
    expect(words, hasLength(6));
    expect(words.every(german.contains), isTrue);
    expect(find.text('· 6 words'), findsOneWidget);
    expect(find.text('Deutsch'), findsOneWidget);
    expect(find.text('Space'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
