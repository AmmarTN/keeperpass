import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/utils/validation/password_strength.dart';
import 'package:keeperpass/presentation/features/generator/cubit/generator_cubit.dart';

import '../../../helpers/vault_world.dart';

void main() {
  late VaultWorld world;
  late GeneratorCubit cubit;

  setUp(() {
    world = VaultWorld();
    cubit = world.generatorCubit();
  });
  tearDown(() => cubit.close());

  test(
    'starts like the Generator tab: 4 English words joined by "-"',
    () async {
      await cubit.start();
      expect(cubit.state.mode, GeneratorMode.passphrase);
      final List<String> words = cubit.state.value.split('-');
      expect(words, hasLength(4));
      expect(words.every((String w) => w.isNotEmpty), isTrue);
      expect(
        cubit.state.score,
        estimatePasswordStrength(cubit.state.value).score,
      );
    },
  );

  test('words and separator; counts stay in 3–12', () async {
    await cubit.setWordCount(20);
    expect(cubit.state.wordCount, kMaxWordCount);
    await cubit.setSeparator('_');
    expect(cubit.state.value.split('_'), hasLength(12));
    await cubit.setWordCount(1);
    expect(cubit.state.wordCount, kMinWordCount);
  });

  test('random string: 20 of a–z, A–Z, 0–9 by default; 5–150', () async {
    await cubit.setMode(GeneratorMode.randomString);
    expect(cubit.state.value, hasLength(20));
    expect(cubit.state.value, matches(RegExp(r'^[a-zA-Z0-9]+$')));
    await cubit.setLength(500);
    expect(cubit.state.value, hasLength(kMaxLength));
    await cubit.setLength(1);
    expect(cubit.state.value, hasLength(kMinLength));
  });

  test('no kind of character: nothing to use', () async {
    await cubit.setMode(GeneratorMode.randomString);
    await cubit.setLowercase(false);
    await cubit.setUppercase(false);
    await cubit.setDigits(false);
    expect(cubit.state.charsetEmpty, isTrue);
    expect(cubit.state.value, isEmpty);
    await cubit.setSymbols(true);
    expect(cubit.state.value, matches(RegExp(r'^[^a-zA-Z0-9]+$')));
  });

  test('another language\'s words', () async {
    await cubit.setLanguage('de');
    expect(cubit.state.language, 'de');
    expect(cubit.state.value.split('-'), hasLength(4));
  });

  test('Copy (the Generator tab) copies the suggestion as it is', () async {
    await cubit.start();
    expect(await cubit.copy(), isNotNull);
    expect(world.clipboard.copied, <String>[cubit.state.value]);

    await cubit.setMode(GeneratorMode.randomString);
    await cubit.setLowercase(false);
    await cubit.setUppercase(false);
    await cubit.setDigits(false);
    expect(await cubit.copy(), isNull);
    expect(world.clipboard.copied, hasLength(1));
  });
}
