import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/utils/text/country_codes.dart';
import 'package:keeperpass/core/utils/text/date_formats.dart';
import 'package:keeperpass/core/utils/text/field_dates.dart';
import 'package:keeperpass/core/utils/text/fold.dart';
import 'package:keeperpass/core/utils/validation/card_number.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';

/// A field's value as the item screen shows it (web `formatFieldValue`):
/// hidden secrets as dots with their line breaks kept; dates as
/// "Apr 12, 1992" and months as "08/2029"; card numbers and valid IBANs in
/// groups (boards `S3-29`, `S3-30`). Anything else as typed.
String fieldDisplayValue(
  Field field, {
  required bool hidden,
  required String locale,
}) {
  final String value = field.value;
  if (field.type == FieldType.credit) {
    final String? grouped = groupedCardNumber(value);
    if (grouped != null) return hidden ? _maskGroups(grouped) : grouped;
  }
  if (field.isSecret && hidden) return maskFieldValue(value);
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
    // Date formats not loaded yet: the stored value.
  }
  return ibanGroups(value) ?? value;
}

/// Set in Space Mono: secrets (web), months (board `S3-29`'s expiry) and
/// IBANs (board `S3-30`).
bool fieldIsMonospace(Field field) =>
    field.isSecret ||
    field.type == FieldType.month ||
    ibanGroups(field.value) != null;

/// What a field's copy button copies (web `ItemField.copy`): the value, an
/// IBAN without its spaces ("the grouping is only for the eye", board
/// `U3-Item-types`). A 2FA field copies its current code instead.
String fieldCopyValue(Field field) =>
    isValidIban(field.value) ? _compact(field.value) : field.value;

/// A card number in its brand's groups ("4111 1111 1111 1111"), or null when
/// the value is not made of digits, spaces and dashes.
String? groupedCardNumber(String value) {
  final String trimmed = value.trim();
  if (trimmed.isEmpty || !RegExp(r'^[\d\s-]+$').hasMatch(trimmed)) return null;
  return inspectCardNumber(trimmed).formatted;
}

String _maskGroups(String grouped) => grouped.replaceAll(RegExp(r'\S'), '•');

String _compact(String value) => value.replaceAll(RegExp(r'\s'), '');

/// Whether [value] is an IBAN whose check digits add up (ISO 13616: the
/// first four characters moved to the end, letters as 10–35, mod 97 = 1).
bool isValidIban(String value) {
  final String iban = _compact(value).toUpperCase();
  if (!RegExp(r'^[A-Z]{2}\d{2}[A-Z0-9]{11,30}$').hasMatch(iban)) return false;
  final String rearranged = iban.substring(4) + iban.substring(0, 4);
  int remainder = 0;
  for (final int unit in rearranged.codeUnits) {
    final int digit = unit >= 65 ? unit - 55 : unit - 48;
    remainder = (remainder * (digit >= 10 ? 100 : 10) + digit) % 97;
  }
  return remainder == 1;
}

/// A valid IBAN in groups of four ("DE89 3704 0044 0532 0130 00"); null for
/// anything else (your answer, Part 8: recognised by its value).
String? ibanGroups(String value) {
  if (!isValidIban(value)) return null;
  return _compact(
    value,
  ).replaceAllMapped(RegExp('(.{4})'), (Match m) => '${m[1]} ').trim();
}

/// The country a text value names exactly (accents and case aside), in the
/// app language — for the flag before "United States" (board `S3-32`).
Country? countryNamed(
  String value,
  String locale,
  Map<String, dynamic> countryNames,
) {
  final String wanted = foldText(value.trim());
  if (wanted.isEmpty) return null;
  for (final Country country in kCountries) {
    if (foldText(countryName(country, locale, countryNames)) == wanted) {
      return country;
    }
  }
  return null;
}

/// "Show in large type" is offered under a revealed one-line secret (your
/// answer, Part 8).
bool canShowLargeType(Field field) =>
    field.isSecret && field.value.isNotEmpty && !field.value.contains('\n');

/// Recovery codes, one per non-blank line (board `S3-34`: each copies on its
/// own).
List<String> recoveryCodeLines(String value) => <String>[
  for (final String line in value.split('\n'))
    if (line.trim().isNotEmpty) line.trim(),
];

/// The address to open for a website: as typed, https when it has no scheme.
Uri? websiteUri(String address) {
  final String trimmed = address.trim();
  if (trimmed.isEmpty) return null;
  return Uri.tryParse(
    RegExp(r'^[a-zA-Z][a-zA-Z0-9+.-]*://').hasMatch(trimmed)
        ? trimmed
        : 'https://$trimmed',
  );
}

/// "github.com" for "Open github.com".
String websiteHost(String address) =>
    websiteUri(address)?.host.nullIfEmpty ?? address.trim();

/// A phone number to call or message ("tel:", "sms:"): its digits and a
/// leading +.
Uri? phoneUri(String scheme, String number) {
  final String digits = number.replaceAll(RegExp(r'[^\d+]'), '');
  if (digits.replaceAll('+', '').isEmpty) return null;
  return Uri(scheme: scheme, path: digits);
}

extension on String {
  String? get nullIfEmpty => isEmpty ? null : this;
}
