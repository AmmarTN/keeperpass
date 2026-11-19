import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/utils/text/date_formats.dart';
import 'package:keeperpass/core/utils/text/field_dates.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';

/// What a row's copy button copies.
enum MainSecretKind { password, code, cardNumber }

/// The field a row's copy button copies (board `C2-Rows-lists`: "the item's
/// main secret").
class MainSecret {
  const MainSecret(this.field, this.kind);

  final Field field;
  final MainSecretKind kind;
}

/// Your rule (Part 7): the first Password; else the first 2FA code; else the
/// first card number; none of these → no copy button. Empty fields are
/// skipped (the web copies nothing from them).
MainSecret? mainSecretOf(VaultItem item) {
  for (final (FieldType type, MainSecretKind kind)
      in const <(FieldType, MainSecretKind)>[
        (FieldType.password, MainSecretKind.password),
        (FieldType.totp, MainSecretKind.code),
        (FieldType.credit, MainSecretKind.cardNumber),
      ]) {
    for (final Field field in item.fields) {
      if (field.type == type && field.value.isNotEmpty) {
        return MainSecret(field, kind);
      }
    }
  }
  return null;
}

/// The second copy on a left swipe: the first Username, else the first
/// Email (your rule, Part 7).
Field? usernameFieldOf(VaultItem item) {
  for (final FieldType type in const <FieldType>[
    FieldType.username,
    FieldType.email,
  ]) {
    for (final Field field in item.fields) {
      if (field.type == type && field.value.isNotEmpty) return field;
    }
  }
  return null;
}

/// The grey line's first part (your rule, Part 7): the first filled field
/// that isn't hidden — never a secret and never a 2FA setup key — on one
/// line. Null when there is none (the line then shows the vault only).
String? summaryOf(VaultItem item, {required String locale}) {
  for (final Field field in item.fields) {
    if (field.isSecret || field.type == FieldType.totp) continue;
    final String text = fieldSummaryText(field, locale: locale);
    if (text.isNotEmpty) return text;
  }
  return null;
}

/// A field's value as one line of text: dates as "Apr 12, 1992" (your
/// answer, Part 8), months as the web shows them, anything multi-line by its
/// first non-blank line.
String fieldSummaryText(Field field, {required String locale}) {
  final String value = field.value.trim();
  try {
    switch (field.type) {
      case FieldType.date:
        final DateTime? date = parseFieldDate(value);
        if (date != null) return formatMediumDate(date, locale);
      case FieldType.month:
        final ({int year, int month})? month = parseFieldMonth(value);
        if (month != null) {
          return formatFieldMonth(month.year, month.month, locale);
        }
      default:
        break;
    }
  } on Exception {
    // The phone's date formats load with the app's localizations; until
    // then the stored value is shown.
  }
  return value
      .split('\n')
      .map((String line) => line.trim())
      .firstWhere((String line) => line.isNotEmpty, orElse: () => '');
}
