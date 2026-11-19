import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:cryptography/dart.dart';
import 'package:keeperpass/infrastructure/models/vault/encrypted_vault.dart';

/// The vault's encryption (web `core/vault/vault-crypto.ts`), byte for byte.
///
/// Argon2id derives an AES-256-GCM key from the secret; a fresh 16-byte salt
/// and 12-byte IV are drawn for every save, so the same data never encrypts
/// the same way twice. The JSON is gzip-compressed before encryption.
/// Everything runs on a background isolate: the 64 MiB derivation must never
/// block the interface.
///
/// Never use a libsodium-based package here: libsodium fixes Argon2's
/// parallelism at 1 and cannot derive this vault's key (plan, "Settled").

/// Why a vault could not be opened.
sealed class VaultCryptoException implements Exception {
  const VaultCryptoException();
}

/// The secret is not the one the vault was written with (GCM authentication
/// failed).
final class WrongSecretException extends VaultCryptoException {
  const WrongSecretException();

  @override
  String toString() => 'WrongSecretException';
}

/// The file asks for something this app does not do (another KDF, or
/// parameters outside [KdfBounds]).
final class UnsupportedVaultException extends VaultCryptoException {
  const UnsupportedVaultException(this.reason);

  final String reason;

  @override
  String toString() => 'UnsupportedVaultException: $reason';
}

/// The file is damaged: bad base64, wrong IV length, unreadable content.
final class CorruptVaultException extends VaultCryptoException {
  const CorruptVaultException(this.reason);

  final String reason;

  @override
  String toString() => 'CorruptVaultException: $reason';
}

const int _keyBytes = 32;
const int _saltBytes = 16;
const int _ivBytes = 12;
const int _gcmTagBytes = 16;

/// What a file's KDF parameters may ask for. The web always writes 64 MiB,
/// 3 passes, 4 lanes; these bounds leave room for a future tuning while
/// refusing a file that would exhaust a phone's memory or hang the unlock.
abstract final class KdfBounds {
  static const int minMemoryKiB = 8 * 1024;
  static const int maxMemoryKiB = 256 * 1024;
  static const int maxIterations = 10;
  static const int maxParallelism = 16;
}

/// Encrypts [data] (the vault's JSON value) with [secret], as the web's
/// `encryptVault` does.
Future<EncryptedVault> encryptVault(
  String secret,
  Object? data, {
  KdfParams kdf = KdfParams.standard,
}) {
  final Random random = Random.secure();
  final Uint8List salt = Uint8List.fromList(
    List<int>.generate(_saltBytes, (_) => random.nextInt(256)),
  );
  final Uint8List iv = Uint8List.fromList(
    List<int>.generate(_ivBytes, (_) => random.nextInt(256)),
  );
  return Isolate.run(() => _encrypt(secret, data, kdf, salt, iv));
}

/// Decrypts a vault, as the web's `decryptVault` does. Throws
/// [WrongSecretException], [UnsupportedVaultException] or
/// [CorruptVaultException].
Future<Object?> decryptVault(String secret, EncryptedVault encrypted) {
  _checkKdf(encrypted.kdf);
  return Isolate.run(() => _decrypt(secret, encrypted));
}

/// The raw Argon2id key (exposed for the compatibility tests).
Future<Uint8List> deriveVaultKey(
  String secret,
  List<int> salt,
  KdfParams kdf,
) => Isolate.run(() => _deriveKey(secret, salt, kdf));

Future<EncryptedVault> _encrypt(
  String secret,
  Object? data,
  KdfParams kdf,
  Uint8List salt,
  Uint8List iv,
) async {
  final Uint8List key = await _deriveKey(secret, salt, kdf);
  final List<int> json = utf8.encode(_jsonStringify(data));
  final List<int> plaintext = gzip.encode(json);
  final SecretBox box = await AesGcm.with256bits().encrypt(
    plaintext,
    secretKey: SecretKey(key),
    nonce: iv,
  );
  return EncryptedVault(
    salt: base64.encode(salt),
    iv: base64.encode(iv),
    ciphertext: base64.encode(<int>[...box.cipherText, ...box.mac.bytes]),
    kdf: kdf,
    encoding: 'gzip',
  );
}

