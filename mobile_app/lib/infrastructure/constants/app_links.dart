/// Addresses the app opens in the browser.
abstract final class AppLinks {
  /// "View source on GitHub" (Technical Details; your answer, 2026-10-31).
  static final Uri sourceCode = Uri.parse(
    'https://github.com/vironautics/keeperpass',
  );

  /// About (board `S5-41`; the web's footer links).
  static final Uri terms = Uri.parse('https://keeperpass.com/terms-of-service');
  static final Uri privacy = Uri.parse('https://keeperpass.com/privacy-policy');

  /// The support address (About, Questions' "Still stuck?").
  static const String contactEmail = 'contact@keeperpass.com';
  static final Uri contact = Uri.parse('mailto:$contactEmail');

  /// Settings › Storage › Access (board `S5-24`): where each account lists
  /// the apps it lets in. Not in the web.
  static final Uri googlePermissions = Uri.parse(
    'https://myaccount.google.com/permissions',
  );
  static final Uri dropboxConnectedApps = Uri.parse(
    'https://www.dropbox.com/account/connected_apps',
  );

  /// "Open Google Drive" when the old file could not be renamed (board
  /// `S5-30`): the folder that holds it.
  static final Uri googleDrive = Uri.parse('https://drive.google.com/');
  static final Uri dropboxAppFolder = Uri.parse(
    'https://www.dropbox.com/home/Apps/keeperpass',
  );
}
