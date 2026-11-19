import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/utils/crypto/vault_crypto.dart';
import 'package:keeperpass/infrastructure/models/vault/encrypted_vault.dart';

/// test/fixtures/vault_crypto.json: vaults written by the web's own
/// `encryptVault` (hash-wasm 4.12.0 Argon2id + Web Crypto AES-GCM), a vault
/// from before compression, and raw Argon2id keys from hash-wasm.
void main() {
  final Map<String, dynamic> fixture =
      jsonDecode(File('test/fixtures/vault_crypto.json').readAsStringSync())
          as Map<String, dynamic>;
  final Object? plaintext = fixture['plaintext'];

  group('Argon2id keys are the web’s', () {
    for (final Map<String, dynamic> c
        in (fixture['keys'] as List<dynamic>).cast<Map<String, dynamic>>()) {
      test(
        '${c['memorySize']} KiB × ${c['iterations']} × ${c['parallelism']} — ${jsonEncode(c['password'])}',
        () async {
          final Uint8List key = await deriveVaultKey(
            c['password'] as String,
            _hex(c['salt'] as String),
            KdfParams(
              algorithm: 'argon2id',
              memorySize: c['memorySize'] as int,
              iterations: c['iterations'] as int,
              parallelism: c['parallelism'] as int,
            ),
          );
          expect(_toHex(key), c['key']);
        },
      );
    }
  });

  group('opens vaults the web wrote', () {
    for (final Map<String, dynamic> v
        in (fixture['vaults'] as List<dynamic>).cast<Map<String, dynamic>>()) {
      test(v['label'] as String, () async {
        final EncryptedVault encrypted = EncryptedVault.fromJson(
          v['encrypted'] as Map<String, dynamic>,
        );
        expect(await decryptVault(v['secret'] as String, encrypted), plaintext);
      });
    }

    test('a wrong secret is a WrongSecretException', () async {
      final Map<String, dynamic> v =
          (fixture['vaults'] as List<dynamic>).first as Map<String, dynamic>;
      await expectLater(
        decryptVault(
          fixture['wrongSecret'] as String,
          EncryptedVault.fromJson(v['encrypted'] as Map<String, dynamic>),
        ),
        throwsA(isA<WrongSecretException>()),
      );
    });
  });

  group('writes vaults', () {
    test('a fresh salt and IV each time, gzip, readable again', () async {
      const KdfParams fast = KdfParams(
        algorithm: 'argon2id',
        memorySize: 8192,
        iterations: 1,
        parallelism: 1,
      );
      final EncryptedVault a = await encryptVault(
        's3cret ✓',
        plaintext,
        kdf: fast,
      );
      final EncryptedVault b = await encryptVault(
        's3cret ✓',
        plaintext,
        kdf: fast,
      );
      expect(a.encoding, 'gzip');
      expect(base64.decode(a.salt), hasLength(16));
      expect(base64.decode(a.iv), hasLength(12));
      expect(a.salt, isNot(b.salt));
      expect(a.ciphertext, isNot(b.ciphertext));
      expect(await decryptVault('s3cret ✓', a), plaintext);
      final Map<String, dynamic> file = a.toFileJson();
      expect(
        file.keys,
        containsAll(<String>['salt', 'iv', 'ciphertext', 'kdf', 'encoding']),
      );
      expect(file['kdf'], <String, Object>{
        'algorithm': 'argon2id',
        'memorySize': 8192,
        'iterations': 1,
        'parallelism': 1,
      });
    });

    test('new vaults use the web’s parameters', () {
      expect(KdfParams.standard.toJson(), <String, Object>{
        'algorithm': 'argon2id',
        'memorySize': 65536,
        'iterations': 3,
        'parallelism': 4,
      });
    });
  });

  group('refuses files it should not open', () {
    final Map<String, dynamic> good =
        ((fixture['vaults'] as List<dynamic>).first
                as Map<String, dynamic>)['encrypted']
            as Map<String, dynamic>;

    EncryptedVault withKdf(Map<String, Object> kdf) =>
        EncryptedVault.fromJson(<String, dynamic>{
          ...good,
          'kdf': <String, Object>{
            ...(good['kdf'] as Map<String, dynamic>).cast<String, Object>(),
            ...kdf,
          },
        });

    for (final MapEntry<String, Map<String, Object>> c
        in <String, Map<String, Object>>{
          'another KDF': <String, Object>{'algorithm': 'pbkdf2'},
          'too much memory': <String, Object>{'memorySize': 4 * 1024 * 1024},
          'too little memory': <String, Object>{'memorySize': 64},
          'too many passes': <String, Object>{'iterations': 1000},
          'zero lanes': <String, Object>{'parallelism': 0},
        }.entries) {
      test(
        c.key,
        () => expect(
          () => decryptVault('x', withKdf(c.value)),
          throwsA(isA<UnsupportedVaultException>()),
        ),
      );
    }

    test('damaged base64 or IV', () async {
      await expectLater(
        decryptVault(
          'x',
          EncryptedVault.fromJson(<String, dynamic>{...good, 'iv': '!!!'}),
        ),
        throwsA(isA<CorruptVaultException>()),
      );
      await expectLater(
        decryptVault(
          'x',
          EncryptedVault.fromJson(<String, dynamic>{
            ...good,
            'iv': base64.encode(<int>[1, 2, 3]),
          }),
        ),
        throwsA(isA<CorruptVaultException>()),
      );
    });
  });
}

Uint8List _hex(String hex) => Uint8List.fromList(<int>[
  for (int i = 0; i < hex.length; i += 2)
    int.parse(hex.substring(i, i + 2), radix: 16),
]);

String _toHex(List<int> bytes) =>
    bytes.map((int b) => b.toRadixString(16).padLeft(2, '0')).join();
