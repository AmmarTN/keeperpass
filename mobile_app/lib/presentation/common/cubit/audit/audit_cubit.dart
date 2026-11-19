import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/run_audit_dto.dart';
import 'package:keeperpass/core/enums/audit_type.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/audit/run_audit.dart';
import 'package:keeperpass/infrastructure/models/audit/audit_result.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';

part 'audit_cubit.freezed.dart';
part 'audit_state.dart';

/// The security audit's findings for this session (web `AuditService`):
/// derived from the passwords already in the vault, so kept in memory and
/// never saved. A full run follows every unlock; locking drops them. A run
/// that fails (the breach lookup needs a connection) keeps the last ones —
/// all or nothing, as the web (your answer, Part 11); the report shows the
/// run's progress and when it last went through.
@lazySingleton
final class AuditCubit extends Cubit<AuditState> {
  AuditCubit(
    this._runAudit,
    this._session,
    this._vault, {
    @ignoreParam this._now = DateTime.now,
  }) : super(const AuditState());

  final RunAudit _runAudit;
  final SessionCubit _session;
  final VaultSessionService _vault;
  final DateTime Function() _now;

  StreamSubscription<bool>? _sessionSubscription;
  StreamSubscription<VaultSnapshot?>? _vaultSubscription;

  /// Bumped on every lock: a run that started before it never lands after.
  int _epoch = 0;

  /// The latest run started; only its lookups move the progress.
  int _latest = 0;

  void start() {
    _sessionSubscription ??= _session.stream
        .map((SessionState session) => session.isReady)
        .distinct()
        .listen((bool ready) {
          if (ready) {
            runFullAudit();
          } else {
            clear();
          }
        });
    // The badge counts against the vault: a deleted item's findings stop
    // counting at once (web `flaggedCount`).
    _vaultSubscription ??= _vault.changes.listen(
      (_) => emit(state.copyWith(flaggedCount: _count(state.findings))),
    );
  }

  /// Re-audits every item; true when it went through.
  Future<bool> runFullAudit() => _run(null);

  /// Re-audits one item after it was created, edited or restored (Parts 8
  /// and 9); every password is still scanned for reuse.
  Future<bool> runAuditForItem(String itemId) => _run(itemId);

  void clear() {
    _epoch++;
    emit(const AuditState());
  }

  Future<bool> _run(String? onlyItemId) async {
    final int epoch = _epoch;
    final int run = ++_latest;
    final DateTime startedAt = _now();
    emit(
      state.copyWith(
        running: state.running + 1,
        lookedUp: 0,
        toLookUp: 0,
        timeLeft: null,
        failure: null,
      ),
    );

    final Either<Failure, Map<String, List<AuditResult>>> result =
        await _runAudit(
          RunAuditDto(
            onlyItemId: onlyItemId,
            onProgress: (int done, int total) {
              if (isClosed || epoch != _epoch || run != _latest) return;
              emit(
                state.copyWith(
                  lookedUp: done,
                  toLookUp: total,
                  timeLeft: _timeLeft(startedAt, done, total),
                ),
              );
            },
          ),
        );
    if (isClosed || epoch != _epoch || !_session.state.isReady) return false;

    final AuditState ended = state.copyWith(running: state.running - 1);
    return result.fold(
      (Failure failure) {
        emit(ended.copyWith(failure: failure));
        return false;
      },
      (Map<String, List<AuditResult>> results) {
        final Map<String, List<AuditResult>> findings = onlyItemId == null
            ? results
            : <String, List<AuditResult>>{...state.findings, ...results};
        emit(
          ended.copyWith(
            findings: findings,
            flaggedCount: _count(findings),
            checkedAt: _now(),
          ),
        );
        return true;
      },
    );
  }

  /// The rest at the pace so far; unknown until a batch has answered.
  Duration? _timeLeft(DateTime startedAt, int done, int total) {
    if (done == 0 || done >= total) return null;
    final int elapsed = _now().difference(startedAt).inMilliseconds;
    return Duration(milliseconds: elapsed * (total - done) ~/ done);
  }

  int _count(Map<String, List<AuditResult>> findings) =>
      (_vault.snapshot?.items ?? const <VaultItem>[])
          .where((VaultItem item) => findings[item.id]?.isNotEmpty ?? false)
          .length;

  @override
  Future<void> close() async {
    await _sessionSubscription?.cancel();
    await _vaultSubscription?.cancel();
    return super.close();
  }
}