Future<Object?> _decrypt(String secret, EncryptedVault encrypted) async {
  final Uint8List salt = _fromBase64(encrypted.salt, 'salt');
  final Uint8List iv = _fromBase64(encrypted.iv, 'iv');
  final Uint8List sealed = _fromBase64(encrypted.ciphertext, 'ciphertext');
  if (iv.length != _ivBytes) {
    throw CorruptVaultException('IV is ${iv.length} bytes, not $_ivBytes');
  }
  if (sealed.length < _gcmTagBytes) {
    throw const CorruptVaultException('ciphertext is shorter than its tag');
  }

  final Uint8List key = await _deriveKey(secret, salt, encrypted.kdf);
  final SecretBox box = SecretBox(
    sealed.sublist(0, sealed.length - _gcmTagBytes),
    nonce: iv,
    mac: Mac(sealed.sublist(sealed.length - _gcmTagBytes)),
  );

  final List<int> decrypted;
  try {
    decrypted = await AesGcm.with256bits().decrypt(
      box,
      secretKey: SecretKey(key),
    );
  } on SecretBoxAuthenticationError {
    throw const WrongSecretException();
  }

  // No `encoding` means a vault from before compression: plain UTF-8 JSON.
  final List<int> plaintext;
  try {
    plaintext = encrypted.encoding == 'gzip'
        ? gzip.decode(decrypted)
        : decrypted;
  } on FormatException catch (e) {
    throw CorruptVaultException('gzip: ${e.message}');
  }
  try {
    return jsonDecode(utf8.decode(plaintext, allowMalformed: true));
  } on FormatException catch (e) {
    throw CorruptVaultException('JSON: ${e.message}');
  }
}

/// [kdf] is trusted here: files are checked against [KdfBounds] in
/// [decryptVault] before anything is derived.
Future<Uint8List> _deriveKey(
  String secret,
  List<int> salt,
  KdfParams kdf,
) async {
  final DartArgon2id argon2 = DartArgon2id(
    parallelism: kdf.parallelism,
    memory: kdf.memorySize,
    iterations: kdf.iterations,
    hashLength: _keyBytes,
  );
  final SecretKey key = await argon2.deriveKey(
    secretKey: SecretKey(utf8.encode(secret)),
    nonce: salt,
  );
  return Uint8List.fromList(await key.extractBytes());
}

void _checkKdf(KdfParams kdf) {
  if (kdf.algorithm != 'argon2id') {
    throw UnsupportedVaultException('KDF ${kdf.algorithm}');
  }
  if (kdf.memorySize < KdfBounds.minMemoryKiB ||
      kdf.memorySize > KdfBounds.maxMemoryKiB) {
    throw UnsupportedVaultException('Argon2 memory ${kdf.memorySize} KiB');
  }
  if (kdf.iterations < 1 || kdf.iterations > KdfBounds.maxIterations) {
    throw UnsupportedVaultException('Argon2 iterations ${kdf.iterations}');
  }
  if (kdf.parallelism < 1 || kdf.parallelism > KdfBounds.maxParallelism) {
    throw UnsupportedVaultException('Argon2 parallelism ${kdf.parallelism}');
  }
}

Uint8List _fromBase64(String value, String what) {
  try {
    return base64.decode(value);
  } on FormatException {
    throw CorruptVaultException('$what is not base64');
  }
}

/// `JSON.stringify`: the same text the web would write. Lone surrogates
/// become U+FFFD, as `TextEncoder` would make them.
String _jsonStringify(Object? data) => jsonEncode(data).replaceAll(
  RegExp(
    r'[\uD800-\uDBFF](?![\uDC00-\uDFFF])|(?<![\uD800-\uDBFF])[\uDC00-\uDFFF]',
  ),
  '\uFFFD',
);
