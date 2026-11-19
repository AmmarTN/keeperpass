/// How long a request may take before it fails (release audit, 2026-11-04).
/// The web relies on the browser's own limits; without these, a stalled
/// transfer would leave "Saving…" or Unlock waiting forever. A timeout ends
/// as any network failure: "Your vault was not saved" with Retry.
abstract final class NetworkTimeouts {
  /// Opening the connection.
  static const Duration connect = Duration(seconds: 15);

  /// Sending one request's body: Dio counts the whole body, so this fits a
  /// Drive chunk (256 KiB) or a small request.
  static const Duration send = Duration(seconds: 30);

  /// The answer once the request is sent, and any pause while it downloads.
  static const Duration receive = Duration(seconds: 30);

  /// Dropbox takes the whole vault in one request: [send] plus one second
  /// per 8 KB, so a large vault on a slow connection still fits while a
  /// stalled one ends.
  static Duration sendFor(int bytes) =>
      send + Duration(milliseconds: bytes ~/ 8);
}
