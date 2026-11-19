import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/auth/get_available_providers.dart';
import 'package:keeperpass/core/usecases/auth/mark_session_expired.dart';
import 'package:keeperpass/core/usecases/auth/refresh_profile.dart';
import 'package:keeperpass/core/usecases/auth/restore_session.dart';
import 'package:keeperpass/core/usecases/auth/sign_in.dart';
import 'package:keeperpass/core/usecases/auth/sign_out.dart';
import 'package:keeperpass/core/usecases/vault/archive_vault.dart';
import 'package:keeperpass/core/usecases/vault/check_vault.dart';
import 'package:keeperpass/core/usecases/vault/lock_vault.dart';
import 'package:keeperpass/core/usecases/vault/unlock_vault.dart';
import 'package:keeperpass/core/utils/crypto/vault_cipher.dart';
import 'package:keeperpass/infrastructure/datasources/remote_datasources/vault_storage_remote_data_source.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/models/auth/token_grant.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_file_info.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/repositories/auth_repository_impl.dart';
import 'package:keeperpass/infrastructure/repositories/vault_storage_repository_impl.dart';
import 'package:keeperpass/infrastructure/services/lock_service.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';

const ProviderAccount kJane = ProviderAccount(
  provider: ProviderId.google,
  email: 'jane@example.com',
  name: 'Jane Doe',
);

/// The session side of the use cases: a signed-in account and a token, with
/// switches for an expired session and scripted sign-ins.
class FakeAuthRepository implements IAuthRepository {
  ProviderAccount? current = kJane;
  String token = 'token-1';

  /// Every [authorized] call fails this way instead of running.
  Failure? tokenFailure;
  final List<ProviderId> available = <ProviderId>[
    ProviderId.google,
    ProviderId.dropbox,
  ];
  Either<Failure, ProviderAccount>? reconnectResult;
  Either<Failure, ProviderSignIn>? elsewhereResult;
  Either<Failure, ProviderAccount>? signInResult;
  int signOuts = 0;
  int expiredMarks = 0;

  @override
  ProviderAccount? get account => current;

  @override
  List<ProviderId> availableProviders() => available;

  @override
  Future<Either<Failure, T>> authorized<T>(
    Future<Either<Failure, T>> Function(String accessToken) call,
  ) async {
    final Failure? failure = tokenFailure;
    if (failure != null) return Left(failure);
    return call(token);
  }

  @override
  Future<Either<Failure, Unit>> markExpired() async {
    expiredMarks++;
    current = null;
    return const Right(unit);
  }

  @override
  Future<Either<Failure, ProviderAccount>> reconnect() async =>
      reconnectResult ?? Right(current!);

  @override
  Future<Either<Failure, ProviderAccount>> refreshProfile() async =>
      Right(current!);

  @override
  Future<Either<Failure, RememberedSession?>> restoreSession() async =>
      Right(current == null ? null : RememberedSession(account: current!));

  @override
  Future<Either<Failure, ProviderAccount>> signIn(ProviderId provider) async {
    final Either<Failure, ProviderAccount> result =
        signInResult ?? Right(kJane.copyWith(provider: provider));
    result.fold((_) {}, (ProviderAccount account) => current = account);
    return result;
  }

  @override
  Future<Either<Failure, ProviderSignIn>> signInElsewhere(
    ProviderId provider,
  ) async =>
      elsewhereResult ??
      Right(
        ProviderSignIn(
          provider: provider,
          grant: const TokenGrant(accessToken: 'target-token'),
          profile: const ProviderProfile(email: 'jane@dropbox.example'),
        ),
      );

  @override
  Future<Either<Failure, Unit>> signOut() async {
    signOuts++;
    current = null;
    return const Right(unit);
  }
}

/// Storage keyed by provider, with scripted failures per method.
class FakeStorageRepository implements IVaultStorageRepository {
  final Map<ProviderId, String?> files = <ProviderId, String?>{};
  final Map<ProviderId, VaultFileInfo?> newer = <ProviderId, VaultFileInfo?>{};
  final List<String> calls = <String>[];
  final Map<String, Failure> failures = <String, Failure>{};
  final List<DateTime> backups = <DateTime>[];

  /// What a read hands back instead of the stored file (verification tests).
  String? Function(String? stored)? tamperOnLoad;
  List<double> progress = <double>[0, 1];

  /// Holds each save until completed (a save shown mid-way).
  Completer<void>? hold;

  /// While set, a check for a newer version waits for it (a slow network).
  Completer<void>? holdNewer;

