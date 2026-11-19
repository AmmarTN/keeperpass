part of 'codes_cubit.dart';

/// One Codes card: the item as its list row would draw it (tile, name,
/// grey line) and the 2FA field its code comes from.
class CodeEntry {
  const CodeEntry({required this.row, required this.field});

  final VaultRow row;
  final Field field;

  String get itemId => row.id;
}

@freezed
abstract class CodesState with _$CodesState {
  const CodesState._();

  const factory CodesState({
    @Default(CubitStatus()) CubitStatus status,

    /// Every item with a setup key, A to Z (board `Codes` 01).
    @Default(<CodeEntry>[]) List<CodeEntry> entries,

    /// What is typed in the search field.
    @Default('') String search,
  }) = _CodesState;

  /// The cards on screen: the items whose name has every search word.
  List<CodeEntry> get shown => search.trim().isEmpty
      ? entries
      : entries
            .where((CodeEntry e) => nameMatchesSearch(rowName(e.row), search))
            .toList();

  bool get searching => search.trim().isNotEmpty;
}
