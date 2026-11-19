import 'package:keeperpass/core/enums/audit_type.dart';
import 'package:keeperpass/core/utils/audit/report.dart';
import 'package:keeperpass/core/utils/text/date_formats.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/widgets/cards/app_report_cards.dart';
import 'package:keeperpass/presentation/features/security/cubit/security_view.dart';
import 'package:keeperpass/presentation/features/vault_list/widgets/vault_rows.dart';

/// "Weak Passwords" (web `AUDIT_LABEL_KEYS`).
String auditLabel(AuditType type) => switch (type) {
  AuditType.weakPassword => t.audit.weakPassword.label,
  AuditType.reusedPassword => t.audit.reusedPassword.label,
  AuditType.compromisedPassword => t.audit.compromisedPassword.label,
};

/// Why a kind of finding matters (web `AUDIT_DESCRIPTION_KEYS`).
String auditDescription(AuditType type) => switch (type) {
  AuditType.weakPassword => t.audit.weakPassword.description,
  AuditType.reusedPassword => t.audit.reusedPassword.description,
  AuditType.compromisedPassword => t.audit.compromisedPassword.description,
};

/// The finding's icon (web `AUDIT_GLYPHS`).
AppIconName auditIcon(AuditType type) => switch (type) {
  AuditType.weakPassword => AppIconName.shieldAlert,
  AuditType.reusedPassword => AppIconName.repeat2,
  AuditType.compromisedPassword => AppIconName.shieldX,
};

/// The stat tile's word ("Weak").
String statLabel(AuditType type) => switch (type) {
  AuditType.weakPassword => t.report.statWeak,
  AuditType.reusedPassword => t.report.statReused,
  AuditType.compromisedPassword => t.report.statCompromised,
};

/// A card with nothing in it (web `AUDIT_EMPTY_KEYS`; your answer, Part 11).
String emptyText(AuditType type) => switch (type) {
  AuditType.weakPassword => t.vaultList.allClearWeak,
  AuditType.reusedPassword => t.vaultList.allClearReused,
  AuditType.compromisedPassword => t.vaultList.allClearCompromised,
};

/// "How to fix it" (board `S4-14`); a compromised password is also changed
/// on its site (your answer, Part 11).
List<String> fixSteps(AuditType type) => <String>[
  t.report.stepOpen,
  t.report.stepGenerate,
  if (type == AuditType.compromisedPassword)
    t.report.stepSaveCompromised
  else
    t.report.stepSave,
];

AppHealthBand healthBandOf(HealthBand band) => switch (band) {
  HealthBand.good => AppHealthBand.strong,
  HealthBand.fair => AppHealthBand.needsWork,
  HealthBand.poor => AppHealthBand.atRisk,
};

String healthBandLabel(HealthBand band) => switch (band) {
  HealthBand.good => t.report.healthGood,
  HealthBand.fair => t.report.healthFair,
  HealthBand.poor => t.report.healthPoor,
};

/// "Instagram and Facebook": up to three names, more as a count (Part 7's
/// rule for names in a sentence).
String sameAsText(SecurityRow row) {
  final List<String> names = <String>[
    for (final String name in row.sharedWith)
      name.isEmpty ? t.vaultList.unnamed : name,
  ];
  return switch (names.length) {
    1 => t.report.sameAs(names: names[0]),
    2 => t.report.sameAs(
      names: t.vaultList.listTwo(a: names[0], b: names[1]),
    ),
    3 => t.report.sameAs(
      names: t.vaultList.listThree(a: names[0], b: names[1], c: names[2]),
    ),
    _ => t.report.sameAsOthers(n: names.length),
  };
}

/// A row's grey line (board `S4-13`).
String detailText(SecurityRow row) => switch (row.kind) {
  SecurityDetailKind.vault => row.row.vaultLabel,
  SecurityDetailKind.sameAs => sameAsText(row),
  SecurityDetailKind.sameAsField => t.report.sameAsField,
  SecurityDetailKind.breach => t.report.foundInBreach,
};

/// "about 10 seconds": seconds rounded up to fives under a minute, then
/// whole minutes, rounded up.
String timeLeftText(Duration left) {
  final int seconds = left.inMilliseconds <= 0
      ? 1
      : (left.inMilliseconds / 1000).ceil();
  if (seconds < 60) {
    final int fives = seconds <= 5 ? 5 : ((seconds + 4) ~/ 5) * 5;
    return t.report.aboutSeconds(n: fives >= 60 ? 55 : fives);
  }
  return t.report.aboutMinutes(n: (seconds / 60).ceil());
}

/// "Last checked just now" within a minute, "… today at 9:41 AM" the same
/// day, otherwise the date and time.
String lastCheckedText(DateTime at, DateTime now, String locale) {
  if (now.difference(at) < const Duration(minutes: 1)) {
    return t.report.lastCheckedJustNow;
  }
  final DateTime local = at.toLocal();
  final DateTime today = now.toLocal();
  if (local.year == today.year &&
      local.month == today.month &&
      local.day == today.day) {
    return t.report.lastCheckedToday(time: formatShortTime(local, locale));
  }
  return t.report.lastCheckedOn(date: formatDateTime(local, locale));
}

/// The name a row or toast says.
String itemName(SecurityRow row) => rowName(row.row);
