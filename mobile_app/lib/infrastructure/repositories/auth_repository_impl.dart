import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/debug/logger.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/infrastructure/datasources/local_datasources/session_local_data_source.dart';
import 'package:keeperpass/infrastructure/datasources/remote_datasources/dropbox_auth_remote_data_source.dart';
import 'package:keeperpass/infrastructure/datasources/remote_datasources/google_auth_remote_data_source.dart';
import 'package:keeperpass/infrastructure/datasources/remote_datasources/provider_auth_remote_data_source.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/models/auth/token_grant.dart';

abstract class IAuthRepository {
  /// The providers sign-in offers: registered and configured in this build
  /// (web `ProviderRegistry.available`).
  List<ProviderId> availableProviders();

  /// The account the current session signed in with; null when signed out.
  ProviderAccount? get account;

  /// The sign-in remembered on this phone (D10), made current unless it had
  /// expired. Null when there is none.
  Future<Either<Failure, RememberedSession?>> restoreSession();

  /// Interactive sign-in; the session and the phone then remember it.
  Future<Either<Failure, ProviderAccount>> signIn(ProviderId provider);

  /// Interactive sign-in again for the current session's account after it
  /// expired. A different account is refused with [Failure.accountMismatch]
  /// and nothing changes.
  Future<Either<Failure, ProviderAccount>> reconnect();

  /// Interactive sign-in to another provider for one vault move; never put
  /// on the session (web `VaultMigrationService.connect`).
  Future<Either<Failure, ProviderSignIn>> signInElsewhere(ProviderId provider);

  /// Runs [call] with a fresh access token. A call refused as expired drops
  /// the token, renews silently and runs once more; if that cannot be done
  /// the result is [Failure.storageAuthExpired].
  Future<Either<Failure, T>> authorized<T>(
    Future<Either<Failure, T>> Function(String accessToken) call,
  );

  /// Re-reads the name and address for the current session (web
  /// `AuthService.fetchProfile`).
  Future<Either<Failure, ProviderAccount>> refreshProfile();

  /// The session cannot be renewed: tokens are dropped, and the phone keeps
  /// the account only to greet the person (board `U2-Connect`).
  Future<Either<Failure, Unit>> markExpired();

  /// Forgets the sign-in on this phone (log out, "Use another account").
  Future<Either<Failure, Unit>> signOut();
}

@Singleton(as: IAuthRepository)
class AuthRepositoryImpl implements IAuthRepository {
  AuthRepositoryImpl(
    GoogleAuthRemoteDataSource google,
    DropboxAuthRemoteDataSource dropbox,
    this._local, {
    @ignoreParam this._now = DateTime.now,
  }) : _providers = <ProviderId, ProviderAuthRemoteDataSource>{
         ProviderId.google: google,
         ProviderId.dropbox: dropbox,
       };

  final Map<ProviderId, ProviderAuthRemoteDataSource> _providers;
  final ISessionLocalDataSource _local;
  final DateTime Function() _now;

  ProviderAccount? _account;
  TokenGrant? _grant;

  /// In-flight renewal, so concurrent calls share one request (web
  /// `AuthService.renewal`).
  Future<Either<Failure, String>>? _renewal;

  @override
  ProviderAccount? get account => _account;

  @override
  List<ProviderId> availableProviders() => <ProviderId>[
    for (final ProviderId id in ProviderId.values)
      if (_providers[id]!.isConfigured) id,
  ];

  @override
  Future<Either<Failure, RememberedSession?>> restoreSession() async {
    final RememberedSession? session;
    try {
      session = await _local.read();
    } on Object catch (error) {
      logger.w('Could not read the remembered sign-in: ${error.runtimeType}');
      return const Left(Failure.cacheReadFailure());
    }
    if (session != null && !session.expired) {
      _account = session.account;
      // No access token yet: the first call renews silently.
      _grant = TokenGrant(accessToken: '', refreshToken: session.refreshToken);
    }
    return Right(session);
  }

  @override
  Future<Either<Failure, ProviderAccount>> signIn(ProviderId provider) async {
    final Either<Failure, ProviderSignIn> result = await _providers[provider]!
        .signIn();
    return result.fold(Left.new, (ProviderSignIn signIn) async {
      final ProviderAccount account = ProviderAccount(
        provider: provider,
        email: signIn.profile.email,
        name: signIn.profile.name,
      );
      _account = account;
      _grant = signIn.grant;
      await _remember(
        RememberedSession(
          account: account,
          refreshToken: signIn.grant.refreshToken,
        ),
      );
      return Right(account);
    });
  }

