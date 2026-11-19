import 'package:flutter/material.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';

/// How one character of a secret is drawn.
enum SecretCharKind { letter, digit, symbol }

/// The web's rule (generator-panel.ts `kindOf`): 0–9 are digits, any Unicode
/// letter is a letter, everything else — separators, punctuation, spaces — is
/// a symbol.
SecretCharKind secretCharKind(String char) {
  if (RegExp('[0-9]').hasMatch(char)) return SecretCharKind.digit;
  if (RegExp(r'\p{L}', unicode: true).hasMatch(char)) {
    return SecretCharKind.letter;
  }
  return SecretCharKind.symbol;
}

/// Splits [secret] into runs of one kind, each drawn in its colour: digits in
/// accent-strong (`.dig`), symbols muted (`.sym`), letters as they are, so a
/// long value can be read back character by character.
List<TextSpan> secretSpans(String secret, AppColors colors) {
  final List<TextSpan> spans = <TextSpan>[];
  final StringBuffer run = StringBuffer();
  SecretCharKind? runKind;

  void flush() {
    if (run.isEmpty) return;
    spans.add(
      TextSpan(
        text: run.toString(),
        style: switch (runKind!) {
          SecretCharKind.digit => TextStyle(color: colors.accentStrong),
          SecretCharKind.symbol => TextStyle(color: colors.mutedForeground),
          SecretCharKind.letter => null,
        },
      ),
    );
    run.clear();
  }

  for (final String char in secret.characters) {
    final SecretCharKind kind = secretCharKind(char);
    if (kind != runKind) flush();
    runKind = kind;
    run.write(char);
  }
  flush();
  return spans;
}

/// A revealed secret in Space Mono with tinted digits and symbols.
class SecretText extends StatelessWidget {
  const SecretText(
    this.secret, {
    required this.style,
    this.maxLines,
    this.textAlign,
    super.key,
  });

  final String secret;

  /// A Space Mono style (`AppTextStyles.secret()`, `generated()` …).
  final TextStyle style;
  final int? maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(style: style, children: secretSpans(secret, context.colors)),
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}

/// A text controller that draws its revealed value like [SecretText] while
/// it is being edited.
class SecretTextEditingController extends TextEditingController {
  SecretTextEditingController({
    super.text,
    this._masked = false,
    this._tinted = true,
  });

  bool _masked;
  bool _tinted;

  /// Digits and symbols tinted when shown; off for a field that is not
  /// secret (it is drawn as plain text).
  bool get tinted => _tinted;
  set tinted(bool value) {
    if (value == _tinted) return;
    _tinted = value;
    notifyListeners();
  }

  /// Drawn as dots (line breaks kept), for a multi-line secret, which a
  /// text field cannot obscure (web: `-webkit-text-security`). Only the
  /// drawing changes; the text is the real value.
  bool get masked => _masked;
  set masked(bool value) {
    if (value == _masked) return;
    _masked = value;
    notifyListeners();
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    if (_masked) {
      // One dot per code unit, so the caret stays where the text is.
      return TextSpan(
        style: style,
        text: text.replaceAll(RegExp(r'[^\n]'), '•'),
      );
    }
    if (!_tinted || (withComposing && value.isComposingRangeValid)) {
      return super.buildTextSpan(
        context: context,
        style: style,
        withComposing: withComposing,
      );
    }
    return TextSpan(style: style, children: secretSpans(text, context.colors));
  }
}
