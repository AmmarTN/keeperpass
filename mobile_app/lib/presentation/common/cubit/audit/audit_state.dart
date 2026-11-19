part of 'audit_cubit.dart';

@freezed
abstract class AuditState with _$AuditState {
  const AuditState._();

  const factory AuditState({
    /// Findings by item id; empty until the first run of the session.
    @Default(<String, List<AuditResult>>{})
    Map<String, List<AuditResult>> findings,

    /// Items in the vault with at least one finding: the Security badge.
    @Default(0) int flaggedCount,

    /// Runs still going (a full run and an item's can overlap, as the web).
    @Default(0) int running,

    /// The latest run's breach lookups: [lookedUp] of [toLookUp] distinct
    /// passwords, and about how long the rest will take once one batch has
    /// answered (board `S4-15`).
    @Default(0) int lookedUp,
    @Default(0) int toLookUp,
    Duration? timeLeft,

    /// When a run last finished; null until one has this session.
    DateTime? checkedAt,

    /// Why the last run could not finish; cleared when the next one starts.
    /// The findings it would have replaced stay (web `runAndApply`).
    Failure? failure,
  }) = _AuditState;

  bool get checking => running > 0;

  /// Whether this session has findings to show: a run went through.
  bool get hasResults => checkedAt != null;

  List<AuditResult> findingsFor(String itemId) =>
      findings[itemId] ?? const <AuditResult>[];

  bool hasFinding(String itemId, AuditType type) =>
      findingsFor(itemId).any((AuditResult result) => result.type == type);
}
