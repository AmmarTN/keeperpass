import 'package:keeperpass/infrastructure/models/general/vault_json.dart';

/// The vault's file names in Google Drive and Dropbox.
abstract final class VaultFileNames {
  /// The one active vault (web `FILE_NAME`).
  static const String vault = 'vault.json.enc';

  /// A vault kept aside by "Start a new vault":
  /// `vault.backup-2026-10-29T14-32-00.json.enc` (board `U2-New-vault`; the
  /// web uses milliseconds — dated by your decision, 2026-10-31).
  static String backup(DateTime at) => 'vault.backup-${_stamp(at)}.json.enc';

  /// A vault moved aside by "Archive vault and sign out" (web
  /// `detachedFileName`): `vault.removed-2026-10-30T21-05-09.json.enc`.
  static String removed(DateTime at) => 'vault.removed-${_stamp(at)}.json.enc';

  /// UTC, to the second, with `:` (not allowed in some file systems) as `-`.
  static String _stamp(DateTime at) =>
      webDateString(at).substring(0, 19).replaceAll(':', '-');
}
