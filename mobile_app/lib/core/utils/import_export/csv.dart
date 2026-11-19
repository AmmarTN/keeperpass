import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/utils/text/fold.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';

/// CSV import and export (web `core/import-export/csv.ts`), in the same
/// formats: a `name, tags, …fields` table, CRLF rows, RFC 4180 quoting.

final RegExp _needsQuoting = RegExp('["\n\r,]');

String _encodeField(String value) =>
    _needsQuoting.hasMatch(value) ? '"${value.replaceAll('"', '""')}"' : value;

/// Rows → CSV text, CRLF between rows.
String encodeCsv(List<List<String>> rows) => rows
    .map((List<String> row) => row.map(_encodeField).join(','))
    .join('\r\n');

/// CSV text → rows. A leading byte-order mark is dropped; quotes, doubled
/// quotes, CRLF and LF are handled; a lone CR is ignored.
List<List<String>> parseCsv(String text) {
  final String source = text.startsWith('\uFEFF') ? text.substring(1) : text;
  final List<List<String>> rows = <List<String>>[];
  List<String> row = <String>[];
  final StringBuffer field = StringBuffer();
  bool inQuotes = false;

  for (int index = 0; index < source.length; index++) {
    final String char = source[index];
    if (inQuotes) {
      if (char != '"') {
        field.write(char);
      } else if (index + 1 < source.length && source[index + 1] == '"') {
        field.write('"');
        index++;
      } else {
        inQuotes = false;
      }
      continue;
    }
    switch (char) {
      case '"':
        inQuotes = true;
      case ',':
        row.add(field.toString());
        field.clear();
      case '\n':
        row.add(field.toString());
        rows.add(row);
        row = <String>[];
        field.clear();
      case '\r':
        break;
      default:
        field.write(char);
    }
  }

  if (field.isNotEmpty || row.isNotEmpty) {
    row.add(field.toString());
    rows.add(row);
  }
  return rows;
}

/// Items → CSV: `name`, `tags` (comma-joined), then one column per distinct
/// field name in first-seen order. A repeated name in one item keeps the last
/// value, as on the web.
String itemsToCsv(List<VaultItem> items) {
  final List<String> fieldNames = <String>[];
  for (final VaultItem item in items) {
    for (final Field field in item.fields) {
      if (!fieldNames.contains(field.name)) fieldNames.add(field.name);
    }
  }
  final List<List<String>> rows = <List<String>>[
    <String>['name', 'tags', ...fieldNames],
    for (final VaultItem item in items)
      () {
        final List<String> row = <String>[
          item.name,
          item.tags.join(','),
          ...List<String>.filled(fieldNames.length, ''),
        ];
        for (final Field field in item.fields) {
          row[2 + fieldNames.indexOf(field.name)] = field.value;
        }
        return row;
      }(),
  ];
  return encodeCsv(rows);
}

/// An item read from CSV, before it gets an id and a vault.
typedef ItemDraft = ({String name, List<String> tags, List<Field> fields});

/// Column headings each field type is recognised by (web `COLUMN_HEADINGS`).
const Map<FieldType, List<String>> _columnHeadings = <FieldType, List<String>>{
  FieldType.username: <String>[
    'username',
    'user name',
    'user',
    'login',
    'login username',
  ],
  FieldType.password: <String>['password', 'login password', 'pass'],
  FieldType.email: <String>['email', 'email address', 'e-mail'],
  FieldType.url: <String>['url', 'website', 'web site', 'login uri'],
  FieldType.ipHost: <String>[
    'ip',
    'ip address',
    'host',
    'hostname',
    'ip / host',
    'server',
  ],
  FieldType.date: <String>['date'],
  FieldType.month: <String>['month'],
  FieldType.credit: <String>['card number', 'credit card number'],
  FieldType.phone: <String>['phone', 'phone number', 'telephone', 'mobile'],
  FieldType.pin: <String>['pin', 'cvc', 'cvv'],
  FieldType.totp: <String>[
    'authenticator code',
    'one-time password',
    'totp',
    'otp',
  ],
  FieldType.certificate: <String>['certificate', 'cert'],
  FieldType.sshKey: <String>[
    'ssh key',
    'ssh / private key',
    'private key',
    'ssh private key',
  ],
  FieldType.recoveryCodes: <String>[
    'recovery codes',
    'backup codes',
    'recovery code',
  ],
  FieldType.note: <String>[
    'formatted note',
    'richtext / markdown',
    'note',
    'notes',
  ],
  FieldType.text: <String>['text', 'plain text'],
};

final Map<String, FieldType> _typesByHeading = <String, FieldType>{
  for (final MapEntry<FieldType, List<String>> entry in _columnHeadings.entries)
    for (final String heading in entry.value) heading: entry.key,
};

/// The field type a CSV column heading names; plain text when unknown.
FieldType inferFieldType(String columnName) =>
    _typesByHeading[jsTrim(columnName).toLowerCase()] ?? FieldType.text;

/// Rows → item drafts: the first row is the header; blank rows are skipped;
/// empty cells make no field.
List<ItemDraft> csvToItemDrafts(List<List<String>> rows) {
  if (rows.isEmpty) return <ItemDraft>[];
  final List<String> header = rows.first;
  final List<({String name, FieldType type, int index})> columns =
      <({String name, FieldType type, int index})>[
        for (int i = 2; i < header.length; i++)
          (name: header[i], type: inferFieldType(header[i]), index: i),
      ];
  String cell(List<String> row, int index) =>
      index < row.length ? row[index] : '';

  return <ItemDraft>[
    for (final List<String> row in rows.skip(1))
      if (row.any((String c) => jsTrim(c).isNotEmpty))
        (
          name: cell(row, 0),
          tags: cell(
            row,
            1,
          ).split(',').map(jsTrim).where((String t) => t.isNotEmpty).toList(),
          fields: <Field>[
            for (final ({String name, FieldType type, int index}) column
                in columns)
              if (cell(row, column.index).isNotEmpty)
                Field.of(
                  name: column.name,
                  type: column.type,
                  value: cell(row, column.index),
                ),
          ],
        ),
  ];
}
