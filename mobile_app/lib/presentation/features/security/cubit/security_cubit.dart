import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:keeperpass/presentation/common/cubit/audit/audit_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/connectivity/connectivity_cubit.dart';
import 'package:keeperpass/presentation/features/security/cubit/security_view.dart';

part 'security_cubit.freezed.dart';
part 'security_state.dart';

/// The Security tab (boards `Security`, `S4-13` … `S4-18`): the report over
/// the findings [AuditCubit] holds. Like the web's page it reads and never
/// starts a run itself — only "Check again" and "Try again" do.
@injectable
class SecurityCubit extends Cubit<SecurityState> {
  SecurityCubit(
    this._vault,
    this._audit,
    this._connectivity, {
    @ignoreParam this._now = DateTime.now,
  }) : super(const SecurityState()) {
    _subscriptions = <StreamSubscription<Object?>>[
      _vault.changes.listen((_) => _rebuild()),
      _audit.stream.listen((_) => _rebuild()),
      _connectivity.stream.listen((_) => _rebuild()),
    ];
    _rebuild();
  }

  final VaultSessionService _vault;
  final AuditCubit _audit;
  final ConnectivityCubit _connectivity;
  final DateTime Function() _now;
  late final List<StreamSubscription<Object?>> _subscriptions;

  /// The clock "Last checked …" is told with (tests fix it).
  DateTime now() => _now();

  /// The vaults, for "New item" when there is nothing to check.
  List<Vault> get vaults => _vault.snapshot?.vaults ?? const <Vault>[];

  /// "Check again" and "Try again": a full run, as after unlocking.
  Future<void> checkAgain() async {
    if (_audit.state.checking) return;
    await _audit.runFullAudit();
  }

  void _rebuild() {
    if (isClosed) return;
    final VaultSnapshot? snapshot = _vault.snapshot;
    emit(
      SecurityState(
        view: buildSecurityView(
          snapshot: snapshot,
          audit: _audit.state,
          locale: LocaleSettings.currentLocale.languageCode,
        ),
        offline: _connectivity.state is ConnectivityDisconnected,
      ),
    );
  }

  @override
  Future<void> close() async {
    for (final StreamSubscription<Object?> s in _subscriptions) {
      await s.cancel();
    }
    return super.close();
  }
}
