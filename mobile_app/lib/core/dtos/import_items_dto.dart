import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keeperpass/core/utils/import_export/csv.dart';

part 'import_items_dto.freezed.dart';

/// Settings › Data › Import: the items read from a CSV, and where they go.
@freezed
abstract class ImportItemsDto with _$ImportItemsDto {
  const factory ImportItemsDto({
    required String vaultId,
    required List<ItemDraft> drafts,
  }) = _ImportItemsDto;
}
