/// The eight tag colours, in the web's palette order
/// (`web/src/app/core/vault/tag-color.ts`).
enum TagColor { blue, yellowGreen, green, orange, pink, teal, gold, slate }

const int _seed = 0x811c9dc5;

/// JavaScript bit operations work on 32-bit integers; Dart's are 64-bit.
/// Every shift and xor is masked back to 32 bits so the result matches the
/// web exactly (plan, porting trap 1).
const int _mask = 0xFFFFFFFF;

int _scramble(int state) {
  int next = state;
  next = (next ^ (next << 13)) & _mask;
  next = (next ^ (next >>> 17)) & _mask;
  next = (next ^ (next << 5)) & _mask;
  return next;
}

/// The tag's colour, hashed from its name exactly like the web, so a tag has
/// the same colour on every device and in the web app.
TagColor tagColorFor(String name) {
  int state = _seed;
  for (final int codePoint in name.runes) {
    state = _scramble((state ^ codePoint) & _mask);
  }

  final int folded = (state ^ (state >>> 11) ^ (state >>> 22)) & _mask;
  return TagColor.values[folded % TagColor.values.length];
}
