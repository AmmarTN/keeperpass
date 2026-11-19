import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/network_failure.dart';
import 'package:keeperpass/core/utils/audit/audit.dart';
import 'package:keeperpass/core/utils/crypto/sha1.dart';
import 'package:keeperpass/infrastructure/models/audit/audit_result.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';

/// The audit against `test/fixtures/audit.json`: the web's own `auditItems`
/// run in Node with Have I Been Pwned mocked (plan Part 11).
void main() {
  final Map<String, dynamic> fixture =
      jsonDecode(File('test/fixtures/audit.json').readAsStringSync())
          as Map<String, dynamic>;

  for (final Map<String, dynamic> c
      in (fixture['cases'] as List<dynamic>).cast<Map<String, dynamic>>()) {
    test(c['name'], () async {
      final List<VaultItem> items = <VaultItem>[
        for (final dynamic json in c['items'] as List<dynamic>)
          VaultItem.fromJson(json as Map<String, dynamic>),
      ];
      final Set<String> breached = <String>{
        for (final dynamic p in c['breached'] as List<dynamic>)
          sha1Hex(p as String),
      };
      final List<String> asked = <String>[];
      final bool refused = c['failStatus'] != null;

      final Either<Failure, Map<String, List<AuditResult>>> result =
          await auditItems(
            items,
            onlyItemId: c['onlyItemId'] as String?,
            isCompromised: (String hash) async {
              asked.add(hash.substring(0, 5));
              if (refused) {
                return Left(
                  Failure.networkFailure(
                    NetworkFailure.defaultError(
                      'Breach lookup failed with status ${c['failStatus']}',
                    ),
                  ),
                );
              }
              return Right(breached.contains(hash));
            },
          );

      if (refused) {
        expect(result.isLeft(), c['failed']);
        return;
      }
      final Map<String, List<AuditResult>> findings = result.getOrElse(
        () => throw StateError('failed'),
      );
      expect(
        findings.map(
          (String id, List<AuditResult> results) =>
              MapEntry<String, dynamic>(id, <dynamic>[
                for (final AuditResult r in results)
                  <String, dynamic>{
                    'type': r.type.value,
                    'fieldIndex': r.fieldIndex,
                  },
              ]),
        ),
        c['findings'],
      );
      // One lookup per distinct password, by its first five characters.
      expect(asked..sort(), c['lookups']);
    });
  }
}
