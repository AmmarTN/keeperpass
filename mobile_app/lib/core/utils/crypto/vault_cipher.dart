import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/utils/crypto/vault_crypto.dart';
import 'package:keeperpass/infrastructure/models/vault/encrypted_vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';

/// [encryptVault] / [decryptVault] between the stored file's text and the
/// vault's data, with crypto errors as [Failure]s. One class so use cases can
/// be tested without running Argon2.
@lazySingleton
class VaultCipher {
  /// The vault file's contents for [data] (web
  /// `JSON.stringify(await encryptVault(secret, data))`).
  Future<String> encrypt(String secret, Object? data) async =>
      jsonEncode((await encryptVault(secret, data)).toFileJson());

  /// The decrypted JSON of a stored vault file.
  Future<Either<Failure, Object?>> decrypt(String secret, String stored) async {
    final EncryptedVault encrypted;
    try {
      final Object? json = jsonDecode(stored);
      if (json is! Map<String, dynamic>) {
        return const Left(Failure.corruptVault());
      }
      encrypted = EncryptedVault.fromJson(json);
    } on FormatException {
      return const Left(Failure.corruptVault());
    } on TypeError {
      return const Left(Failure.corruptVault());
    }
    try {
      return Right(await decryptVault(secret, encrypted));
    } on WrongSecretException {
      return const Left(Failure.wrongSecret());
    } on UnsupportedVaultException {
      return const Left(Failure.unsupportedVault());
    } on CorruptVaultException {
      return const Left(Failure.corruptVault());
    }
  }

  /// A stored vault file opened as a [VaultSnapshot] (web `hydrate`).
  Future<Either<Failure, VaultSnapshot>> open(
    String secret,
    String stored,
  ) async {
    final Either<Failure, Object?> data = await decrypt(secret, stored);
    return data.fold(Left.new, (Object? json) {
      if (json is! Map<String, dynamic>) {
        return const Left(Failure.corruptVault());
      }
      try {
        return Right(VaultSnapshot.fromJson(json));
      } on TypeError {
        return const Left(Failure.corruptVault());
      } on FormatException {
        return const Left(Failure.corruptVault());
      }
    });
  }
}
