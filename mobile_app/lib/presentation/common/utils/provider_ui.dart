import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/utils/text/initials.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/constants/app_links.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/presentation/common/widgets/brand/app_brand.dart';

/// How a provider appears on screen.
extension ProviderUi on ProviderId {
  /// Its logo.
  AppProvider get logo => switch (this) {
    ProviderId.google => AppProvider.google,
    ProviderId.dropbox => AppProvider.dropbox,
  };

  /// "Continue with Google" (the web's text).
  String get continueLabel => switch (this) {
    ProviderId.google => t.welcome.continueWithGoogle,
    ProviderId.dropbox => t.welcome.continueWithDropbox,
  };

  /// The folder that holds the vault, as a path: Drive's `keeperpass`
  /// folder, Dropbox's app folder (board `Help`, Technical details).
  String get folderPath => switch (this) {
    ProviderId.google => 'keeperpass',
    ProviderId.dropbox => 'Apps/keeperpass',
  };

  /// "keeperpass folder", read inside a sentence.
  String get folderLabel => switch (this) {
    ProviderId.google => t.storage.googleFolder,
    ProviderId.dropbox => t.storage.dropboxFolder,
  };

  /// Where the account lists the apps it lets in (board `S5-24`).
  String get accessLabel => switch (this) {
    ProviderId.google => t.storage.googlePermissions,
    ProviderId.dropbox => t.storage.dropboxApps,
  };

  Uri get accessLink => switch (this) {
    ProviderId.google => AppLinks.googlePermissions,
    ProviderId.dropbox => AppLinks.dropboxConnectedApps,
  };

  /// The storage's own page, at the vault's folder.
  Uri get folderLink => switch (this) {
    ProviderId.google => AppLinks.googleDrive,
    ProviderId.dropbox => AppLinks.dropboxAppFolder,
  };
}

extension ProviderAccountUi on ProviderAccount {
  /// The avatar's letters (web `NavUser.initials`).
  String get initials => initialsOf(displayName);
}
