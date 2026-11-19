/// Device-local storage names and keys.
///
/// Keep keys stable after release or provide an explicit migration.
abstract final class StorageConstants {
  static const String settingsBox = 'app_settings';
  static const String locale = 'selected_locale';
  static const String themePreference = 'theme_preference';
  static const String autoLockDelay = 'auto_lock_delay';
  static const String clipboardClearDelay = 'clipboard_clear_delay';
  static const String hideInSwitcher = 'hide_in_app_switcher';
  static const String blockScreenshots = 'block_screenshots';

  /// Recently Used: item ids, most recent first (web `keeperpass:recentItemIds`).
  static const String recentItemIds = 'recent_item_ids';

  /// Secure storage (Keychain / Keystore): the remembered sign-in (D10).
  static const String sessionProvider = 'session_provider';
  static const String sessionEmail = 'session_email';
  static const String sessionName = 'session_name';
  static const String sessionRefreshToken = 'session_refresh_token';
  static const String sessionExpired = 'session_expired';

  static const List<String> sessionKeys = <String>[
    sessionProvider,
    sessionEmail,
    sessionName,
    sessionRefreshToken,
    sessionExpired,
  ];
}
