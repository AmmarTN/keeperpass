enum AppEnvironment { development, staging, production }

/// Typed configuration read from `assets/env/*.env` (loaded in `main.dart`).
///
/// The OAuth client IDs and the Dropbox app key are public identifiers, the
/// same values the web app ships in `web/src/environments/environment.ts`.
/// A provider whose identifier is empty is simply not offered, exactly like
/// the web's `isConfigured()` — so only the app's own identity is required.
final class AppConfig {
  const AppConfig({
    required this.environment,
    required this.appName,
    required this.googleWebClientId,
    required this.googleAndroidClientId,
    required this.googleIosClientId,
    required this.dropboxAppKey,
  });

  factory AppConfig.fromEnv(Map<String, String> env) {
    final String rawEnvironment = env['APP_ENV'] ?? '';

    return AppConfig(
      environment: AppEnvironment.values.firstWhere(
        (AppEnvironment value) => value.name == rawEnvironment,
        orElse: () => AppEnvironment.development,
      ),
      appName: env['APP_NAME'] ?? '',
      googleWebClientId: env['GOOGLE_WEB_CLIENT_ID'] ?? '',
      googleAndroidClientId: env['GOOGLE_ANDROID_CLIENT_ID'] ?? '',
      googleIosClientId: env['GOOGLE_IOS_CLIENT_ID'] ?? '',
      dropboxAppKey: env['DROPBOX_APP_KEY'] ?? '',
    );
  }

  final AppEnvironment environment;
  final String appName;

  /// The web app's OAuth client; used as `serverClientId` on Android.
  final String googleWebClientId;
  final String googleAndroidClientId;
  final String googleIosClientId;
  final String dropboxAppKey;

  bool get isProduction => environment == AppEnvironment.production;

  List<String> get validationErrors {
    final List<String> errors = <String>[];

    if (appName.trim().isEmpty) {
      errors.add('APP_NAME must not be empty.');
    }

    return List<String>.unmodifiable(errors);
  }
}
