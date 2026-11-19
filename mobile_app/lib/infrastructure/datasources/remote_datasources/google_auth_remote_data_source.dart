import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/app.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/network_failure.dart';
import 'package:keeperpass/infrastructure/datasources/remote_datasources/provider_auth_remote_data_source.dart';
import 'package:keeperpass/infrastructure/datasources/remote_datasources/vault_storage_remote_data_source.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/models/auth/token_grant.dart';

/// Google sign-in through the native SDK (`google_sign_in` 7), with Drive as
/// the storage (web `google-auth.provider.ts`). The SDK keeps the sign-in on
/// the phone (D10); its tokens carry no expiry, so a refused call renews
/// (plan section 3, "Settled earlier").
abstract class GoogleAuthRemoteDataSource
    implements ProviderAuthRemoteDataSource {}

@Singleton(as: GoogleAuthRemoteDataSource)
class GoogleAuthRemoteDataSourceImpl implements GoogleAuthRemoteDataSource {
  GoogleAuthRemoteDataSourceImpl(this._googleSignIn, this._dio, this._config);

  final GoogleSignIn _googleSignIn;
  final Dio _dio;
  final AppConfig _config;
  Future<void>? _initialized;

  /// The web's scopes: sign-in plus `drive.file` (only files this app
  /// creates).
  static const List<String> scopes = <String>[
    'openid',
    'email',
    'profile',
    'https://www.googleapis.com/auth/drive.file',
  ];

  static const String _userInfoUrl =
      'https://www.googleapis.com/oauth2/v3/userinfo';

  /// Bound on a silent renewal (web `RENEWAL_TIMEOUT_MS`).
  static const Duration renewalTimeout = Duration(seconds: 8);

  @override
  ProviderId get provider => ProviderId.google;

  /// iOS needs its own client ID; Android matches its client by package and
  /// signing key and passes the web client as `serverClientId` (O5, X7).
  @override
  bool get isConfigured => switch (defaultTargetPlatform) {
    TargetPlatform.iOS => _config.googleIosClientId.isNotEmpty,
    TargetPlatform.android =>
      _config.googleAndroidClientId.isNotEmpty &&
          _config.googleWebClientId.isNotEmpty,
    _ => false,
  };

  Future<void> _ready() => _initialized ??= _googleSignIn
      .initialize(
        clientId: defaultTargetPlatform == TargetPlatform.iOS
            ? _config.googleIosClientId
            : null,
        serverClientId: defaultTargetPlatform == TargetPlatform.android
            ? _config.googleWebClientId
            : null,
      )
      .catchError((Object error) {
        _initialized = null;
        throw error;
      });

  @override
  Future<Either<Failure, ProviderSignIn>> signIn() async {
    if (!isConfigured) {
      return const Left(Failure.signInFailed(ProviderId.google));
    }
    try {
      await _ready();
      final GoogleSignInAccount account = await _googleSignIn.authenticate(
        scopeHint: scopes,
      );
      final GoogleSignInClientAuthorization authorization = await account
          .authorizationClient
          .authorizeScopes(scopes);
      final TokenGrant grant = TokenGrant(
        accessToken: authorization.accessToken,
      );
      final Either<Failure, ProviderProfile> profile = await fetchProfile(
        grant.accessToken,
      );
      return profile.map(
        (ProviderProfile profile) => ProviderSignIn(
          provider: ProviderId.google,
          grant: grant,
          profile: profile,
        ),
      );
    } on GoogleSignInException catch (error) {
      return Left(switch (error.code) {
        GoogleSignInExceptionCode.canceled ||
        GoogleSignInExceptionCode.interrupted =>
          const Failure.signInCancelled(),
        _ => const Failure.signInFailed(ProviderId.google),
      });
    }
  }

  /// Reuses the phone's Google sign-in without showing anything; fails when
  /// that is not possible (web `renew` with `prompt: ''`).
  @override
  Future<Either<Failure, TokenGrant>> renew(TokenGrant? current) async {
    const Failure expired = Failure.storageAuthExpired(ProviderId.google);
    if (!isConfigured) return const Left(expired);
    try {
      await _ready();
      final GoogleSignInAccount? account =
          await (_googleSignIn.attemptLightweightAuthentication() ??
                  Future<GoogleSignInAccount?>.value())
              .timeout(renewalTimeout);
      if (account == null) return const Left(expired);
      final GoogleSignInClientAuthorization? authorization = await account
          .authorizationClient
          .authorizationForScopes(scopes)
          .timeout(renewalTimeout);
      if (authorization == null) return const Left(expired);
      return Right(TokenGrant(accessToken: authorization.accessToken));
    } on GoogleSignInException {
      return const Left(expired);
    } on TimeoutException {
      return const Left(expired);
    }
  }

  @override
  Future<Either<Failure, ProviderProfile>> fetchProfile(
    String accessToken,
  ) async {
    try {
      final Response<String> response = await _dio.request<String>(
        _userInfoUrl,
        options: rawOptions(
          'GET',
          headers: <String, Object>{'Authorization': 'Bearer $accessToken'},
        ),
      );
      final Object? json = tryDecodeJson(response.data);
      if (!isOk(response) ||
          json is! Map<String, dynamic> ||
          json['email'] is! String) {
        return const Left(Failure.profileFailed(ProviderId.google));
      }
      return Right(
        ProviderProfile(
          email: json['email'] as String,
          name: json['name'] is String ? json['name'] as String : '',
        ),
      );
    } on DioException catch (error) {
      return Left(
        Failure.networkFailure(NetworkFailure.getDioException(error)),
      );
    }
  }

  @override
  Future<void> forgetToken(String accessToken) async {
    try {
      await _googleSignIn.authorizationClient.clearAuthorizationToken(
        accessToken: accessToken,
      );
    } on Object {
      // Best effort: the renewal that follows reports the real outcome.
    }
  }

  @override
  Future<void> signOut() async {
    if (_initialized == null) return;
    try {
      await _googleSignIn.signOut();
    } on Object {
      // Forgetting locally is what matters; the SDK may already be signed out.
    }
  }
}
