import 'dart:math';
import 'dart:typed_data';

/// Passwords and passphrases (web `core/generator/generator.ts`): the same
/// unbiased algorithms over a cryptographically secure byte source.

/// Fills a buffer with random bytes — `Random.secure()` in the app, a fixed
/// tape in tests.
typedef RandomBytes = Uint8List Function(int length);

Uint8List secureRandomBytes(int length) {
  final Random random = Random.secure();
  return Uint8List.fromList(
    List<int>.generate(length, (_) => random.nextInt(256)),
  );
}

String _range(int first, int last) =>
    String.fromCharCodes(<int>[for (int c = first; c <= last; c++) c]);

/// The character sets the generator offers.
abstract final class GeneratorAlphabets {
  static final String digits = _range(0x30, 0x39);
  static final String uppercase = _range(0x41, 0x5a);
  static final String lowercase = _range(0x61, 0x7a);

  /// Printable ASCII that is not a letter or digit.
  static final String symbols = _range(0x21, 0x7e)
      .split('')
      .where(
        (String c) =>
            !digits.contains(c) &&
            !uppercase.contains(c) &&
            !lowercase.contains(c),
      )
      .join();
}

const int _maxAlphabetSize = 256;

/// [length] characters drawn uniformly from [alphabet]: byte values in the
/// biased tail above the last whole multiple of the alphabet size are thrown
/// away, never wrapped. Draws [length] bytes at a time, as the web does.
String randomString(
  int length,
  String alphabet, {
  RandomBytes random = secureRandomBytes,
}) {
  final List<String> characters = alphabet.runes
      .map(String.fromCharCode)
      .toList();
  if (length <= 0 || characters.isEmpty) return '';
  if (characters.length > _maxAlphabetSize) {
    throw ArgumentError(
      'An alphabet of more than $_maxAlphabetSize characters is not supported.',
    );
  }
  final int usableBytes =
      _maxAlphabetSize - (_maxAlphabetSize % characters.length);
  final StringBuffer picked = StringBuffer();
  int count = 0;
  while (count < length) {
    for (final int byte in random(length)) {
      if (byte >= usableBytes) continue;
      picked.write(characters[byte % characters.length]);
      if (++count == length) break;
    }
  }
  return picked.toString();
}

/// A uniform integer in [min]–[max] from 32-bit draws, rejecting the biased
/// tail. Each draw reads four little-endian bytes, like the web's
/// `Uint32Array`.
int randomInt(int min, int max, {RandomBytes random = secureRandomBytes}) {
  if (max < min) throw ArgumentError('Empty range: $min to $max.');
  final int range = max - min + 1;
  if (range == 1) return min;
  const int span = 0x100000000;
  final int blocks = span - (span % range);
  int value;
  do {
    value = ByteData.sublistView(random(4)).getUint32(0, Endian.little);
  } while (value >= blocks);
  return min + (value % range);
}

/// The passphrase languages (web `AVAILABLE_LANGUAGES`).
const List<({String value, String label})> kGeneratorLanguages =
    <({String value, String label})>[
      (value: 'en', label: 'English'),
      (value: 'de', label: 'Deutsch'),
      (value: 'es', label: 'Español'),
      (value: 'fr', label: 'Français'),
      (value: 'pt', label: 'Português'),
    ];

/// The word separators (web `SEPARATOR_OPTIONS`): dash, underscore, slash,
/// space.
const List<String> kGeneratorSeparators = <String>['-', '_', '/', ' '];

/// [wordCount] words from [words], joined by [separator]. Empty when there
/// are no words.
String generatePassphrase(
  List<String> words,
  int wordCount,
  String separator, {
  RandomBytes random = secureRandomBytes,
}) {
  if (words.isEmpty) return '';
  return <String>[
    for (int i = 0; i < wordCount; i++)
      words[randomInt(0, words.length - 1, random: random)],
  ].join(separator);
}
