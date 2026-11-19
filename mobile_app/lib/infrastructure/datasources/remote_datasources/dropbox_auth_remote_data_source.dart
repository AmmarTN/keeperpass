import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/app.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/network_failure.dart';
import 'package:keeperpass/infrastructure/datasources/remote_datasources/provider_auth_remote_data_source.dart';
import 'package:keeperpass/infrastructure/datasources/remote_datasources/vault_storage_remote_data_source.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/models/auth/token_grant.dart';

/// Dropbox sign-in: Authorization Code + PKCE in the system browser sheet
/// (AppAuth generates the verifier and the S256 challenge), the web's scopes,
/// and a refresh token for silent renewal (web `dropbox-oauth.ts`,
/// `dropbox-auth.provider.ts`; X6).
abstract class DropboxAuthRemoteDataSource
    implements ProviderAuthRemoteDataSource {}

@Singleton(as: DropboxAuthRemoteDataSource)
class DropboxAuthRemoteDataSourceImpl implements DropboxAuthRemoteDataSource {
  DropboxAuthRemoteDataSourceImpl(
    this._appAuth,
    this._dio,
    this._config, {
    @ignoreParam this._now = DateTime.now,
  });

  final FlutterAppAuth _appAuth;
  final Dio _dio;
  final AppConfig _config;
  final DateTime Function() _now;

  static const String authorizeUrl = 'https://www.dropbox.com/oauth2/authorize';
  static const String tokenUrl = 'https://api.dropboxapi.com/oauth2/token';
  static const String _currentAccountUrl =
      'https://api.dropboxapi.com/2/users/get_current_account';

  /// Where Dropbox sends the person back to; must be registered, exactly, in
  /// the Dropbox App Console (X6).
  static const String redirectUrl = 'com.keeperpass.mobile:/oauth/dropbox';

  /// `account_info.read` is the profile; the file scopes are the vault.
  static const List<String> scopes = <String>[
    'account_info.read',
    'files.metadata.read',
    'files.metadata.write',
    'files.content.read',
    'files.content.write',
  ];

  /// Treat a token as expired slightly early (web `EXPIRY_SKEW_MS`).
  static const Duration expirySkew = Duration(seconds: 60);

  /// Dropbox's documented default when `expires_in` is missing.
  static const Duration defaultLifetime = Duration(hours: 4);

  @override
  ProviderId get provider => ProviderId.dropbox;

  @override
  bool get isConfigured => _config.dropboxAppKey.isNotEmpty;

  @override
  Future<Either<Failure, ProviderSignIn>> signIn() async {
    if (!isConfigured) {
      return const Left(Failure.signInFailed(ProviderId.dropbox));
    }
    final AuthorizationTokenResponse response;
    try {
      response = await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          _config.dropboxAppKey,
          redirectUrl,
          serviceConfiguration: const AuthorizationServiceConfiguration(
            authorizationEndpoint: authorizeUrl,
            tokenEndpoint: tokenUrl,
          ),
          scopes: scopes,
          additionalParameters: const <String, String>{
            'token_access_type': 'offline',
          },
        ),
      );
    } on FlutterAppAuthUserCancelledException {
      return const Left(Failure.signInCancelled());
    } on FlutterAppAuthPlatformException catch (error) {
      return Left(
        Failure.signInFailed(
          ProviderId.dropbox,
          message: error.platformErrorDetails.errorDescription,
        ),
      );
    }

    final String? accessToken = response.accessToken;
    if (accessToken == null) {
      return const Left(Failure.signInFailed(ProviderId.dropbox));
    }
    final DateTime expiry =
        response.accessTokenExpirationDateTime ?? _now().add(defaultLifetime);
    final TokenGrant grant = TokenGrant(
      accessToken: accessToken,
      expiresAt: expiry.subtract(expirySkew),
      refreshToken: response.refreshToken,
    );
    final Either<Failure, ProviderProfile> profile = await fetchProfile(
      accessToken,
    );
    return profile.map(
      (ProviderProfile profile) => ProviderSignIn(
        provider: ProviderId.dropbox,
        grant: grant,
        profile: profile,
      ),
    );
  }

  /// A fresh access token from the refresh token: silent, no browser.
  @override
  Future<Either<Failure, TokenGrant>> renew(TokenGrant? current) async {
    const Failure expired = Failure.storageAuthExpired(ProviderId.dropbox);
    final String? refreshToken = current?.refreshToken;
    if (refreshToken == null || refreshToken.isEmpty) {
      return const Left(expired);
    }
    try {
      final Response<String> response = await _dio.request<String>(
        tokenUrl,
        data: utf8.encode(
          Uri(
            queryParameters: <String, String>{
              'grant_type': 'refresh_token',
              'refresh_token': refreshToken,
              'client_id': _config.dropboxAppKey,
            },
          ).query,
        ),
        options: rawOptions(
          'POST',
          headers: <String, Object>{
            'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
          },
        ),
      );
      final Object? json = tryDecodeJson(response.data);
      if (!isOk(response) ||
          json is! Map<String, dynamic> ||
          json['access_token'] is! String) {
        return const Left(expired);
      }
      return Right(_toGrant(json, refreshToken));
    } on DioException catch (error) {
      return Left(
        Failure.networkFailure(NetworkFailure.getDioException(error)),
      );
    }
  }

  TokenGrant _toGrant(Map<String, dynamic> json, String previousRefreshToken) {
    final Object? expiresIn = json['expires_in'];
    final Duration lifetime = expiresIn is num && expiresIn > 0
        ? Duration(milliseconds: (expiresIn * 1000).round())
        : defaultLifetime;
    final Object? refreshToken = json['refresh_token'];
    return TokenGrant(
      accessToken: json['access_token'] as String,
      expiresAt: _now().add(lifetime).subtract(expirySkew),
      // A refresh response carries no new refresh token — the old one stays.
      refreshToken: refreshToken is String
          ? refreshToken
          : previousRefreshToken,
    );
  }

  /// No body and no Content-Type: Dropbox rejects this endpoint otherwise.
  @override
  Future<Either<Failure, ProviderProfile>> fetchProfile(
    String accessToken,
  ) async {
    try {
      final Response<String> response = await _dio.request<String>(
        _currentAccountUrl,
        options: rawOptions(
          'POST',
          headers: <String, Object>{'Authorization': 'Bearer $accessToken'},
        ),
      );
      final Object? json = tryDecodeJson(response.data);
      if (!isOk(response) ||
          json is! Map<String, dynamic> ||
          json['email'] is! String) {
        return const Left(Failure.profileFailed(ProviderId.dropbox));
      }
      final Object? name = json['name'];
      final Object? displayName = name is Map<String, dynamic>
          ? name['display_name']
          : null;
      return Right(
        ProviderProfile(
          email: json['email'] as String,
          name: displayName is String ? displayName : '',
        ),
      );
    } on DioException catch (error) {
      return Left(
        Failure.networkFailure(NetworkFailure.getDioException(error)),
      );
    }
  }

  /// Dropbox tokens are not cached by an SDK; nothing to clear.
  @override
  Future<void> forgetToken(String accessToken) async {}

  /// The web forgets the tokens without revoking them; so does the app (the
  /// repository deletes the stored refresh token).
  @override
  Future<void> signOut() async {}
}
