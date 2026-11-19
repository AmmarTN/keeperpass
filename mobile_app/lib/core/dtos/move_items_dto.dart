import 'package:freezed_annotation/freezed_annotation.dart';

part 'move_items_dto.freezed.dart';

/// Moving items to another vault (web `VaultStore.moveItems`).
@freezed
abstract class MoveItemsDto with _$MoveItemsDto {
  const factory MoveItemsDto({
    required List<String> itemIds,
    required String vaultId,
  }) = _MoveItemsDto;
}
