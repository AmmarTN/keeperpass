import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/utils/crypto/pkce.dart';
import 'package:keeperpass/core/utils/crypto/sha1.dart';
import 'package:keeperpass/core/utils/crypto/totp.dart';
import 'package:keeperpass/core/utils/text/fold.dart';

/// Vectors from the web's own TypeScript (see each fixture's `source`).
Map<String, dynamic> _fixture(String name) =>
    jsonDecode(File('test/fixtures/$name.json').readAsStringSync())
        as Map<String, dynamic>;

List<Map<String, dynamic>> _cases(Map<String, dynamic> fixture, String key) =>
    (fixture[key] as List<dynamic>).cast<Map<String, dynamic>>();

String _hex(List<int> bytes) =>
    bytes.map((int b) => b.toRadixString(16).padLeft(2, '0')).join();

void main() {
  group('TOTP (core/otp/totp.ts)', () {
    final Map<String, dynamic> fixture = _fixture('totp');

    test('codes, including RFC 6238', () {
      for (final Map<String, dynamic> c in _cases(fixture, 'cases')) {
        expect(
          generateTotp(
            c['secret'] as String,
            timestampMs: c['timestamp'] as int,
            digits: c['digits'] as int,
            period: c['period'] as int,
          ),
          c['code'],
          reason: jsonEncode(c),
        );
      }
    });

    test('counter and progress', () {
      for (final Map<String, dynamic> c in _cases(fixture, 'counters')) {
        expect(
          totpCounter(c['timestamp'] as int, period: c['period'] as int),
          c['counter'],
        );
        expect(
          totpProgress(c['timestamp'] as int, period: c['period'] as int),
          closeTo((c['progress'] as num).toDouble(), 1e-12),
        );
      }
    });

    test('base32 decoding and its errors', () {
      for (final Map<String, dynamic> c in _cases(fixture, 'base32')) {
        expect(
          _hex(base32ToBytes(c['input'] as String)),
          c['hex'],
          reason: c['input'] as String,
        );
      }
      for (final Map<String, dynamic> c in _cases(fixture, 'invalid')) {
        expect(
          () => base32ToBytes(c['input'] as String),
          throwsA(
            isA<InvalidTotpSecretException>().having(
              (InvalidTotpSecretException e) => e.toString(),
              'message',
              c['error'],
            ),
          ),
        );
      }
    });
  });

  test('PKCE S256 (dropbox/pkce.ts), including RFC 7636', () {
    for (final Map<String, dynamic> c in _cases(_fixture('pkce'), 'cases')) {
      expect(codeChallengeS256(c['verifier'] as String), c['challenge']);
    }
    expect(randomUrlSafe(64), matches(RegExp(r'^[A-Za-z0-9_-]{86}$')));
  });

  test('SHA-1 hex (audit.ts)', () {
    for (final Map<String, dynamic> c in _cases(_fixture('sha1'), 'cases')) {
      expect(
        sha1Hex(c['value'] as String),
        c['hex'],
        reason: jsonEncode(c['value']),
      );
    }
  });

  test('fold (core/text/fold.ts)', () {
    for (final Map<String, dynamic> c in _cases(_fixture('fold'), 'cases')) {
      expect(
        foldText(c['value'] as String),
        c['folded'],
        reason: jsonEncode(c['value']),
      );
    }
  });
}
