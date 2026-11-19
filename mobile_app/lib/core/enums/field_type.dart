/// The kinds of value a vault item can hold (web `core/models/field.ts`).
///
/// The string values are part of the vault's stored format, written into the
/// encrypted file and read by every later version of both apps: append-only.
/// A new kind gets a new member; an existing one is never renamed.
///
/// [secret] and [multiline] are the web's `FIELD_DEFINITIONS` defaults:
/// whether the value is held behind a reveal toggle, and whether its editor
/// gives it room for more than one line. Labels and icons live with the UI.
enum FieldType {
  username('username', secret: false, multiline: false, icon: 'user'),
  password('password', secret: true, multiline: true, icon: 'lock'),
  email('email', secret: false, multiline: false, icon: 'email'),
  url('url', secret: false, multiline: false, icon: 'web'),
  ipHost('ip_host', secret: false, multiline: false, icon: 'computer'),
  date('date', secret: false, multiline: false, icon: 'date'),
  month('month', secret: false, multiline: false, icon: 'month'),
  credit('credit', secret: true, multiline: false, icon: 'credit'),
  phone('phone', secret: false, multiline: false, icon: 'phone'),
  pin('pin', secret: true, multiline: false, icon: 'lock'),

  /// Not secret in the reveal-toggle sense: the item shows the rolling code,
  /// never the seed.
  totp('totp', secret: false, multiline: false, icon: 'totp'),

  /// Secret by default: a certificate is often paired with a private key.
  certificate(
    'certificate',
    secret: true,
    multiline: true,
    icon: 'audit-clean',
  ),
  sshKey('ssh_key', secret: true, multiline: true, icon: 'lock'),
  recoveryCodes(
    'recovery_codes',
    secret: true,
    multiline: true,
    icon: 'list-check',
  ),
  note('note', secret: false, multiline: true, icon: 'note'),
  text('text', secret: false, multiline: true, icon: 'text');

  const FieldType(
    this.value, {
    required this.secret,
    required this.multiline,
    required this.icon,
  });

  /// The stored string.
  final String value;
  final bool secret;
  final bool multiline;

  /// The web's icon name for this type (`FIELD_DEFINITIONS`), drawn through
  /// `FaGlyphs.byName`.
  final String icon;

  /// The type for a stored string; null when this version does not know it
  /// (a vault written by a newer app).
  static FieldType? tryParse(String value) {
    for (final FieldType type in values) {
      if (type.value == value) return type;
    }
    return null;
  }
}
