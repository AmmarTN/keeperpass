import 'package:keeperpass/core/enums/sync_phase.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/cubit/audit/audit_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/sync/sync_cubit.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/features/edit_item/pages/edit_item_page.dart';

/// What saving a fix came to (board `S4-22`).
class FixOutcome {
  const FixOutcome({
    required this.name,
    required this.flagged,
    required this.storage,
  });

  final String name;

  /// The item still has a finding after its re-check.
  final bool flagged;

  /// "Google Drive".
  final String storage;
}

/// Waits until the fix is stored and the item checked again (your answer,
/// Part 11); null when either did not go through — the save states of Part
/// 14 speak for a save that failed, so no toast.
Future<FixOutcome?> watchFix(
  EditSaved saved, {
  required SyncCubit sync,
  required AuditCubit audit,
  required String storage,
}) async {
  final List<bool> done = await Future.wait(<Future<bool>>[
    saved.recheck,
    _stored(sync),
  ]);
  if (done.contains(false)) return null;
  return FixOutcome(
    name: saved.name,
    flagged: audit.state.findingsFor(saved.itemId).isNotEmpty,
    storage: storage,
  );
}

/// Whether the changes waiting now reach storage.
Future<bool> _stored(SyncCubit sync) async {
  bool stored(SyncState s) =>
      s.phase == SyncPhase.saved && s.pendingChanges == 0;
  bool stopped(SyncState s) => switch (s.phase) {
    SyncPhase.failed ||
    SyncPhase.conflict ||
    SyncPhase.sessionExpired ||
    SyncPhase.offline => true,
    // Locked: the change went with the vault.
    SyncPhase.idle => s.pendingChanges == 0,
    _ => false,
  };
  if (stored(sync.state)) return true;
  if (stopped(sync.state)) return false;
  final SyncState end = await sync.stream.firstWhere(
    (SyncState s) => stored(s) || stopped(s),
    orElse: () => const SyncState(),
  );
  return stored(end);
}

/// "Saved · Netflix is no longer flagged / Your vault was saved to Google
/// Drive" (board `S4-22`).
void showFixToast(AppToastHostState toasts, FixOutcome outcome) => toasts.show(
  AppToastData(
    icon: AppIconName.circleCheck,
    title: outcome.flagged
        ? t.report.fixedFlagged(name: outcome.name)
        : t.report.fixedClear(name: outcome.name),
    detail: t.report.savedTo(storage: outcome.storage),
  ),
);
