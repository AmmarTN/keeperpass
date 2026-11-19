part of 'scan_cubit.dart';

/// What the scan screen shows (board `Scan-QR`).
enum ScanStep {
  /// "Add a 2FA code by scanning", before the system asks (`S6-27`).
  primer,

  /// The camera (`S6-28`), and "Code Found" over it (`S6-29`).
  scanning,

  /// "Camera access is off" (`S6-31`).
  cameraOff,
}

/// What the scanner says over the camera, as a toast.
enum ScanNotice {
  /// "This isn't a 2FA QR code".
  notACode,

  /// "This code uses settings KeeperPass doesn't support yet".
  unsupported,

  /// "The setup key isn't valid, so no code can be made."
  invalidKey,

  /// "The camera couldn't start".
  cameraFailed,
}

/// How a scan ended.
sealed class ScanOutcome {
  const ScanOutcome();
}

/// A code saved into [itemId] (new or existing), named [name]: Codes shows
/// "Code added to {name}" (board `S6-32`).
final class CodeAdded extends ScanOutcome {
  const CodeAdded({required this.itemId, required this.name});

  final String itemId;
  final String name;
}

/// A typed key for a new Authenticator item: the new-item screen opens with
/// it filled in, to be named there (your answer, Part 15).
final class NewItemKey extends ScanOutcome {
  const NewItemKey(this.key);

  final String key;
}

/// A key for the 2FA field being edited (from Edit).
final class FieldKey extends ScanOutcome {
  const FieldKey(this.key);

  final String key;
}

@freezed
abstract class ScanState with _$ScanState {
  const ScanState._();

  const factory ScanState({
    @Default(CubitStatus()) CubitStatus status,
    @Default(ScanStep.primer) ScanStep step,

    /// The code read, while "Code Found" is up.
    OtpauthCode? found,

    /// The items named like [found]'s site, A to Z (plan, Part 15 rule 5).
    @Default(<VaultRow>[]) List<VaultRow> matches,

    /// Where "Save code" puts it: one of [matches], or null for a new
    /// Authenticator item.
    String? targetId,

    /// The last thing to say over the camera; [notices] counts them, so the
    /// same one shows again.
    ScanNotice? notice,
    @Default(0) int notices,
  }) = _ScanState;

  bool get saving =>
      status.action == CubitAction.saveCode &&
      status.statusType == CubitStatusType.loading;

  VaultRow? get target =>
      matches.where((VaultRow r) => r.id == targetId).firstOrNull;
}
