import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/audit_type.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/utils/audit/audit.dart';
import 'package:keeperpass/core/utils/crypto/sha1.dart';
import 'package:keeperpass/infrastructure/models/audit/audit_result.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';

VaultItem login(String id, List<String> passwords) => VaultItem(
  id: id,
  vaultId: 'v',
  name: id,
  updated: DateTime.utc(2026),
  fields: <Field>[
    Field.of(name: 'User', type: FieldType.username, value: 'jane'),
    for (final String p in passwords)
      Field.of(name: 'Password', type: FieldType.password, value: p),
  ],
);

void main() {
  const String strong = 'Correct-Horse-Battery-Staple-77';
  const String reused = 'Another-Long-Passphrase-For-Two-9';

  Future<Either<Failure, bool>> breachedOnly(
    Set<String> breached,
    String hash,
  ) async => Right(breached.map(sha1Hex).contains(hash));

  test('reused, weak and compromised, by field (web auditItems)', () async {
    final Map<String, List<AuditResult>> findings = (await auditItems(
      <VaultItem>[
        login('a', <String>[strong]),
        login('b', <String>['abc123', reused]),
        login('c', <String>[reused]),
        login('d', <String>[]),
      ],
      isCompromised: (String hash) => breachedOnly(<String>{'abc123'}, hash),
    )).getOrElse(() => throw StateError('failed'));

    expect(findings['a'], isEmpty);
    expect(findings['b'], <AuditResult>[
      const AuditResult(type: AuditType.weakPassword, fieldIndex: 1),
      const AuditResult(type: AuditType.compromisedPassword, fieldIndex: 1),
      const AuditResult(type: AuditType.reusedPassword, fieldIndex: 2),
    ]);
    expect(findings['c'], <AuditResult>[
      const AuditResult(type: AuditType.reusedPassword, fieldIndex: 1),
    ]);
    expect(findings['d'], isEmpty);
  });

  test('one item reported, every item scanned for reuse', () async {
    final Map<String, List<AuditResult>> findings = (await auditItems(
      <VaultItem>[
        login('b', <String>[reused]),
        login('c', <String>[reused]),
      ],
      isCompromised: (_) async => const Right(false),
      onlyItemId: 'c',
    )).getOrElse(() => throw StateError('failed'));
    expect(findings.keys, <String>['c']);
    expect(findings['c']!.single.type, AuditType.reusedPassword);
  });

  test('an unanswered breach lookup fails the run', () async {
    final Either<Failure, Map<String, List<AuditResult>>> result =
        await auditItems(
          <VaultItem>[
            login('a', <String>[strong]),
          ],
          isCompromised: (_) async =>
              const Left(Failure.unexpectedError('offline')),
        );
    expect(result.isLeft(), isTrue);
  });

  test('passwords over 100 characters are not scored', () {
    expect(isPasswordWeak('a' * 101), isFalse);
    expect(isPasswordWeak('abc123'), isTrue);
  });

  test('a range answer is matched on prefix + suffix', () {
    final String hash = sha1Hex('abc123');
    final String body =
        'AAAA:1\r\n${hash.substring(5).toUpperCase()}:42\r\nBBBB:3';
    expect(rangeContains(body, hash), isTrue);
    expect(rangeContains('AAAA:1', hash), isFalse);
  });
}
