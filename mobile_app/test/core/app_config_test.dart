import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/app.dart';

void main() {
  group('AppConfig', () {
    test('reads every value from the env file', () {
      final AppConfig config = AppConfig.fromEnv(const <String, String>{
        'APP_ENV': 'production',
        'APP_NAME': 'KeeperPass',
        'GOOGLE_WEB_CLIENT_ID': 'web-client',
        'GOOGLE_ANDROID_CLIENT_ID': 'android-client',
        'GOOGLE_IOS_CLIENT_ID': 'ios-client',
        'DROPBOX_APP_KEY': 'dropbox-key',
      });

      expect(config.environment, AppEnvironment.production);
      expect(config.isProduction, isTrue);
      expect(config.appName, 'KeeperPass');
      expect(config.googleWebClientId, 'web-client');
      expect(config.googleAndroidClientId, 'android-client');
      expect(config.googleIosClientId, 'ios-client');
      expect(config.dropboxAppKey, 'dropbox-key');
      expect(config.validationErrors, isEmpty);
    });

    test(
      'empty provider identifiers are not errors — the provider is hidden',
      () {
        final AppConfig config = AppConfig.fromEnv(const <String, String>{
          'APP_NAME': 'KeeperPass',
        });

        expect(config.environment, AppEnvironment.development);
        expect(config.googleIosClientId, isEmpty);
        expect(config.dropboxAppKey, isEmpty);
        expect(config.validationErrors, isEmpty);
      },
    );

    test('reports a missing app name', () {
      final AppConfig config = AppConfig.fromEnv(const <String, String>{
        'APP_NAME': ' ',
      });

      expect(config.validationErrors, hasLength(1));
    });
  });
}
