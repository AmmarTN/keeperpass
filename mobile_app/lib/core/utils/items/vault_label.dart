import 'package:keeperpass/infrastructure/models/vault/organization.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';

/// `Organization / Vault`, or just the vault's name for one of your own (web
/// `vaultLabel`).
String vaultLabel(Vault vault, Organization? organization) =>
    organization == null ? vault.name : '${organization.name} / ${vault.name}';

/// [vaultLabel] by id; empty for a vault that no longer exists (web
/// `VaultStore.labelForVault`).
String labelForVault(VaultSnapshot snapshot, String vaultId) {
  for (final Vault vault in snapshot.vaults) {
    if (vault.id != vaultId) continue;
    Organization? organization;
    for (final Organization candidate in snapshot.organizations) {
      if (candidate.id == vault.organizationId) organization = candidate;
    }
    return vaultLabel(vault, organization);
  }
  return '';
}
