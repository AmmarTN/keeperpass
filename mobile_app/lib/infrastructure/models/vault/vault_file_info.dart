import 'package:freezed_annotation/freezed_annotation.dart';

part 'vault_file_info.freezed.dart';

/// The stored vault file, without its contents: Connect shows "Found in
/// Google Drive · updated 2 days ago", and a Dropbox conflict shows when the
/// newer file was saved (boards `U2-Connect`, `Sync-states`).
@freezed
abstract class VaultFileInfo with _$VaultFileInfo {
  const factory VaultFileInfo({DateTime? modifiedAt}) = _VaultFileInfo;
}

/// A signed-in destination, held only for the length of one move — never
/// put on the session (web `MigrationTarget`).
@freezed
abstract class MigrationTarget with _$MigrationTarget {
  const factory MigrationTarget({
    required String accessToken,
    required String email,

    /// Whether the destination account already holds a vault.
    required bool hasVault,

    /// The account's name, for "Moving to this account" (board `S5-26`).
    @Default('') String name,
  }) = _MigrationTarget;
}
