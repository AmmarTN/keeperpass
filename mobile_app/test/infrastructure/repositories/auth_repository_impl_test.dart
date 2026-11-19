import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/infrastructure/datasources/local_datasources/session_local_data_source.dart';
import 'package:keeperpass/infrastructure/datasources/remote_datasources/dropbox_auth_remote_data_source.dart';
import 'package:keeperpass/infrastructure/datasources/remote_datasources/google_auth_remote_data_source.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/models/auth/token_grant.dart';
import 'package:keeperpass/infrastructure/repositories/auth_repository_impl.dart';

class FakeProviderAuth
    implements GoogleAuthRemoteDataSource, DropboxAuthRemoteDataSource {
  FakeProviderAuth(this.provider);

  @override
  final ProviderId provider;
  bool configured = true;
  String email = 'jane@example.com';
  final List<String> calls = <String>[];
  final List<Either<Failure, TokenGrant>> renewals =
      <Either<Failure, TokenGrant>>[];
  Completer<void>? renewGate;

  @override
  bool get isConfigured => configured;

  @override
  Future<Either<Failure, ProviderSignIn>> signIn() async {
    calls.add('signIn');
    return Right(
      ProviderSignIn(
        provider: provider,
        grant: TokenGrant(
          accessToken: 'signed-in',
          refreshToken: provider == ProviderId.dropbox ? 'refresh' : null,
        ),
        profile: ProviderProfile(email: email, name: 'Jane'),
      ),
    );
  }

  @override
  Future<Either<Failure, TokenGrant>> renew(TokenGrant? current) async {
    calls.add('renew:${current?.refreshToken}');
    await renewGate?.future;
    return renewals.isEmpty
        ? const Right(TokenGrant(accessToken: 'renewed'))
        : renewals.removeAt(0);
  }

  @override
  Future<Either<Failure, ProviderProfile>> fetchProfile(
    String accessToken,
  ) async => Right(ProviderProfile(email: email, name: 'Jane D.'));

  @override
  Future<void> forgetToken(String accessToken) async =>
      calls.add('forget:$accessToken');

  @override
  Future<void> signOut() async => calls.add('signOut');
}

class FakeSessionLocal implements ISessionLocalDataSource {
  RememberedSession? stored;

  @override
  Future<void> clear() async => stored = null;

  @override
  Future<RememberedSession?> read() async => stored;

  @override
  Future<void> write(RememberedSession session) async => stored = session;
}

class FakeSecureStorage extends Fake implements FlutterSecureStorage {
  final Map<String, String> values = <String, String>{};