  /// The name an archived or moved-away vault gets.
  String detachedName = 'vault.removed-2026-10-29T14-32-00.json.enc';

  Either<Failure, T>? _fail<T>(String name) {
    calls.add(name);
    final Failure? failure = failures[name];
    return failure == null ? null : Left(failure);
  }

  @override
  Future<Either<Failure, VaultFileInfo?>> findVault(
    ProviderId provider,
    String accessToken,
  ) async =>
      _fail('find:${provider.value}') ??
      Right(
        files[provider] == null
            ? null
            : VaultFileInfo(modifiedAt: DateTime.utc(2026, 10, 28)),
      );

  @override
  Future<Either<Failure, String?>> loadVault(
    ProviderId provider,
    String accessToken,
  ) async {
    final String? stored = files[provider];
    return _fail('load:${provider.value}') ??
        Right(tamperOnLoad == null ? stored : tamperOnLoad!(stored));
  }

  @override
  Future<Either<Failure, Unit>> saveVault(
    ProviderId provider,
    String accessToken,
    String content, {
    UploadProgress? onProgress,
  }) async {
    final Either<Failure, Unit>? failure = _fail('save:${provider.value}');
    if (failure != null) return failure;
    // Like Drive and Dropbox: the upload says it started, then holds.
    if (hold != null) onProgress?.call(0);
    await hold?.future;
    progress.forEach(onProgress ?? (_) {});
    files[provider] = content;
    return const Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> resetVault(
    ProviderId provider,
    String accessToken,
    String content, {
    required DateTime backupAt,
    void Function()? onBackedUp,
    UploadProgress? onProgress,
  }) async {
    final Either<Failure, Unit>? failure = _fail('reset:${provider.value}');
    if (failure != null) return failure;
    backups.add(backupAt);
    onBackedUp?.call();
    progress.forEach(onProgress ?? (_) {});
    files[provider] = content;
    return const Right(unit);
  }

  @override
  Future<Either<Failure, String?>> detachVault(
    ProviderId provider,
    String accessToken,
  ) async {
    final Either<Failure, String?>? failure = _fail('detach:${provider.value}');
    if (failure != null) return failure;
    final bool had = files[provider] != null;
    files[provider] = null;
    return Right(had ? detachedName : null);
  }

  @override
  Future<Either<Failure, VaultFileInfo?>> newerVersion(
    ProviderId provider,
    String accessToken,
  ) async {
    final Either<Failure, VaultFileInfo?>? failure = _fail(
      'newer:${provider.value}',
    );
    await holdNewer?.future;
    return failure ?? Right(newer[provider]);
  }
}

/// Encryption without Argon2: the "file" is readable JSON that only opens
/// with its own secret.
class FakeVaultCipher implements VaultCipher {
  @override
  Future<String> encrypt(String secret, Object? data) async =>
      jsonEncode(<String, Object?>{'secret': secret, 'data': data});

  @override
  Future<Either<Failure, Object?>> decrypt(String secret, String stored) async {
    final Object? json = jsonDecode(stored);
    if (json is! Map<String, dynamic> || !json.containsKey('secret')) {
      return const Left(Failure.corruptVault());
    }
    if (json['secret'] != secret) return const Left(Failure.wrongSecret());
    return Right(json['data']);
  }

  @override
  Future<Either<Failure, VaultSnapshot>> open(
    String secret,
    String stored,
  ) async {
    final Either<Failure, Object?> data = await decrypt(secret, stored);
    return data.map(
      (Object? json) => VaultSnapshot.fromJson(json! as Map<String, dynamic>),
    );
  }
}

/// Counts encryptions, so tests see Try again reuse the vault already encrypted.
class CountingCipher extends FakeVaultCipher {
  int encryptions = 0;

  @override
  Future<String> encrypt(String secret, Object? data) {
    encryptions++;
    return super.encrypt(secret, data);
  }
}

/// A [SessionCubit] over real use cases and the fakes above.
SessionCubit buildSessionCubit(
  FakeAuthRepository auth,
  FakeStorageRepository storage,
  VaultSessionService vault, {
  LockService? lock,
}) {
  final FakeVaultCipher cipher = FakeVaultCipher();
  return SessionCubit(
    RestoreSession(auth),
    GetAvailableProviders(auth),
    SignIn(auth, lock ?? LockService()),
    CheckVault(auth, storage),
    UnlockVault(auth, storage, cipher, vault),
    LockVault(vault),
    SignOut(auth, vault),
    ArchiveVault(auth, storage, vault),
    MarkSessionExpired(auth, vault),
    RefreshProfile(auth),
  );
}
