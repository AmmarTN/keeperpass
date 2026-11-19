import 'package:keeperpass/core/utils/text/fold.dart';
import 'package:keeperpass/core/utils/validation/email.dart';
import 'package:keeperpass/core/utils/validation/password_strength.dart';
import 'package:keeperpass/core/utils/validation/text_safety.dart';

/// What is wrong with a value (web `core/validation/validators.ts`, minus
/// Angular's form plumbing). Empty values pass every rule but "required";
/// each screen maps these to its own message.
enum InputProblem {
  email,
  tooLong,
  controlCharacters,
  bidiControl,
  invisibleCharacters,
  lineBreak,
  blank,
  weakPassword,
  mismatch,
}

/// `emailValidator`.
InputProblem? checkEmail(String value) =>
    value.isEmpty || isValidEmail(value) ? null : InputProblem.email;

/// `maxLength` — in UTF-16 code units, like the web.
InputProblem? checkMaxLength(String value, int limit) =>
    value.length > limit ? InputProblem.tooLong : null;

/// `displaySafeValidator`: every problem found.
Set<InputProblem> checkDisplaySafe(String value) => <InputProblem>{
  if (value.isNotEmpty && hasControlCharacters(value))
    InputProblem.controlCharacters,
  if (value.isNotEmpty && hasBidiControl(value)) InputProblem.bidiControl,
  if (value.isNotEmpty && hasInvisibleCharacters(value))
    InputProblem.invisibleCharacters,
};

/// `singleLineValidator`: display-safe and no line break.
Set<InputProblem> checkSingleLine(String value) => <InputProblem>{
  ...checkDisplaySafe(value),
  if (value.isNotEmpty && hasLineBreak(value)) InputProblem.lineBreak,
};

/// `nonBlankValidator`.
InputProblem? checkNonBlank(String value) =>
    value.isEmpty || jsTrim(value).isNotEmpty ? null : InputProblem.blank;

/// `masterPasswordValidator`.
InputProblem? checkMasterPassword(
  String value, {
  int minimumScore = kMinMasterPasswordScore,
}) => value.isEmpty || estimatePasswordStrength(value).score >= minimumScore
    ? null
    : InputProblem.weakPassword;

/// `matchesValidator`: nothing until the confirmation has text.
InputProblem? checkMatches(String source, String confirm) =>
    confirm.isEmpty || source == confirm ? null : InputProblem.mismatch;
