import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';

part 'prepared_vault.freezed.dart';

/// A new vault already encrypted, waiting to be saved: "Try again" uploads
/// it as it is instead of deriving the key again (boards `U2-Create`,
/// `U2-New-vault`: "keeps the encrypted vault waiting").
@freezed
abstract class PreparedVault with _$PreparedVault {
  const factory PreparedVault({
    required VaultSnapshot snapshot,
    required String secret,

    /// The vault file's contents.
    required String encrypted,
  }) = _PreparedVault;
}
