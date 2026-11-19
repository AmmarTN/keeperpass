import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_entry_dto.freezed.dart';

/// One earlier version of an item: its position in the item's history,
/// newest first (web `restoreHistoryEntry` / `deleteHistoryEntry`).
@freezed
abstract class HistoryEntryDto with _$HistoryEntryDto {
  const factory HistoryEntryDto({required String itemId, required int index}) =
      _HistoryEntryDto;
}
