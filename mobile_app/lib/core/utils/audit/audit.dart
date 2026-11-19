import 'package:dartz/dartz.dart';
import 'package:keeperpass/core/enums/audit_type.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/utils/crypto/sha1.dart';
import 'package:keeperpass/core/utils/validation/password_strength.dart';
import 'package:keeperpass/infrastructure/models/audit/audit_result.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';

/// Below this score a password is weak — the same line as the master
/// password's (web `WEAK_PASSWORD_SCORE_THRESHOLD`).
const int kWeakPasswordScoreThreshold = 2;

/// Longer than this and a password is strong without being scored (web
/// `MAX_PASSWORD_LENGTH_TO_SCORE`).
const int kMaxPasswordLengthToScore = 100;

/// How many breach lookups run at once (web `BREACH_LOOKUP_CONCURRENCY`).
const int kBreachLookupConcurrency = 10;

/// Whether the password with this lower-case SHA-1 hash is in a known
/// breach. A lookup that could not be answered is a failure, never "no".
typedef BreachLookup = Future<Either<Failure, bool>> Function(String hash);

/// How far the breach lookups are: [done] of [total] distinct passwords.
/// For the report's progress only; it changes nothing in the run.
typedef AuditProgress = void Function(int done, int total);

bool isPasswordWeak(String password) {
  if (password.length > kMaxPasswordLengthToScore) return false;
  return estimatePasswordStrength(password).score < kWeakPasswordScoreThreshold;
}

/// Audits every item's passwords (web `auditItems`): reused (the same
/// password on more than one field), weak, and compromised. With
/// [onlyItemId] every item is still scanned — reuse is a question about the
/// whole vault — but only that item is reported. Any unanswered breach
/// lookup fails the whole run, so the caller keeps its last findings.
/// [onProgress] hears how many distinct passwords were looked up so far.
Future<Either<Failure, Map<String, List<AuditResult>>>> auditItems(
  List<VaultItem> items, {
  required BreachLookup isCompromised,
  String? onlyItemId,
  AuditProgress? onProgress,
}) async {
  final Map<String, List<_ScannedPassword>> passwordsByItem = _scanPasswords(
    items,
  );
  final Map<String, int> timesUsed = <String, int>{};
  for (final List<_ScannedPassword> passwords in passwordsByItem.values) {
    for (final _ScannedPassword password in passwords) {
      timesUsed[password.hash] = (timesUsed[password.hash] ?? 0) + 1;
    }
  }

  final Either<Failure, Map<String, bool>> lookups = await _lookupCompromised(
    timesUsed.keys.toList(),
    isCompromised,
    onProgress,
  );
  return lookups.map((Map<String, bool> compromised) {
    final Map<String, List<AuditResult>> results =
        <String, List<AuditResult>>{};
    for (final VaultItem item in items) {
      if (onlyItemId != null && item.id != onlyItemId) continue;
      results[item.id] = <AuditResult>[
        for (final _ScannedPassword password
            in passwordsByItem[item.id] ??
                const <_ScannedPassword>[]) ...<AuditResult>[
          if ((timesUsed[password.hash] ?? 0) > 1)
            AuditResult(
              type: AuditType.reusedPassword,
              fieldIndex: password.fieldIndex,
            ),
          if (isPasswordWeak(password.value))
            AuditResult(
              type: AuditType.weakPassword,
              fieldIndex: password.fieldIndex,
            ),
          if (compromised[password.hash] ?? false)
            AuditResult(
              type: AuditType.compromisedPassword,
              fieldIndex: password.fieldIndex,
            ),
        ],
      ];
    }
    return results;
  });
}

/// Whether one breach-range response lists [hash] (web
/// `isPasswordCompromised`): each line is `SUFFIX:COUNT`.
bool rangeContains(String body, String hash) {
  final String prefix = hash.substring(0, 5);
  return body
      .split('\r\n')
      .any(
        (String line) => '$prefix${line.split(':')[0].toLowerCase()}' == hash,
      );
}

class _ScannedPassword {
  const _ScannedPassword(this.fieldIndex, this.value, this.hash);

  final int fieldIndex;
  final String value;
  final String hash;
}

Map<String, List<_ScannedPassword>> _scanPasswords(List<VaultItem> items) {
  final Map<String, List<_ScannedPassword>> byItem =
      <String, List<_ScannedPassword>>{};
  for (final VaultItem item in items) {
    final List<_ScannedPassword> scanned = <_ScannedPassword>[
      for (int i = 0; i < item.fields.length; i++)
        if (_isPassword(item.fields[i]))
          _ScannedPassword(
            i,
            item.fields[i].value,
            sha1Hex(item.fields[i].value),
          ),
    ];
    if (scanned.isNotEmpty) byItem[item.id] = scanned;
  }
  return byItem;
}

bool _isPassword(Field field) =>
    field.type == FieldType.password && field.value.isNotEmpty;

Future<Either<Failure, Map<String, bool>>> _lookupCompromised(
  List<String> hashes,
  BreachLookup isCompromised,
  AuditProgress? onProgress,
) async {
  final Map<String, bool> compromised = <String, bool>{};
  onProgress?.call(0, hashes.length);
  for (
    int start = 0;
    start < hashes.length;
    start += kBreachLookupConcurrency
  ) {
    final List<String> batch = hashes.sublist(
      start,
      (start + kBreachLookupConcurrency).clamp(0, hashes.length),
    );
    final List<Either<Failure, bool>> answers = await Future.wait(
      batch.map(isCompromised),
    );
    for (int i = 0; i < batch.length; i++) {
      final Failure? failure = answers[i].fold((Failure f) => f, (_) => null);
      if (failure != null) return Left(failure);
      compromised[batch[i]] = answers[i].getOrElse(() => false);
    }
    onProgress?.call(start + batch.length, hashes.length);
  }
  return Right(compromised);
}
