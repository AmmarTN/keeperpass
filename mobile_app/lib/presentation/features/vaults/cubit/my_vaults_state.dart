part of 'my_vaults_cubit.dart';

/// One of your vaults, with the items it holds.
class VaultEntry {
  const VaultEntry(this.vault, this.items);

  final Vault vault;
  final int items;

  bool get isDefault => vault.id == kPersonalVaultId;
}

@freezed
abstract class MyVaultsState with _$MyVaultsState {
  const MyVaultsState._();

  const factory MyVaultsState({
    /// Your own vaults (web `ownVaults`), the default one first.
    @Default(<VaultEntry>[]) List<VaultEntry> vaults,

    /// Every vault, shared ones too: a new vault's name must be new among
    /// them (web `CreateVaultDialog`).
    @Default(<Vault>[]) List<Vault> allVaults,
    @Default(false) bool selecting,
    @Default(<String>{}) Set<String> selected,
  }) = _MyVaultsState;

  VaultEntry? get personal =>
      vaults.where((VaultEntry e) => e.isDefault).firstOrNull;

  /// The vaults that can be renamed, deleted and selected.
  List<VaultEntry> get others =>
      vaults.where((VaultEntry e) => !e.isDefault).toList();

  /// Items the selected vaults hold between them.
  int get selectedItems => vaults
      .where((VaultEntry e) => selected.contains(e.vault.id))
      .fold(0, (int total, VaultEntry e) => total + e.items);
}
