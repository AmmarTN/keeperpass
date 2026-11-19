part of 'vault_list_cubit.dart';

@freezed
abstract class VaultListState with _$VaultListState {
  const VaultListState._();

  const factory VaultListState({
    @Default(CubitStatus()) CubitStatus status,
    @Default(VaultScope.all) VaultScope scope,

    /// The vault shown when [scope] is [VaultScope.vault].
    String? vaultId,

    /// The tag chip that is on.
    String? tag,

    /// A security filter from the Security tab ("Weak passwords").
    AuditType? report,

    /// The search field replaces the header.
    @Default(false) bool searching,
    @Default('') String search,
    @Default(ItemSort.newestFirst) ItemSort sort,

    /// Selection mode: the tab bar gives way to Move and Delete.
    @Default(false) bool selecting,
    @Default(<String>{}) Set<String> selected,

    /// "Reading your vault from Google Drive…".
    @Default(false) bool refreshing,
    @Default(VaultListView()) VaultListView view,
  }) = _VaultListState;

  /// Selected items that are still in the vault, in list order.
  List<VaultRow> get selectedRows => <VaultRow>[
    for (final VaultRow row in view.rows)
      if (selected.contains(row.id)) row,
  ];

  /// Everything listed is selected (Select All then clears).
  bool get allSelected =>
      view.rows.isNotEmpty && selectedRows.length == view.rows.length;
}
