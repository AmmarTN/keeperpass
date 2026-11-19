/// How long each kind of input may be (web `core/validation/limits.ts`), in
/// UTF-16 code units like the web's `maxLength`. Ceilings, never truncation:
/// trimming a password hands back one that no longer opens the account.
abstract final class InputLimits {
  static const int email = 255;
  static const int itemName = 500;
  static const int fieldName = 200;
  static const int fieldValue = 10000;
  static const int noteValue = 100000;
  static const int tagName = 100;
  static const int vaultName = 100;
}
