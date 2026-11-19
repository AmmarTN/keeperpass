part of 'edit_item_cubit.dart';

/// One field while editing (web `EditableField`): its type is fixed once it
/// exists; name, value, the Secret toggle and its icon change.
@freezed
abstract class EditableField with _$EditableField {
  const EditableField._();

  const factory EditableField({
    /// Stable while the screen is open, for the widgets.
    required int key,
    required String typeValue,
    required String name,
    required String value,

    /// The effective flag (`secret ?? type default`).
    required bool secret,
    String? iconGlyph,

    /// The stored field it came from: its keys this version does not know
    /// are written back unchanged (X9).
    Field? original,
  }) = _EditableField;

  factory EditableField.from(int key, Field field) => EditableField(
    key: key,
    typeValue: field.typeValue,
    name: field.name,
    value: field.value,
    secret: field.isSecret,
    iconGlyph: field.iconGlyph,
    original: field,
  );

  FieldType get type => FieldType.tryParse(typeValue) ?? FieldType.text;

  bool get valid => fieldNameValid(name) && fieldValueValid(type, value);

  /// The field as Save writes it (web `save`): the name trimmed, the Secret
  /// flag stored only when it differs from the type's own.
  Field toField() {
    final bool? secretFlag = secret == type.secret ? null : secret;
    final Field? stored = original;
    if (stored != null) {
      return stored.copyWith(
        name: name.trim(),
        value: value,
        secret: secretFlag,
        iconGlyph: iconGlyph,
      );
    }
    return Field(
      name: name.trim(),
      value: value,
      typeValue: typeValue,
      secret: secretFlag,
      iconGlyph: iconGlyph,
    );
  }

  /// Whether anything Save would write differs from [other].
  bool differsFrom(EditableField other) =>
      typeValue != other.typeValue ||
      name != other.name ||
      value != other.value ||
      secret != other.secret ||
      iconGlyph != other.iconGlyph;
}

@freezed
abstract class EditItemState with _$EditItemState {
  const EditItemState._();

  const factory EditItemState({
    @Default(CubitStatus()) CubitStatus status,

    /// A new item from a template: nothing reaches the vault before Save.
    @Default(false) bool isNew,

    /// The item's id; a new item's id is made up front (web draft id).
    @Default('') String itemId,
    @Default('') String vaultId,

    /// A new item's template icon (web `ItemTemplate.icon`).
    String? icon,
    @Default('') String name,
    String? iconGlyph,
    @Default(<EditableField>[]) List<EditableField> fields,
    @Default(<String>[]) List<String> tags,

    /// How it started, to tell whether anything changed.
    @Default('') String startName,
    String? startIconGlyph,
    @Default(<EditableField>[]) List<EditableField> startFields,
    @Default(<String>[]) List<String> startTags,

    /// Every tag the vault knows, for the picker.
    @Default(<String>[]) List<String> knownTags,

    /// The item was deleted elsewhere while this was open.
    @Default(false) bool gone,
    @Default(false) bool saving,
  }) = _EditItemState;

  /// Anything differs from how the screen started (web `dirty`; tags in
  /// any order).
  bool get changed {
    if (name != startName || iconGlyph != startIconGlyph) return true;
    if (tags.length != startTags.length || !tags.every(startTags.contains)) {
      return true;
    }
    if (fields.length != startFields.length) return true;
    for (int i = 0; i < fields.length; i++) {
      if (fields[i].differsFrom(startFields[i])) return true;
    }
    return false;
  }

  /// Save waits for a name and valid fields; an existing item also for a
  /// change (web `canSave`; a new item is always worth saving).
  bool get canSave =>
      !saving &&
      (isNew || changed) &&
      itemNameValid(name) &&
      fields.every((EditableField f) => f.valid);
}
