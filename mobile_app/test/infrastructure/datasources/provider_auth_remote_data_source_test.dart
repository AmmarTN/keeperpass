import 'package:dartz/dartz.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:keeperpass/core/app.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/network_failure.dart';
import 'package:keeperpass/infrastructure/datasources/remote_datasources/dropbox_auth_remote_data_source.dart';
import 'package:keeperpass/infrastructure/datasources/remote_datasources/google_auth_remote_data_source.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/models/auth/token_grant.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/fake_http.dart';

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockGoogleAccount extends Mock implements GoogleSignInAccount {}

class MockAuthorizationClient extends Mock
    implements GoogleSignInAuthorizationClient {}

class MockAppAuth extends Mock implements FlutterAppAuth {}

AppConfig config({
  String android = 'android-client',
  String web = 'web-client',
  String dropbox = 'app-key',
}) => AppConfig(
  environment: AppEnvironment.development,
  appName: 'KeeperPass',
  googleWebClientId: web,
  googleAndroidClientId: android,
  googleIosClientId: '',
  dropboxAppKey: dropbox,
);

void main() {
  setUpAll(() {
    registerFallbackValue(
      AuthorizationTokenRequest('k', 'r', issuer: 'https://fallback.example'),
    );
  });

  group('Google (google_sign_in 7, web google-auth.provider.ts)', () {
    late MockGoogleSignIn google;
    late MockGoogleAccount account;
    late MockAuthorizationClient authorization;
    late FakeHttpAdapter http;
    late GoogleAuthRemoteDataSourceImpl source;

    setUp(() {
      google = MockGoogleSignIn();
      account = MockGoogleAccount();
      authorization = MockAuthorizationClient();
      http = FakeHttpAdapter();
      source = GoogleAuthRemoteDataSourceImpl(google, fakeDio(http), config());
      when(
        () => google.initialize(
          clientId: any(named: 'clientId'),
          serverClientId: any(named: 'serverClientId'),
        ),
      ).thenAnswer((_) async {});
      when(() => account.authorizationClient).thenReturn(authorization);
    });

    test('hidden until the mobile client IDs exist (X7)', () {
      expect(source.isConfigured, isTrue);
      expect(
        GoogleAuthRemoteDataSourceImpl(
          google,
          fakeDio(http),
          config(android: ''),
        ).isConfigured,
        isFalse,
      );
    });

    test('signs in with the web scopes and reads the profile', () async {
      when(
        () => google.authenticate(scopeHint: any(named: 'scopeHint')),
      ).thenAnswer((_) async => account);
      when(() => authorization.authorizeScopes(any())).thenAnswer(
        (_) async => const GoogleSignInClientAuthorization(accessToken: 'tok'),
      );
      http.replyJson(200, <String, String>{
        'email': 'jane@example.com',
        'name': 'Jane Doe',
      });

      final Either<Failure, ProviderSignIn> result = await source.signIn();

      expect(
        result,
        const Right<Failure, ProviderSignIn>(
          ProviderSignIn(
            provider: ProviderId.google,
            grant: TokenGrant(accessToken: 'tok'),
            profile: ProviderProfile(
              email: 'jane@example.com',
              name: 'Jane Doe',
            ),
          ),
        ),
      );
      verify(() => google.initialize(serverClientId: 'web-client')).called(1);
      verify(
        () => authorization.authorizeScopes(<String>[
          'openid',
          'email',
          'profile',
          'https://www.googleapis.com/auth/drive.file',
        ]),
      ).called(1);
      expect(
        http.requests.single.uri.toString(),
        'https://www.googleapis.com/oauth2/v3/userinfo',
      );
      expect(http.requests.single.header('authorization'), 'Bearer tok');
    });

    test('closing Google’s sheet is a cancellation', () async {
      when(
        () => google.authenticate(scopeHint: any(named: 'scopeHint')),
      ).thenThrow(
        const GoogleSignInException(code: GoogleSignInExceptionCode.canceled),
      );
      expect(
        await source.signIn(),
        const Left<Failure, ProviderSignIn>(Failure.signInCancelled()),
      );
    });

    test('renews silently, or reports the session expired', () async {
      when(
        google.attemptLightweightAuthentication,
      ).thenAnswer((_) async => null);
      expect(
        await source.renew(null),
        const Left<Failure, TokenGrant>(
          Failure.storageAuthExpired(ProviderId.google),
        ),
      );

      when(
        google.attemptLightweightAuthentication,
      ).thenAnswer((_) async => account);
      when(() => authorization.authorizationForScopes(any())).thenAnswer(
        (_) async =>
            const GoogleSignInClientAuthorization(accessToken: 'tok-2'),
      );
      expect(
        await source.renew(null),
        const Right<Failure, TokenGrant>(TokenGrant(accessToken: 'tok-2')),
      );
    });
  });

  group('Dropbox (AppAuth + PKCE, web dropbox-oauth.ts)', () {
    late MockAppAuth appAuth;
    late FakeHttpAdapter http;
    late DropboxAuthRemoteDataSourceImpl source;
    final DateTime now = DateTime.utc(2026, 10, 30, 12);

    setUp(() {
      appAuth = MockAppAuth();
      http = FakeHttpAdapter();
      source = DropboxAuthRemoteDataSourceImpl(
        appAuth,
        fakeDio(http),
        config(),
        now: () => now,
      );
    });

    test('signs in in the browser sheet with the web scopes', () async {
      final DateTime expiry = now.add(const Duration(hours: 4));
      when(() => appAuth.authorizeAndExchangeCode(any())).thenAnswer(
        (_) async => AuthorizationTokenResponse(
          'access',
          'refresh',
          expiry,
          null,
          'bearer',
          null,
          null,
          null,
        ),
      );
      http.replyJson(200, <String, Object>{
        'email': 'jane@example.com',
        'name': <String, String>{'display_name': 'Jane Doe'},
      });

      final Either<Failure, ProviderSignIn> result = await source.signIn();

      expect(
        result,
        Right<Failure, ProviderSignIn>(
          ProviderSignIn(
            provider: ProviderId.dropbox,
            grant: TokenGrant(
              accessToken: 'access',
              expiresAt: expiry.subtract(const Duration(seconds: 60)),
              refreshToken: 'refresh',
            ),
            profile: const ProviderProfile(
              email: 'jane@example.com',
              name: 'Jane Doe',
            ),
          ),
        ),
      );
      final AuthorizationTokenRequest request =
          verify(
                () => appAuth.authorizeAndExchangeCode(captureAny()),
              ).captured.single
              as AuthorizationTokenRequest;
      expect(request.clientId, 'app-key');
      expect(request.redirectUrl, 'com.keeperpass.mobile:/oauth/dropbox');
      expect(request.scopes, <String>[
        'account_info.read',
        'files.metadata.read',
        'files.metadata.write',
        'files.content.read',
        'files.content.write',
      ]);
      expect(request.additionalParameters, <String, String>{
        'token_access_type': 'offline',
      });
      // No body and no Content-Type: Dropbox rejects them on this endpoint.
      expect(http.requests.single.body, isEmpty);
      expect(http.requests.single.header('content-type'), isNull);
    });

    test('closing the sheet is a cancellation', () async {
      when(() => appAuth.authorizeAndExchangeCode(any())).thenThrow(
        FlutterAppAuthUserCancelledException(
          code: 'authorize_and_exchange_code_failed',
          platformErrorDetails: FlutterAppAuthPlatformErrorDetails(),
        ),
      );
      expect(
        await source.signIn(),
        const Left<Failure, ProviderSignIn>(Failure.signInCancelled()),
      );
    });

    test('renews from the refresh token, which it keeps', () async {
      http.replyJson(200, <String, Object>{
        'access_token': 'fresh',
        'expires_in': 14400,
      });

      final Either<Failure, TokenGrant> result = await source.renew(
        const TokenGrant(accessToken: 'old', refreshToken: 'refresh'),
      );

      expect(
        result,
        Right<Failure, TokenGrant>(
          TokenGrant(
            accessToken: 'fresh',
            expiresAt: now.add(const Duration(hours: 4, seconds: -60)),
            refreshToken: 'refresh',
          ),
        ),
      );
      expect(Uri.splitQueryString(http.requests.single.text), <String, String>{
        'grant_type': 'refresh_token',
        'refresh_token': 'refresh',
        'client_id': 'app-key',
      });
    });

    test('a refused refresh is an expiry; no connection is not', () async {
      expect(
        await source.renew(const TokenGrant(accessToken: 'old')),
        const Left<Failure, TokenGrant>(
          Failure.storageAuthExpired(ProviderId.dropbox),
        ),
      );
      http.replyJson(400, <String, String>{'error': 'invalid_grant'});
      expect(
        await source.renew(
          const TokenGrant(accessToken: 'old', refreshToken: 'revoked'),
        ),
        const Left<Failure, TokenGrant>(
          Failure.storageAuthExpired(ProviderId.dropbox),
        ),
      );
      http.replyOffline();
      expect(
        await source.renew(
          const TokenGrant(accessToken: 'old', refreshToken: 'refresh'),
        ),
        const Left<Failure, TokenGrant>(
          Failure.networkFailure(NetworkFailure.noInternetConnection()),
        ),
      );
    });
  });
}
