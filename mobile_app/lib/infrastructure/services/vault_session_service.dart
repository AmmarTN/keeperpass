import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';

/// The unlocked vault: the decrypted snapshot and the secret, in memory only
/// (plan 5.3). Nothing here is ever written to the phone; locking, signing
/// out and the auto-lock wipe it.
@lazySingleton
class VaultSessionService {
  VaultSnapshot? _snapshot;
  String? _secret;
  DateTime? _loadedAt;
  final StreamController<VaultSnapshot?> _changes =
      StreamController<VaultSnapshot?>.broadcast(sync: true);

  bool get isOpen => _snapshot != null && _secret != null;

  VaultSnapshot? get snapshot => _snapshot;

  /// The secret the vault was opened (or last re-encrypted) with; saves use
  /// it without asking again (web `SessionStore.secret`).
  String? get secret => _secret;

  /// When this phone last read or wrote the stored file — "On this phone,
  /// loaded 9:12 AM" in a Dropbox conflict (board `Sync-states`).
  DateTime? get loadedAt => _loadedAt;

  /// Whether a save is uploading right now; moving the vault waits for it
  /// (web `settings.migrate.error.busy`).
  bool saving = false;

  /// How many times the stored file was read again ("Load the latest"): an
  /// open Edit then starts over from the latest item.
  int get reloads => _reloads;
  int _reloads = 0;

  /// The snapshot after every change; null once wiped.
  Stream<VaultSnapshot?> get changes => _changes.stream;

  void open(VaultSnapshot snapshot, String secret, DateTime loadedAt) {
    _secret = secret;
    _loadedAt = loadedAt;
    _set(snapshot);
  }

  /// A committed change (never a draft); the caller then saves.
  void update(VaultSnapshot snapshot) {
    if (_secret == null) return;
    _set(snapshot);
  }

  /// The stored file was read again ("Load the latest").
  void reload(VaultSnapshot snapshot, DateTime loadedAt) {
    _loadedAt = loadedAt;
    _reloads++;
    update(snapshot);
  }

  /// The stored file now matches what this phone holds.
  void markWritten(DateTime at) => _loadedAt = at;

  /// Re-encrypted under a new secret: same vault, different key.
  void changeSecret(String secret) {
    if (_secret != null) _secret = secret;
  }

  /// Forgets the decrypted vault and the secret.
  void wipe() {
    _secret = null;
    _loadedAt = null;
    saving = false;
    _set(null);
  }

  void _set(VaultSnapshot? snapshot) {
    _snapshot = snapshot;
    _changes.add(snapshot);
  }
}
