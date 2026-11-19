import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/utils/validation/limits.dart';
import 'package:keeperpass/core/utils/validation/validators.dart';

/// Types edited in a multi-line box, with the generous length cap and line
/// breaks allowed (web `LONG_TEXT_TYPES` / `MULTILINE_TYPES`).
const Set<FieldType> kLongTextTypes = <FieldType>{
  FieldType.note,
  FieldType.certificate,
  FieldType.sshKey,
  FieldType.recoveryCodes,
};

/// How long a value of [type] may be (web `fieldValueValidators`).
int fieldValueLimit(FieldType type) => kLongTextTypes.contains(type)
    ? InputLimits.noteValue
    : InputLimits.fieldValue;

/// Whether a value can be saved (web `fieldValueValidators`): passwords,
/// PINs and card numbers only have a length cap; the long-text types must
/// also render as stored; everything else must be one safe line.
bool fieldValueValid(FieldType type, String value) {
  if (checkMaxLength(value, fieldValueLimit(type)) != null) return false;
  return switch (type) {
    FieldType.password || FieldType.pin || FieldType.credit => true,
    _ when kLongTextTypes.contains(type) => checkDisplaySafe(value).isEmpty,
    _ => checkSingleLine(value).isEmpty,
  };
}

/// A field's name: at most 200 characters, one safe line (web
/// `editableFieldFrom`).
bool fieldNameValid(String name) =>
    checkMaxLength(name, InputLimits.fieldName) == null &&
    checkSingleLine(name).isEmpty;

/// An item's name: required, at most 500 characters, one safe line (web
/// `nameControl`).
bool itemNameValid(String name) =>
    name.isNotEmpty &&
    checkMaxLength(name, InputLimits.itemName) == null &&
    checkSingleLine(name).isEmpty;

/// A new tag's name: at most 100 characters, one safe line (web
/// `tagDraftControl`).
bool tagNameValid(String name) =>
    checkMaxLength(name, InputLimits.tagName) == null &&
    checkSingleLine(name).isEmpty;
