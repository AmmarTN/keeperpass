import 'package:keeperpass/core/enums/audit_type.dart';
import 'package:keeperpass/core/utils/audit/report.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/presentation/common/cubit/audit/audit_cubit.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_view.dart';

/// What the report can show (boards `S4-13` … `S4-18`).
enum SecurityStatus {
  /// No item holds a password (`S4-18`).
  nothingToCheck,

  /// The first run of the session is going: everything waits (`S4-15`,
  /// your answer, Part 11).
  waiting,

  /// The first run could not finish: the banner and Try again only (your
  /// answer, Part 11).
  failed,

  /// Findings from the last run that went through (`S4-13`, `S4-16`).
  report,
}

/// What a row's grey line says (board `S4-13`).
enum SecurityDetailKind {
  /// The vault ("My Vault"): weak.
  vault,

  /// "Same as Instagram and Facebook": reused.
  sameAs,

  /// Reused only between the item's own fields.
  sameAsField,

  /// "Found in a known breach": compromised.
  breach,
}

class SecurityRow {
  const SecurityRow({
    required this.row,
    required this.kind,
    this.sharedWith = const <String>[],
  });

  final VaultRow row;
  final SecurityDetailKind kind;

  /// For [SecurityDetailKind.sameAs]: the other items' names, vault order.
  final List<String> sharedWith;
}

/// One kind of finding: its items in vault order (web `itemsWithFinding`),
/// at most [kReportRowsPerCard] of them, and how many there are.
class SecuritySection {
  const SecuritySection({
    required this.type,
    required this.count,
    required this.rows,
  });

  final AuditType type;
  final int count;
  final List<SecurityRow> rows;
}

class SecurityView {
  const SecurityView({
    this.status = SecurityStatus.waiting,
    this.checked = 0,
    this.flagged = 0,
    this.score,
    this.sections = const <SecuritySection>[],
    this.checking = false,
    this.lookedUp = 0,
    this.toLookUp = 0,
    this.timeLeft,
    this.checkedAt,
    this.failed = false,
  });

  final SecurityStatus status;

  /// Items holding a password, and those with a finding (web
  /// `checkedItemCount`, `flaggedItemCount`).
  final int checked;
  final int flagged;

  /// 0–100 (web `healthScore`); null until there are results.
  final int? score;

  /// Weak, reused, compromised — always all three, in that order.
  final List<SecuritySection> sections;

  /// A run is going; [lookedUp] of [toLookUp] distinct passwords so far.
  final bool checking;
  final int lookedUp;
  final int toLookUp;
  final Duration? timeLeft;

  /// When the findings shown were made.
  final DateTime? checkedAt;

  /// The last run could not finish (offline, or the service refused).
  final bool failed;

  HealthBand? get band => score == null ? null : healthBand(score!);

  bool get allClear => flagged == 0;
}

/// The report for [snapshot] with [audit]'s findings (web `ReportPage`).
SecurityView buildSecurityView({
  required VaultSnapshot? snapshot,
  required AuditState audit,
  required String locale,
}) {
  final List<VaultItem> items = snapshot?.items ?? const <VaultItem>[];
  final int checked = items.where(holdsPassword).length;
  final SecurityView progress = SecurityView(
    checked: checked,
    checking: audit.checking,
    lookedUp: audit.lookedUp,
    toLookUp: audit.toLookUp,
    timeLeft: audit.timeLeft,
    failed: audit.failure != null,
  );
  if (snapshot == null || checked == 0) {
    return _with(progress, SecurityStatus.nothingToCheck);
  }
  if (!audit.hasResults) {
    return _with(
      progress,
      audit.failure != null && !audit.checking
          ? SecurityStatus.failed
          : SecurityStatus.waiting,
    );
  }

  final PasswordUse use = PasswordUse(items);
  final Map<String, VaultItem> byId = <String, VaultItem>{
    for (final VaultItem item in items) item.id: item,
  };
  final Set<String> favourites = snapshot.favouriteIds.toSet();
  VaultRow rowOf(VaultItem item) => buildVaultRow(
    snapshot: snapshot,
    item: item,
    favourite: favourites.contains(item.id),
    findings: audit.findings,
    locale: locale,
  );

  final List<SecuritySection> sections = <SecuritySection>[
    for (final AuditType type in AuditType.values)
      () {
        final List<VaultItem> flagged = items
            .where((VaultItem item) => audit.hasFinding(item.id, type))
            .toList();
        return SecuritySection(
          type: type,
          count: flagged.length,
          rows: <SecurityRow>[
            for (final VaultItem item in flagged.take(kReportRowsPerCard))
              switch (type) {
                AuditType.weakPassword => SecurityRow(
                  row: rowOf(item),
                  kind: SecurityDetailKind.vault,
                ),
                AuditType.compromisedPassword => SecurityRow(
                  row: rowOf(item),
                  kind: SecurityDetailKind.breach,
                ),
                AuditType.reusedPassword => () {
                  final List<String> others = use.sharingWith(item.id);
                  return SecurityRow(
                    row: rowOf(item),
                    kind: others.isEmpty
                        ? SecurityDetailKind.sameAsField
                        : SecurityDetailKind.sameAs,
                    sharedWith: <String>[
                      for (final String id in others) byId[id]!.name,
                    ],
                  );
                }(),
              },
          ],
        );
      }(),
  ];

  final int flagged = audit.flaggedCount;
  return SecurityView(
    status: SecurityStatus.report,
    checked: checked,
    flagged: flagged,
    score: healthScore(checked: checked, flagged: flagged),
    sections: sections,
    checking: audit.checking,
    lookedUp: audit.lookedUp,
    toLookUp: audit.toLookUp,
    timeLeft: audit.timeLeft,
    checkedAt: audit.checkedAt,
    failed: audit.failure != null,
  );
}

SecurityView _with(SecurityView view, SecurityStatus status) => SecurityView(
  status: status,
  checked: view.checked,
  checking: view.checking,
  lookedUp: view.lookedUp,
  toLookUp: view.toLookUp,
  timeLeft: view.timeLeft,
  failed: view.failed,
);
