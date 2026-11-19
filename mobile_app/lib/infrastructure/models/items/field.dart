import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/infrastructure/models/general/vault_json.dart';

part 'field.freezed.dart';
part 'field.g.dart';

/// One named value inside an item (web `Field`). The name is the user's; the
/// type drives display.
@freezed
abstract class Field with _$Field {
  const Field._();

  @JsonSerializable(includeIfNull: false, createFieldMap: true)
  const factory Field({
    required String name,
    required String value,

    /// The stored type string — kept as written so a type from a newer app
    /// survives a round trip. Read it through [type].
    @JsonKey(name: 'type') required String typeValue,

    /// Overrides the type's default "secret" for this one field; null means
    /// "use the type's default" (web `fieldIsSecret`).
    bool? secret,

    /// A Font Awesome code point picked from the catalogue (hex).
    String? iconGlyph,
    @JsonKey(
      name: kUnknownJsonKey,
      includeFromJson: false,
      includeToJson: false,
    )
    @Default(<String, Object?>{})
    Map<String, Object?> unknown,
  }) = _Field;

  /// A new field of a known [type].
  factory Field.of({
    required String name,
    required FieldType type,
    required String value,
    bool? secret,
    String? iconGlyph,
  }) => Field(
    name: name,
    value: value,
    typeValue: type.value,
    secret: secret,
    iconGlyph: iconGlyph,
  );

  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(
    json,
  ).copyWith(unknown: unknownJsonKeys(json, _$FieldFieldMap.values));

  /// The type, falling back to plain text for one this version does not know
  /// (web `fieldDefinition`): an older app still renders a newer type as the
  /// text it is.
  FieldType get type => FieldType.tryParse(typeValue) ?? FieldType.text;

  /// Whether this version knows [typeValue].
  bool get hasKnownType => FieldType.tryParse(typeValue) != null;

  /// Masked: its own override, or its type's default (web `fieldIsSecret`).
  bool get isSecret => secret ?? type.secret;

  /// The JSON written to the vault, unknown keys included.
  Map<String, dynamic> toVaultJson() => withUnknownKeys(unknown, toJson());
}

/// Every character but line breaks as a dot, so a masked multi-line secret
/// keeps its shape (web `maskValue`).
String maskFieldValue(String value) => value.replaceAll(RegExp(r'[^\n]'), '•');

/// JSON helpers for lists of fields inside other models.
List<Map<String, dynamic>> fieldsToVaultJson(List<Field> fields) =>
    <Map<String, dynamic>>[
      for (final Field field in fields) field.toVaultJson(),
    ];
