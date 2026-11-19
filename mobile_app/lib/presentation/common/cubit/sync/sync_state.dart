part of 'sync_cubit.dart';

@freezed
abstract class SyncState with _$SyncState {
  const SyncState._();

  const factory SyncState({
    /// Reconnect and "Load the latest" report here.
    @Default(CubitStatus()) CubitStatus status,
    @Default(SyncPhase.idle) SyncPhase phase,

    /// The current save was started by Retry ("Trying again…").
    @Default(false) bool retrying,

    /// The upload, `0` to `1`; meaningful while [SyncPhase.uploading].
    @Default(0.0) double progress,

    /// Committed changes not saved yet ("1 change not saved").
    @Default(0) int pendingChanges,

    /// Why the last save did not go through.
    Failure? failure,

    /// When the last save went through.
    DateTime? savedAt,

    /// A Dropbox conflict: the stored file, newer than the one this phone
    /// opened ("In Dropbox, saved 9:37 AM · newer").
    VaultFileInfo? newerVersion,

    /// When this phone's version was loaded or last saved ("On this phone,
    /// loaded 9:12 AM").
    DateTime? openedAt,

    /// Bumped each time an edit is refused for a newer version: the app
    /// asks "Your Vault Changed" (board `Sync-states`).
    @Default(0) int conflictPrompts,
  }) = _SyncState;

  bool get isSaving =>
      phase == SyncPhase.encrypting || phase == SyncPhase.uploading;

  /// Editing waits while a newer version has not been loaded (board
  /// `Sync-states`: "Until then you can read and copy, but not edit").
  bool get canEdit => phase != SyncPhase.conflict;
}
