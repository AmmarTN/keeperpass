import 'package:keeperpass/core/utils/text/fold.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';

/// Renames a vault (web `renameVault`); a blank name or an unknown vault
/// changes nothing.
VaultSnapshot renameVault(VaultSnapshot snapshot, String vaultId, String name) {
  final String trimmed = jsTrim(name);
  if (trimmed.isEmpty) return snapshot;
  return snapshot.copyWith(
    vaults: <Vault>[
      for (final Vault vault in snapshot.vaults)
        vault.id == vaultId ? vault.copyWith(name: trimmed) : vault,
    ],
  );
}

/// Deletes a vault and moves its items, with their history and tags, to
/// the personal vault (web `deleteVault`). The personal vault and unknown
/// vaults are refused: null.
VaultSnapshot? deleteVault(VaultSnapshot snapshot, String vaultId) {
  if (vaultId == kPersonalVaultId) return null;
  if (!snapshot.vaults.any((Vault vault) => vault.id == vaultId)) return null;
  return snapshot.copyWith(
    vaults: <Vault>[
      for (final Vault vault in snapshot.vaults)
        if (vault.id != vaultId) vault,
    ],
    items: <VaultItem>[
      for (final VaultItem item in snapshot.items)
        item.vaultId == vaultId
            ? item.copyWith(vaultId: kPersonalVaultId)
            : item,
    ],
  );
}

/// The vaults you own (web `ownVaults`): not shared through an
/// organization, in creation order.
List<Vault> ownVaults(VaultSnapshot snapshot) => <Vault>[
  for (final Vault vault in snapshot.vaults)
    if (vault.organizationId == null) vault,
];
