import 'package:keeperpass/core/utils/text/fold.dart';
import 'package:keeperpass/core/utils/validation/limits.dart';
import 'package:keeperpass/core/utils/validation/text_safety.dart';

/// A local part, an `@`, and a dotted domain whose last label has 2+
/// non-digit characters (web `core/validation/email.ts`).
final RegExp _email = RegExp(
  r'^[^\s@]+@[^\s@.]+(?:\.[^\s@.]+)*\.[^\s@.\d]{2,}$',
);

/// Surrounding whitespace trimmed; case left alone.
String normalizeEmail(String value) => jsTrim(value);

bool isValidEmail(String value) {
  final String email = normalizeEmail(value);
  return email.isNotEmpty &&
      email.length <= InputLimits.email &&
      isDisplaySafe(email) &&
      _email.hasMatch(email);
}
