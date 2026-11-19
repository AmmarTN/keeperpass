import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';

part 'item_edit_dto.freezed.dart';

/// What Save writes (web `ItemView.save`): a new item ([vaultId] and [icon]
/// set) or the changes to an existing one.
@freezed
abstract class ItemEditDto with _$ItemEditDto {
  const factory ItemEditDto({
    required String itemId,
    required String name,
    required List<Field> fields,
    required List<String> tags,
    String? iconGlyph,

    /// New items only: where it goes, and its template's icon name.
    String? vaultId,
    String? icon,
  }) = _ItemEditDto;
}
