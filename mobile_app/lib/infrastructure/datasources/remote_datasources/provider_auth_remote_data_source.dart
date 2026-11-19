import 'package:dartz/dartz.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/models/auth/token_grant.dart';

/// The sign-in half of a provider (web `AuthProvider`).
abstract class ProviderAuthRemoteDataSource {
  ProviderId get provider;

  /// Whether this build has what the provider needs (its client ID); an
  /// unconfigured provider is not offered (web `isConfigured`, X7).
  bool get isConfigured;

  /// Interactive: the provider's own page or sheet. Closing it returns
  /// [Failure.signInCancelled].
  Future<Either<Failure, ProviderSignIn>> signIn();

  /// A fresh grant without any UI, or [Failure.storageAuthExpired] when that
  /// is not possible.
  Future<Either<Failure, TokenGrant>> renew(TokenGrant? current);

  Future<Either<Failure, ProviderProfile>> fetchProfile(String accessToken);

  /// Drops [accessToken] from the provider's own cache after a call refused
  /// it, so the next renewal fetches a new one.
  Future<void> forgetToken(String accessToken);

  /// Forgets the provider's own sign-in on this phone.
  Future<void> signOut();
}
