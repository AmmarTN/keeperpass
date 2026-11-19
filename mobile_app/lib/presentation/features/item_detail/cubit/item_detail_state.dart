part of 'item_detail_cubit.dart';

@freezed
abstract class ItemDetailState with _$ItemDetailState {
  const ItemDetailState._();

  const factory ItemDetailState({
    @Default(CubitStatus()) CubitStatus status,
    @Default('') String itemId,

    /// The item as its row in the list would draw it (tile, vault, favorite);
    /// null before [ItemDetailCubit.open] and once the item is gone.
    VaultRow? row,

    /// The item vanished (deleted on another device, or by a reload): the
    /// "This item no longer exists." screen (board `S3-28`).
    @Default(false) bool gone,

    /// Fields whose secret is shown, by position (web: per field, masked
    /// again on leaving).
    @Default(<int>{}) Set<int> revealed,

    /// "4 minutes ago" — loaded once from the bundled tables.
    RelativeTimeFormatter? relativeTime,

    /// Country names by language, for the flag before a country (board
    /// `S3-32`).
    @Default(<String, dynamic>{}) Map<String, dynamic> countryNames,
  }) = _ItemDetailState;

  VaultItem? get item => row?.item;
}