  @override
  Future<Map<String, String>> readAll({
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async => Map<String, String>.of(values);

  @override
  Future<void> write({
    required String key,
    required String? value,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    if (value == null) {
      values.remove(key);
    } else {
      values[key] = value;
    }
  }

  @override
  Future<void> delete({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async => values.remove(key);
}

void main() {
  late FakeProviderAuth google;
  late FakeProviderAuth dropbox;
  late FakeSessionLocal local;
  late DateTime now;
  late AuthRepositoryImpl repository;

  setUp(() {
    google = FakeProviderAuth(ProviderId.google);
    dropbox = FakeProviderAuth(ProviderId.dropbox);
    local = FakeSessionLocal();
    now = DateTime.utc(2026, 10, 30, 12);
    repository = AuthRepositoryImpl(google, dropbox, local, now: () => now);
  });

  test('offers only configured providers, Google first (X7)', () {
    expect(repository.availableProviders(), <ProviderId>[
      ProviderId.google,
      ProviderId.dropbox,
    ]);
    google.configured = false;
    expect(repository.availableProviders(), <ProviderId>[ProviderId.dropbox]);
  });

  test('a sign-in is remembered on the phone, never a secret (D10)', () async {
    await repository.signIn(ProviderId.dropbox);

    expect(
      local.stored,
      const RememberedSession(
        account: ProviderAccount(
          provider: ProviderId.dropbox,
          email: 'jane@example.com',
          name: 'Jane',
        ),
        refreshToken: 'refresh',
      ),
    );
  });

  test('a remembered session renews silently on its first call', () async {
    local.stored = const RememberedSession(
      account: ProviderAccount(provider: ProviderId.dropbox, email: 'a@b.c'),
      refreshToken: 'refresh',
    );
    await repository.restoreSession();

    final Either<Failure, String> token = await repository.authorized(
      (String token) async => Right<Failure, String>(token),
    );

    expect(token, const Right<Failure, String>('renewed'));
    expect(dropbox.calls, <String>['renew:refresh']);
  });

  test('an expired remembered session is not made current', () async {
    local.stored = const RememberedSession(
      account: ProviderAccount(provider: ProviderId.google, email: 'a@b.c'),
      expired: true,
    );
    final Either<Failure, RememberedSession?> restored = await repository
        .restoreSession();
    expect(restored.getOrElse(() => null)?.expired, isTrue);
    expect(repository.account, isNull);
  });

  test(
    'a refused token is dropped, renewed silently, and the call runs once more',
    () async {
      await repository.signIn(ProviderId.google);
      final List<String> tokens = <String>[];

      final Either<Failure, String> result = await repository.authorized((
        String token,
      ) async {
        tokens.add(token);
        return tokens.length == 1
            ? const Left<Failure, String>(
                Failure.storageAuthExpired(ProviderId.google),
              )
            : const Right<Failure, String>('ok');
      });

      expect(result, const Right<Failure, String>('ok'));
      expect(tokens, <String>['signed-in', 'renewed']);
      expect(google.calls, <String>[
        'signIn',
        'forget:signed-in',
        'renew:null',
      ]);
    },
  );

  test('when renewal is impossible the session is expired', () async {
    await repository.signIn(ProviderId.google);
    google.renewals.add(
      const Left(Failure.storageAuthExpired(ProviderId.google)),
    );
    final Either<Failure, String> result = await repository.authorized(
      (String token) async => const Left<Failure, String>(
        Failure.storageAuthExpired(ProviderId.google),
      ),
    );
    expect(
      result,
      const Left<Failure, String>(
        Failure.storageAuthExpired(ProviderId.google),
      ),
    );
  });

  test(
    'a token past its expiry renews first; concurrent calls share it',
    () async {
      await repository.signIn(ProviderId.dropbox);
      now = now.add(const Duration(days: 1));
      // The signed-in grant had no expiry; give it one that has passed.
      dropbox.renewals.add(
        Right(
          TokenGrant(
            accessToken: 'short',
            expiresAt: now.subtract(const Duration(seconds: 1)),
            refreshToken: 'refresh',
          ),
        ),
      );
      await repository.authorized(
        (String t) async => const Left<Failure, String>(
          Failure.storageAuthExpired(ProviderId.dropbox),
        ),
      );
      dropbox.calls.clear();
      dropbox.renewGate = Completer<void>();

      final Future<Either<Failure, String>> a = repository.authorized(
        (String token) async => Right<Failure, String>(token),
      );
      final Future<Either<Failure, String>> b = repository.authorized(
        (String token) async => Right<Failure, String>(token),
      );
      dropbox.renewGate!.complete();

      expect(await a, const Right<Failure, String>('renewed'));
      expect(await b, const Right<Failure, String>('renewed'));
      expect(dropbox.calls, <String>['renew:refresh']);
    },
  );

  test('reconnect with another account is refused and forgotten', () async {
    await repository.signIn(ProviderId.google);
    google.email = 'someone.else@example.com';

    final Either<Failure, ProviderAccount> result = await repository
        .reconnect();

    expect(
      result,
      const Left<Failure, ProviderAccount>(
        Failure.accountMismatch('jane@example.com'),
      ),
    );
    expect(google.calls.last, 'signOut');
    expect(repository.account?.email, 'jane@example.com');
  });

  test('reconnect with the same account restores the session', () async {
    await repository.signIn(ProviderId.google);
    google.email = 'JANE@example.com';
    expect((await repository.reconnect()).isRight(), isTrue);
  });

  test('an expired session keeps only who to greet', () async {
    await repository.signIn(ProviderId.dropbox);
    await repository.markExpired();

    expect(repository.account, isNull);
    expect(local.stored?.expired, isTrue);
    expect(local.stored?.refreshToken, isNull);
    expect(local.stored?.account.email, 'jane@example.com');
  });

  test('signing out forgets everything', () async {
    await repository.signIn(ProviderId.google);
    await repository.signOut();

    expect(repository.account, isNull);
    expect(local.stored, isNull);
    expect(google.calls.last, 'signOut');
  });

  test('the remembered sign-in round-trips through secure storage', () async {
    final FakeSecureStorage storage = FakeSecureStorage();
    final SessionLocalDataSourceImpl source = SessionLocalDataSourceImpl(
      storage,
    );
    const RememberedSession session = RememberedSession(
      account: ProviderAccount(
        provider: ProviderId.dropbox,
        email: 'jane@example.com',
        name: 'Jane',
      ),
      refreshToken: 'refresh',
    );

    await source.write(session);
    expect(await source.read(), session);
    await source.write(session.copyWith(refreshToken: null, expired: true));
    expect(storage.values.containsKey('session_refresh_token'), isFalse);
    expect((await source.read())?.expired, isTrue);
    await source.clear();
    expect(storage.values, isEmpty);
    expect(await source.read(), isNull);

    storage.values['session_provider'] = 'unknown-provider';
    storage.values['session_email'] = 'a@b.c';
    expect(await source.read(), isNull);
  });
}
