import 'package:keeperpass/core/utils/crypto/totp.dart';
import 'package:keeperpass/core/utils/validation/limits.dart';
import 'package:keeperpass/core/utils/validation/text_safety.dart';

/// Reads the `otpauth://` link a site's 2FA QR code holds (plan, Part 15
/// rules — the web has no QR import). Only what the web's `totp.ts` makes is
/// accepted: 6 digits, 30 seconds, HMAC-SHA1.

/// Why a QR code gives no code.
enum OtpauthProblem {
  /// Not an `otpauth://totp/` link at all ("This isn't a 2FA QR code").
  notACode,

  /// A counter code, an export, or other digits, period or algorithm ("This
  /// code uses settings KeeperPass doesn't support yet").
  unsupported,

  /// No setup key, or one that is not base32 ("The setup key isn't valid").
  invalidKey,
}

/// What a scanned QR code holds.
sealed class OtpauthReading {
  const OtpauthReading();
}

/// A 2FA code KeeperPass can make.
final class OtpauthCode extends OtpauthReading {
  const OtpauthCode({required this.secret, this.issuer, this.account});

  /// The setup key, as written in the QR code.
  final String secret;

  /// The site ("Dropbox"), null when the QR code names none.
  final String? issuer;

  /// The account at the site ("jane.doe92@example.com"), null when none.
  final String? account;
}

/// A QR code that gives no code, and why.
final class OtpauthRefused extends OtpauthReading {
  const OtpauthRefused(this.problem);

  final OtpauthProblem problem;
}

final RegExp _link = RegExp(
  r'^([A-Za-z][A-Za-z0-9+.\-]*)://([^/?#]*)(/[^?#]*)?(?:\?([^#]*))?(?:#.*)?$',
);

/// Reads [raw] by the plan's rules.
OtpauthReading readOtpauth(String raw) {
  final RegExpMatch? link = _link.firstMatch(raw.trim());
  if (link == null) return const OtpauthRefused(OtpauthProblem.notACode);

  final String scheme = link.group(1)!.toLowerCase();
  if (scheme == 'otpauth-migration') {
    return const OtpauthRefused(OtpauthProblem.unsupported);
  }
  if (scheme != 'otpauth') {
    return const OtpauthRefused(OtpauthProblem.notACode);
  }
  switch (link.group(2)!.toLowerCase()) {
    case 'totp':
      break;
    case 'hotp':
      return const OtpauthRefused(OtpauthProblem.unsupported);
    default:
      return const OtpauthRefused(OtpauthProblem.notACode);
  }

  final Map<String, String> parameters = _parameters(link.group(4) ?? '');
  final String? digits = parameters['digits'];
  final String? period = parameters['period'];
  final String? algorithm = parameters['algorithm'];
  if ((digits != null && int.tryParse(digits.trim()) != kDefaultTotpDigits) ||
      (period != null &&
          int.tryParse(period.trim()) != kDefaultTotpPeriodSeconds) ||
      (algorithm != null && algorithm.trim().toUpperCase() != 'SHA1')) {
    return const OtpauthRefused(OtpauthProblem.unsupported);
  }

  final String secret = (parameters['secret'] ?? '').trim();
  if (!_validKey(secret)) {
    return const OtpauthRefused(OtpauthProblem.invalidKey);
  }

  // "Site:account", or the account alone.
  final String label = _decode((link.group(3) ?? '').replaceFirst('/', ''));
  final int colon = label.indexOf(':');
  final String? labelIssuer = colon < 0 ? null : label.substring(0, colon);
  final String labelAccount = colon < 0 ? label : label.substring(colon + 1);

  return OtpauthCode(
    secret: secret,
    issuer:
        _name(parameters['issuer'], InputLimits.itemName) ??
        _name(labelIssuer, InputLimits.itemName),
    account: _name(labelAccount, InputLimits.fieldValue),
  );
}

/// The query's parameters, names in lower case, values decoded ("+" is a
/// space); the first of a repeated name wins, an empty value is no value.
Map<String, String> _parameters(String query) {
  final Map<String, String> parameters = <String, String>{};
  for (final String pair in query.split('&')) {
    final int equals = pair.indexOf('=');
    if (equals <= 0) continue;
    final String name = _decode(pair.substring(0, equals)).toLowerCase();
    final String value = _decodeQuery(pair.substring(equals + 1));
    if (value.isEmpty) continue;
    parameters.putIfAbsent(name, () => value);
  }
  return parameters;
}

String _decode(String value) {
  try {
    return Uri.decodeComponent(value);
  } on Object {
    return value;
  }
}

String _decodeQuery(String value) {
  try {
    return Uri.decodeQueryComponent(value);
  } on Object {
    return value;
  }
}

/// A key the web can make a code from: base32 after spaces and padding,
/// and not longer than a field may be.
bool _validKey(String secret) {
  if (secret.isEmpty || secret.length > InputLimits.fieldValue) return false;
  if (secret.replaceAll(RegExp(r'[\s=]'), '').isEmpty) return false;
  try {
    base32ToBytes(secret);
    return true;
  } on InvalidTotpSecretException {
    return false;
  }
}

/// A site or account name as a typed one would be: one line, no unsafe
/// characters, trimmed and within [limit] (UTF-16 units, never splitting a
/// character); null when nothing is left.
String? _name(String? value, int limit) {
  if (value == null) return null;
  String name = stripUnsafeCharacters(
    value.replaceAll(RegExp(r'\s+'), ' '),
  ).trim();
  if (name.length > limit) {
    int end = limit;
    final int last = name.codeUnitAt(end - 1);
    if (last >= 0xD800 && last <= 0xDBFF) end--;
    name = name.substring(0, end).trim();
  }
  return name.isEmpty ? null : name;
}
