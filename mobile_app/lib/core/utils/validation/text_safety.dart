// Characters that change what text looks like without being visible (web
// `core/validation/text-safety.ts`): controls, bidi overrides, invisibles.

final RegExp _control = RegExp(
  '[\u0000-\u0008\u000b-\u000c\u000e-\u001f\u007f-\u009f]',
);
final RegExp _bidi = RegExp('[\u200E-\u200F\u202A-\u202E\u2066-\u2069]');
final RegExp _invisible = RegExp('[\u200B-\u200D\u2060\uFEFF]');
final RegExp _unsafe = RegExp(
  '${_control.pattern}|${_bidi.pattern}|${_invisible.pattern}',
);

bool hasControlCharacters(String value) => _control.hasMatch(value);

bool hasBidiControl(String value) => _bidi.hasMatch(value);

bool hasInvisibleCharacters(String value) => _invisible.hasMatch(value);

bool hasLineBreak(String value) => RegExp('[\r\n]').hasMatch(value);

bool isDisplaySafe(String value) => !_unsafe.hasMatch(value);

String stripUnsafeCharacters(String value) => value.replaceAll(_unsafe, '');
