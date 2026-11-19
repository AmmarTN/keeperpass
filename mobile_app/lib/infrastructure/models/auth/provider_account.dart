import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/infrastructure/models/auth/token_grant.dart';

part 'provider_account.freezed.dart';

/// The signed-in person as the provider reports them (web `ProviderProfile`).
@freezed
abstract class ProviderProfile with _$ProviderProfile {
  const factory ProviderProfile({
    required String email,
    @Default('') String name,
  }) = _ProviderProfile;
}

/// Who the session belongs to: kept on the phone so the app can open the
/// same account after a restart (D10), and greet it when its session expired
/// (board `U2-Connect`, "Welcome back").
@freezed
abstract class ProviderAccount with _$ProviderAccount {
  const ProviderAccount._();

  const factory ProviderAccount({
    required ProviderId provider,
    required String email,
    @Default('') String name,
  }) = _ProviderAccount;

  /// The name, or the address every account has (web `displayName`).
  String get displayName => name.isNotEmpty ? name : email;
}

/// An interactive sign-in's result (web `TokenGrant & ProviderProfile`).
@freezed
abstract class ProviderSignIn with _$ProviderSignIn {
  const factory ProviderSignIn({
    required ProviderId provider,
    required TokenGrant grant,
    required ProviderProfile profile,
  }) = _ProviderSignIn;
}

/// What the phone remembers between launches. The secret is never part of
/// it (D10).
@freezed
abstract class RememberedSession with _$RememberedSession {
  const factory RememberedSession({
    required ProviderAccount account,

    /// Dropbox's; Google's SDK keeps its own sign-in.
    String? refreshToken,

    /// The session could not be renewed: the account is kept only to greet
    /// the person and offer to sign in again.
    @Default(false) bool expired,
  }) = _RememberedSession;
}