  @override
  Future<Either<Failure, ProviderAccount>> reconnect() async {
    final ProviderAccount? current = _account;
    if (current == null) return const Left(Failure.accessTokenFailure());
    final ProviderAuthRemoteDataSource provider = _providers[current.provider]!;
    final Either<Failure, ProviderSignIn> result = await provider.signIn();
    return result.fold(Left.new, (ProviderSignIn signIn) async {
      if (!_sameAddress(signIn.profile.email, current.email)) {
        // The SDK now holds the other account; forget it so a silent renewal
        // can never hand out that account's token for this vault.
        await provider.signOut();
        return Left(Failure.accountMismatch(current.email));
      }
      final ProviderAccount account = current.copyWith(
        name: signIn.profile.name,
      );
      _account = account;
      _grant = signIn.grant;
      await _remember(
        RememberedSession(
          account: account,
          refreshToken: signIn.grant.refreshToken,
        ),
      );
      return Right(account);
    });
  }

  @override
  Future<Either<Failure, ProviderSignIn>> signInElsewhere(
    ProviderId provider,
  ) => _providers[provider]!.signIn();

  @override
  Future<Either<Failure, T>> authorized<T>(
    Future<Either<Failure, T>> Function(String accessToken) call,
  ) async {
    final Either<Failure, String> token = await _freshToken();
    return token.fold(Left.new, (String accessToken) async {
      final Either<Failure, T> result = await call(accessToken);
      if (!_isExpired(result)) return result;

      // Refused: drop the token, renew silently, try once more.
      await _providers[_account?.provider]?.forgetToken(accessToken);
      _grant = _grant?.copyWith(accessToken: '');
      final Either<Failure, String> retry = await _freshToken();
      return retry.fold(Left.new, call);
    });
  }

  @override
  Future<Either<Failure, ProviderAccount>> refreshProfile() async {
    final ProviderAccount? current = _account;
    if (current == null) return const Left(Failure.accessTokenFailure());
    final Either<Failure, ProviderProfile> result = await authorized(
      _providers[current.provider]!.fetchProfile,
    );
    return result.fold(Left.new, (ProviderProfile profile) async {
      final ProviderAccount account = current.copyWith(
        email: profile.email,
        name: profile.name,
      );
      _account = account;
      await _remember(
        RememberedSession(account: account, refreshToken: _grant?.refreshToken),
      );
      return Right(account);
    });
  }

  @override
  Future<Either<Failure, Unit>> markExpired() async {
    final ProviderAccount? current = _account;
    _account = null;
    _grant = null;
    if (current == null) return const Right(unit);
    try {
      await _local.write(RememberedSession(account: current, expired: true));
      return const Right(unit);
    } on Object {
      return const Left(Failure.cacheWriteFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    final ProviderAccount? current = _account;
    _account = null;
    _grant = null;
    if (current != null) await _providers[current.provider]!.signOut();
    try {
      await _local.clear();
      return const Right(unit);
    } on Object {
      return const Left(Failure.cacheWriteFailure());
    }
  }

  /// The current access token, renewed first when missing or at its expiry.
  Future<Either<Failure, String>> _freshToken() {
    final ProviderAccount? current = _account;
    if (current == null) {
      return Future<Either<Failure, String>>.value(
        const Left(Failure.accessTokenFailure()),
      );
    }
    final TokenGrant? grant = _grant;
    if (grant != null &&
        grant.accessToken.isNotEmpty &&
        !grant.isExpiredAt(_now())) {
      return Future<Either<Failure, String>>.value(Right(grant.accessToken));
    }
    return _renewal ??= _renew(current).whenComplete(() => _renewal = null);
  }

  Future<Either<Failure, String>> _renew(ProviderAccount account) async {
    final TokenGrant? previous = _grant;
    final Either<Failure, TokenGrant> result =
        await _providers[account.provider]!.renew(previous);
    return result.fold(Left.new, (TokenGrant grant) async {
      // A renewal without a new refresh token keeps the old one.
      final TokenGrant renewed = grant.refreshToken == null
          ? grant.copyWith(refreshToken: previous?.refreshToken)
          : grant;
      if (!identical(_account, account)) return Right(renewed.accessToken);
      _grant = renewed;
      if (renewed.refreshToken != previous?.refreshToken) {
        await _remember(
          RememberedSession(
            account: account,
            refreshToken: renewed.refreshToken,
          ),
        );
      }
      return Right(renewed.accessToken);
    });
  }

  /// Remembering is best effort: the session works in memory either way.
  Future<void> _remember(RememberedSession session) async {
    try {
      await _local.write(session);
    } on Object catch (error) {
      logger.w('Could not remember the sign-in: ${error.runtimeType}');
    }
  }

  static bool _isExpired<T>(Either<Failure, T> result) => result.fold(
    (Failure failure) => failure is StorageAuthExpired,
    (_) => false,
  );

  static bool _sameAddress(String a, String b) =>
      a.trim().toLowerCase() == b.trim().toLowerCase();
}
