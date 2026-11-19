// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:flutter/services.dart' as _i281;
import 'package:flutter_appauth/flutter_appauth.dart' as _i337;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;
import 'package:keeperpass/core/app.dart' as _i417;
import 'package:keeperpass/core/network/network_info.dart' as _i508;
import 'package:keeperpass/core/network/network_info_impl.dart' as _i633;
import 'package:keeperpass/core/storage/key_value_storage.dart' as _i478;
import 'package:keeperpass/core/usecases/audit/run_audit.dart' as _i972;
import 'package:keeperpass/core/usecases/auth/get_available_providers.dart'
    as _i78;
import 'package:keeperpass/core/usecases/auth/mark_session_expired.dart'
    as _i873;
import 'package:keeperpass/core/usecases/auth/reconnect.dart' as _i184;
import 'package:keeperpass/core/usecases/auth/refresh_profile.dart' as _i1030;
import 'package:keeperpass/core/usecases/auth/restore_session.dart' as _i838;
import 'package:keeperpass/core/usecases/auth/sign_in.dart' as _i998;
import 'package:keeperpass/core/usecases/auth/sign_out.dart' as _i599;
import 'package:keeperpass/core/usecases/common/get_country_names.dart' as _i32;
import 'package:keeperpass/core/usecases/common/get_icon_catalog.dart' as _i509;
import 'package:keeperpass/core/usecases/common/get_relative_time_formatter.dart'
    as _i134;
import 'package:keeperpass/core/usecases/common/get_saved_locale.dart' as _i460;
import 'package:keeperpass/core/usecases/common/get_theme_preference.dart'
    as _i1073;
import 'package:keeperpass/core/usecases/common/save_locale.dart' as _i161;
import 'package:keeperpass/core/usecases/common/save_theme_preference.dart'
    as _i381;
import 'package:keeperpass/core/usecases/data/import_items.dart' as _i435;
import 'package:keeperpass/core/usecases/data/record_export.dart' as _i738;
import 'package:keeperpass/core/usecases/generator/generate_secret.dart'
    as _i1042;
import 'package:keeperpass/core/usecases/generator/get_word_list.dart' as _i672;
import 'package:keeperpass/core/usecases/items/create_item.dart' as _i568;
import 'package:keeperpass/core/usecases/items/delete_history_entry.dart'
    as _i546;
import 'package:keeperpass/core/usecases/items/delete_items.dart' as _i718;
import 'package:keeperpass/core/usecases/items/move_items.dart' as _i555;
import 'package:keeperpass/core/usecases/items/restore_history_entry.dart'
    as _i1032;
import 'package:keeperpass/core/usecases/items/toggle_favourite.dart' as _i968;
import 'package:keeperpass/core/usecases/items/update_item.dart' as _i1017;
import 'package:keeperpass/core/usecases/recent/get_recent_items.dart' as _i544;
import 'package:keeperpass/core/usecases/recent/record_recent_item.dart'
    as _i592;
import 'package:keeperpass/core/usecases/recent/watch_recent_items.dart'
    as _i242;
import 'package:keeperpass/core/usecases/settings/apply_privacy_settings.dart'
    as _i171;
import 'package:keeperpass/core/usecases/settings/get_auto_lock_delay.dart'
    as _i1005;
import 'package:keeperpass/core/usecases/settings/get_block_screenshots.dart'
    as _i1069;
import 'package:keeperpass/core/usecases/settings/get_clipboard_clear_delay.dart'
    as _i160;
import 'package:keeperpass/core/usecases/settings/get_hide_in_switcher.dart'
    as _i1032;
import 'package:keeperpass/core/usecases/settings/save_auto_lock_delay.dart'
    as _i392;
import 'package:keeperpass/core/usecases/settings/save_block_screenshots.dart'
    as _i1039;
import 'package:keeperpass/core/usecases/settings/save_clipboard_clear_delay.dart'
    as _i942;
import 'package:keeperpass/core/usecases/settings/save_hide_in_switcher.dart'
    as _i1025;
import 'package:keeperpass/core/usecases/tags/add_tag.dart' as _i996;
import 'package:keeperpass/core/usecases/tags/delete_tags.dart' as _i66;
import 'package:keeperpass/core/usecases/tags/rename_tag.dart' as _i176;
import 'package:keeperpass/core/usecases/vault/archive_vault.dart' as _i895;
import 'package:keeperpass/core/usecases/vault/change_secret.dart' as _i87;
import 'package:keeperpass/core/usecases/vault/check_newer_version.dart'
    as _i756;
import 'package:keeperpass/core/usecases/vault/check_vault.dart' as _i317;
import 'package:keeperpass/core/usecases/vault/connect_migration_target.dart'
    as _i59;
import 'package:keeperpass/core/usecases/vault/create_vault.dart' as _i111;
import 'package:keeperpass/core/usecases/vault/encrypt_new_vault.dart' as _i751;
import 'package:keeperpass/core/usecases/vault/get_migration_targets.dart'
    as _i1037;
import 'package:keeperpass/core/usecases/vault/lock_vault.dart' as _i404;
import 'package:keeperpass/core/usecases/vault/move_vault.dart' as _i331;
import 'package:keeperpass/core/usecases/vault/reload_vault.dart' as _i588;
import 'package:keeperpass/core/usecases/vault/reset_vault.dart' as _i857;
import 'package:keeperpass/core/usecases/vault/save_vault.dart' as _i63;
import 'package:keeperpass/core/usecases/vault/unlock_vault.dart' as _i845;
import 'package:keeperpass/core/usecases/vaults/add_vault.dart' as _i41;
import 'package:keeperpass/core/usecases/vaults/delete_vaults.dart' as _i700;
import 'package:keeperpass/core/usecases/vaults/rename_vault.dart' as _i611;
import 'package:keeperpass/core/utils/crypto/vault_cipher.dart' as _i116;
import 'package:keeperpass/infrastructure/datasources/local_datasources/bundled_data_local_data_source.dart'
    as _i806;
import 'package:keeperpass/infrastructure/datasources/local_datasources/clipboard_local_data_source.dart'
    as _i111;
import 'package:keeperpass/infrastructure/datasources/local_datasources/locale_local_data_source.dart'
    as _i926;
import 'package:keeperpass/infrastructure/datasources/local_datasources/lock_settings_local_data_source.dart'
    as _i506;
import 'package:keeperpass/infrastructure/datasources/local_datasources/recent_items_local_data_source.dart'
    as _i233;
import 'package:keeperpass/infrastructure/datasources/local_datasources/session_local_data_source.dart'
    as _i277;
import 'package:keeperpass/infrastructure/datasources/local_datasources/theme_local_data_source.dart'
    as _i53;
import 'package:keeperpass/infrastructure/datasources/remote_datasources/breach_remote_data_source.dart'
    as _i948;
import 'package:keeperpass/infrastructure/datasources/remote_datasources/dropbox_auth_remote_data_source.dart'
    as _i925;
import 'package:keeperpass/infrastructure/datasources/remote_datasources/dropbox_remote_data_source.dart'
    as _i145;
import 'package:keeperpass/infrastructure/datasources/remote_datasources/google_auth_remote_data_source.dart'
    as _i253;
import 'package:keeperpass/infrastructure/datasources/remote_datasources/google_drive_remote_data_source.dart'
    as _i1006;
import 'package:keeperpass/infrastructure/injections/external_library_injectable_module.dart'
    as _i101;
import 'package:keeperpass/infrastructure/repositories/auth_repository_impl.dart'
    as _i456;
import 'package:keeperpass/infrastructure/repositories/breach_repository_impl.dart'
    as _i949;
import 'package:keeperpass/infrastructure/repositories/bundled_data_repository_impl.dart'
    as _i178;
import 'package:keeperpass/infrastructure/repositories/locale_repository_impl.dart'
    as _i823;
import 'package:keeperpass/infrastructure/repositories/lock_settings_repository_impl.dart'
    as _i875;
import 'package:keeperpass/infrastructure/repositories/recent_items_repository_impl.dart'
    as _i607;
import 'package:keeperpass/infrastructure/repositories/theme_repository_impl.dart'
    as _i245;
import 'package:keeperpass/infrastructure/repositories/vault_storage_repository_impl.dart'
    as _i970;
import 'package:keeperpass/infrastructure/services/camera_permission_service.dart'
    as _i29;
import 'package:keeperpass/infrastructure/services/clipboard_service.dart'
    as _i630;
import 'package:keeperpass/infrastructure/services/file_service.dart' as _i410;
import 'package:keeperpass/infrastructure/services/link_service.dart' as _i849;
import 'package:keeperpass/infrastructure/services/lock_service.dart' as _i933;
import 'package:keeperpass/infrastructure/services/privacy_service.dart'
    as _i163;
import 'package:keeperpass/infrastructure/services/vault_session_service.dart'
    as _i676;
import 'package:keeperpass/presentation/common/cubit/audit/audit_cubit.dart'
    as _i641;
import 'package:keeperpass/presentation/common/cubit/bottom_nav_bar/bottom_nav_cubit.dart'
    as _i751;
import 'package:keeperpass/presentation/common/cubit/connectivity/connectivity_cubit.dart'
    as _i769;
import 'package:keeperpass/presentation/common/cubit/language/language_cubit.dart'
    as _i348;
import 'package:keeperpass/presentation/common/cubit/lock/lock_cubit.dart'
    as _i586;
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart'
    as _i19;
import 'package:keeperpass/presentation/common/cubit/sync/sync_cubit.dart'
    as _i540;
import 'package:keeperpass/presentation/common/cubit/theme/theme_cubit.dart'
    as _i914;
import 'package:keeperpass/presentation/common/injections/router_injection.dart'
    as _i50;
import 'package:keeperpass/presentation/common/routes/router.dart' as _i427;
import 'package:keeperpass/presentation/features/change_secret/cubit/change_secret_cubit.dart'
    as _i904;
import 'package:keeperpass/presentation/features/codes/cubit/codes_cubit.dart'
    as _i307;
import 'package:keeperpass/presentation/features/create_vault/cubit/create_vault_cubit.dart'
    as _i787;
import 'package:keeperpass/presentation/features/data_io/cubit/export_cubit.dart'
    as _i140;
import 'package:keeperpass/presentation/features/data_io/cubit/import_cubit.dart'
    as _i423;
import 'package:keeperpass/presentation/features/edit_item/cubit/edit_item_cubit.dart'
    as _i908;
import 'package:keeperpass/presentation/features/generator/cubit/generator_cubit.dart'
    as _i929;
import 'package:keeperpass/presentation/features/item_detail/cubit/item_detail_cubit.dart'
    as _i641;
import 'package:keeperpass/presentation/features/move_vault/cubit/move_vault_cubit.dart'
    as _i591;
import 'package:keeperpass/presentation/features/new_vault/cubit/new_vault_cubit.dart'
    as _i511;
import 'package:keeperpass/presentation/features/scan_qr/cubit/scan_cubit.dart'
    as _i117;
import 'package:keeperpass/presentation/features/security/cubit/security_cubit.dart'
    as _i973;
import 'package:keeperpass/presentation/features/settings/cubit/settings_cubit.dart'
    as _i332;
import 'package:keeperpass/presentation/features/tags/cubit/tags_cubit.dart'
    as _i607;
import 'package:keeperpass/presentation/features/unlock/cubit/unlock_cubit.dart'
    as _i309;
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_cubit.dart'
    as _i208;
import 'package:keeperpass/presentation/features/vaults/cubit/my_vaults_cubit.dart'
    as _i223;
import 'package:keeperpass/presentation/features/welcome/cubit/connect_cubit.dart'
    as _i477;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final externalLibraryInjectableModule = _$ExternalLibraryInjectableModule();
    final routerInjectableModule = _$RouterInjectableModule();
    gh.factory<_i751.BottomNavCubit>(() => _i751.BottomNavCubit());
    gh.lazySingleton<_i116.VaultCipher>(() => _i116.VaultCipher());
    gh.lazySingleton<_i361.Dio>(() => externalLibraryInjectableModule.dio);
    gh.lazySingleton<_i161.InternetConnection>(
      () => externalLibraryInjectableModule.internetConnection,
    );
    gh.lazySingleton<_i281.AssetBundle>(
      () => externalLibraryInjectableModule.assetBundle,
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => externalLibraryInjectableModule.secureStorage,
    );
    gh.lazySingleton<_i337.FlutterAppAuth>(
      () => externalLibraryInjectableModule.appAuth,
    );
    gh.lazySingleton<_i116.GoogleSignIn>(
      () => externalLibraryInjectableModule.googleSignIn,
    );
    gh.lazySingleton<_i29.CameraPermissionService>(
      () => _i29.CameraPermissionService(),
    );
    gh.lazySingleton<_i849.LinkService>(() => _i849.LinkService());
    gh.lazySingleton<_i933.LockService>(() => _i933.LockService());
    gh.lazySingleton<_i163.PrivacyService>(() => _i163.PrivacyService());
    gh.lazySingleton<_i676.VaultSessionService>(
      () => _i676.VaultSessionService(),
    );
    gh.lazySingleton<_i427.AppRouter>(() => routerInjectableModule.appRouter);
    await gh.lazySingletonAsync<_i478.KeyValueStorage>(
      () => externalLibraryInjectableModule.keyValueStorage,
      preResolve: true,
    );
    gh.singleton<_i111.IClipboardLocalDataSource>(
      () => _i111.ClipboardLocalDataSourceImpl(),
    );
    gh.singleton<_i145.DropboxRemoteDataSource>(
      () => _i145.DropboxRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.singleton<_i253.GoogleAuthRemoteDataSource>(
      () => _i253.GoogleAuthRemoteDataSourceImpl(
        gh<_i116.GoogleSignIn>(),
        gh<_i361.Dio>(),
        gh<_i417.AppConfig>(),
      ),
    );
    gh.singleton<_i277.ISessionLocalDataSource>(
      () => _i277.SessionLocalDataSourceImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.singleton<_i1006.GoogleDriveRemoteDataSource>(
      () => _i1006.GoogleDriveRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.singleton<_i948.BreachRemoteDataSource>(
      () => _i948.BreachRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.singleton<_i53.IThemeLocalDataSource>(
      () => _i53.ThemeLocalDataSourceImpl(gh<_i478.KeyValueStorage>()),
    );
    gh.singleton<_i949.IBreachRepository>(
      () => _i949.BreachRepositoryImpl(gh<_i948.BreachRemoteDataSource>()),
    );
    gh.singleton<_i970.IVaultStorageRepository>(
      () => _i970.VaultStorageRepositoryImpl(
        gh<_i1006.GoogleDriveRemoteDataSource>(),
        gh<_i145.DropboxRemoteDataSource>(),
      ),
    );
    gh.singleton<_i806.IBundledDataLocalDataSource>(
      () => _i806.BundledDataLocalDataSourceImpl(gh<_i281.AssetBundle>()),
    );
    gh.lazySingleton<_i410.FileService>(
      () => _i410.FileService(gh<_i933.LockService>()),
    );
    gh.singleton<_i506.ILockSettingsLocalDataSource>(
      () => _i506.LockSettingsLocalDataSourceImpl(gh<_i478.KeyValueStorage>()),
    );
    gh.singleton<_i233.IRecentItemsLocalDataSource>(
      () => _i233.RecentItemsLocalDataSourceImpl(gh<_i478.KeyValueStorage>()),
    );
    gh.lazySingleton<_i508.NetworkInfo>(
      () => _i633.NetworkInfoImpl(gh<_i161.InternetConnection>()),
    );
    gh.singleton<_i972.RunAudit>(
      () => _i972.RunAudit(
        gh<_i676.VaultSessionService>(),
        gh<_i949.IBreachRepository>(),
      ),
    );
    gh.singleton<_i751.EncryptNewVault>(
      () => _i751.EncryptNewVault(gh<_i116.VaultCipher>()),
    );
    gh.singleton<_i178.IBundledDataRepository>(
      () => _i178.BundledDataRepositoryImpl(
        gh<_i806.IBundledDataLocalDataSource>(),
      ),
    );
    gh.singleton<_i435.ImportItems>(
      () => _i435.ImportItems(gh<_i676.VaultSessionService>()),
    );
    gh.singleton<_i738.RecordExport>(
      () => _i738.RecordExport(gh<_i676.VaultSessionService>()),
    );
    gh.singleton<_i568.CreateItem>(
      () => _i568.CreateItem(gh<_i676.VaultSessionService>()),
    );
    gh.singleton<_i546.DeleteHistoryEntry>(
      () => _i546.DeleteHistoryEntry(gh<_i676.VaultSessionService>()),
    );
    gh.singleton<_i555.MoveItems>(
      () => _i555.MoveItems(gh<_i676.VaultSessionService>()),
    );
    gh.singleton<_i1032.RestoreHistoryEntry>(
      () => _i1032.RestoreHistoryEntry(gh<_i676.VaultSessionService>()),
    );
    gh.singleton<_i968.ToggleFavourite>(
      () => _i968.ToggleFavourite(gh<_i676.VaultSessionService>()),
    );
    gh.singleton<_i1017.UpdateItem>(
      () => _i1017.UpdateItem(gh<_i676.VaultSessionService>()),
    );
    gh.singleton<_i996.AddTag>(
      () => _i996.AddTag(gh<_i676.VaultSessionService>()),
    );
    gh.singleton<_i66.DeleteTags>(
      () => _i66.DeleteTags(gh<_i676.VaultSessionService>()),
    );
    gh.singleton<_i176.RenameTag>(
      () => _i176.RenameTag(gh<_i676.VaultSessionService>()),
    );
    gh.singleton<_i404.LockVault>(
      () => _i404.LockVault(gh<_i676.VaultSessionService>()),
    );
    gh.singleton<_i41.AddVault>(
      () => _i41.AddVault(gh<_i676.VaultSessionService>()),
    );
    gh.singleton<_i700.DeleteVaults>(
      () => _i700.DeleteVaults(gh<_i676.VaultSessionService>()),
    );
    gh.singleton<_i611.RenameVault>(
      () => _i611.RenameVault(gh<_i676.VaultSessionService>()),
    );
    gh.singleton<_i925.DropboxAuthRemoteDataSource>(
      () => _i925.DropboxAuthRemoteDataSourceImpl(
        gh<_i337.FlutterAppAuth>(),
        gh<_i361.Dio>(),
        gh<_i417.AppConfig>(),
      ),
    );
    gh.singleton<_i926.ILocaleLocalDataSource>(
      () => _i926.LocaleLocalDataSourceImpl(gh<_i478.KeyValueStorage>()),
    );
    gh.singleton<_i823.ILocaleRepository>(
      () => _i823.LocaleRepositoryImpl(gh<_i926.ILocaleLocalDataSource>()),
    );
    gh.singleton<_i875.ILockSettingsRepository>(
      () => _i875.LockSettingsRepositoryImpl(
        gh<_i506.ILockSettingsLocalDataSource>(),
      ),
    );
    gh.singleton<_i245.IThemeRepository>(
      () => _i245.ThemeRepositoryImpl(gh<_i53.IThemeLocalDataSource>()),
    );
    gh.singleton<_i1073.GetThemePreference>(
      () => _i1073.GetThemePreference(gh<_i245.IThemeRepository>()),
    );
    gh.singleton<_i381.SaveThemePreference>(
      () => _i381.SaveThemePreference(gh<_i245.IThemeRepository>()),
    );
    gh.singleton<_i1005.GetAutoLockDelay>(
      () => _i1005.GetAutoLockDelay(gh<_i875.ILockSettingsRepository>()),
    );
    gh.singleton<_i1069.GetBlockScreenshots>(
      () => _i1069.GetBlockScreenshots(gh<_i875.ILockSettingsRepository>()),
    );
    gh.singleton<_i160.GetClipboardClearDelay>(
      () => _i160.GetClipboardClearDelay(gh<_i875.ILockSettingsRepository>()),
    );
    gh.singleton<_i1032.GetHideInSwitcher>(
      () => _i1032.GetHideInSwitcher(gh<_i875.ILockSettingsRepository>()),
    );
    gh.singleton<_i392.SaveAutoLockDelay>(
      () => _i392.SaveAutoLockDelay(gh<_i875.ILockSettingsRepository>()),
    );
    gh.singleton<_i1039.SaveBlockScreenshots>(
      () => _i1039.SaveBlockScreenshots(gh<_i875.ILockSettingsRepository>()),
    );
    gh.singleton<_i942.SaveClipboardClearDelay>(
      () => _i942.SaveClipboardClearDelay(gh<_i875.ILockSettingsRepository>()),
    );
    gh.singleton<_i1025.SaveHideInSwitcher>(
      () => _i1025.SaveHideInSwitcher(gh<_i875.ILockSettingsRepository>()),
    );
    gh.singleton<_i32.GetCountryNames>(
      () => _i32.GetCountryNames(gh<_i178.IBundledDataRepository>()),
    );
    gh.singleton<_i509.GetIconCatalog>(
      () => _i509.GetIconCatalog(gh<_i178.IBundledDataRepository>()),
    );
    gh.singleton<_i134.GetRelativeTimeFormatter>(
      () => _i134.GetRelativeTimeFormatter(gh<_i178.IBundledDataRepository>()),
    );
    gh.singleton<_i1042.GenerateSecret>(
      () => _i1042.GenerateSecret(gh<_i178.IBundledDataRepository>()),
    );
    gh.singleton<_i672.GetWordList>(
      () => _i672.GetWordList(gh<_i178.IBundledDataRepository>()),
    );
    gh.singleton<_i171.ApplyPrivacySettings>(
      () => _i171.ApplyPrivacySettings(
        gh<_i875.ILockSettingsRepository>(),
        gh<_i163.PrivacyService>(),
      ),
    );
    gh.singleton<_i460.GetSavedLocale>(
      () => _i460.GetSavedLocale(gh<_i823.ILocaleRepository>()),
    );
    gh.singleton<_i161.SaveLocale>(
      () => _i161.SaveLocale(gh<_i823.ILocaleRepository>()),
    );
    gh.lazySingleton<_i769.ConnectivityCubit>(
      () => _i769.ConnectivityCubit(gh<_i508.NetworkInfo>()),
    );
    gh.singleton<_i456.IAuthRepository>(
      () => _i456.AuthRepositoryImpl(
        gh<_i253.GoogleAuthRemoteDataSource>(),
        gh<_i925.DropboxAuthRemoteDataSource>(),
        gh<_i277.ISessionLocalDataSource>(),
      ),
    );
    gh.singleton<_i607.IRecentItemsRepository>(
      () => _i607.RecentItemsRepositoryImpl(
        gh<_i233.IRecentItemsLocalDataSource>(),
      ),
    );
    gh.singleton<_i895.ArchiveVault>(
      () => _i895.ArchiveVault(
        gh<_i456.IAuthRepository>(),
        gh<_i970.IVaultStorageRepository>(),
        gh<_i676.VaultSessionService>(),
      ),
    );
    gh.singleton<_i111.CreateVault>(
      () => _i111.CreateVault(
        gh<_i456.IAuthRepository>(),
        gh<_i970.IVaultStorageRepository>(),
        gh<_i676.VaultSessionService>(),
      ),
    );
    gh.singleton<_i857.ResetVault>(
      () => _i857.ResetVault(
        gh<_i456.IAuthRepository>(),
        gh<_i970.IVaultStorageRepository>(),
        gh<_i676.VaultSessionService>(),
      ),
    );
    gh.singleton<_i756.CheckNewerVersion>(
      () => _i756.CheckNewerVersion(
        gh<_i456.IAuthRepository>(),
        gh<_i970.IVaultStorageRepository>(),
      ),
    );
    gh.singleton<_i317.CheckVault>(
      () => _i317.CheckVault(
        gh<_i456.IAuthRepository>(),
        gh<_i970.IVaultStorageRepository>(),
      ),
    );
    gh.lazySingleton<_i348.LanguageCubit>(
      () => _i348.LanguageCubit(
        gh<_i460.GetSavedLocale>(),
        gh<_i161.SaveLocale>(),
      ),
    );
    gh.lazySingleton<_i914.ThemeCubit>(
      () => _i914.ThemeCubit(
        gh<_i1073.GetThemePreference>(),
        gh<_i381.SaveThemePreference>(),
      ),
    );
    gh.singleton<_i718.DeleteItems>(
      () => _i718.DeleteItems(
        gh<_i676.VaultSessionService>(),
        gh<_i607.IRecentItemsRepository>(),
      ),
    );
    gh.singleton<_i1037.GetMigrationTargets>(
      () => _i1037.GetMigrationTargets(gh<_i456.IAuthRepository>()),
    );
    gh.singleton<_i630.ClipboardService>(
      () => _i630.ClipboardService(
        gh<_i111.IClipboardLocalDataSource>(),
        gh<_i875.ILockSettingsRepository>(),
      ),
    );
    gh.factory<_i929.GeneratorCubit>(
      () => _i929.GeneratorCubit(
        gh<_i672.GetWordList>(),
        gh<_i630.ClipboardService>(),
      ),
    );
    gh.singleton<_i87.ChangeSecret>(
      () => _i87.ChangeSecret(
        gh<_i456.IAuthRepository>(),
        gh<_i970.IVaultStorageRepository>(),
        gh<_i116.VaultCipher>(),
        gh<_i676.VaultSessionService>(),
      ),
    );
    gh.singleton<_i331.MoveVault>(
      () => _i331.MoveVault(
        gh<_i456.IAuthRepository>(),
        gh<_i970.IVaultStorageRepository>(),
        gh<_i116.VaultCipher>(),
        gh<_i676.VaultSessionService>(),
      ),
    );
    gh.singleton<_i588.ReloadVault>(
      () => _i588.ReloadVault(
        gh<_i456.IAuthRepository>(),
        gh<_i970.IVaultStorageRepository>(),
        gh<_i116.VaultCipher>(),
        gh<_i676.VaultSessionService>(),
      ),
    );
    gh.singleton<_i63.SaveVault>(
      () => _i63.SaveVault(
        gh<_i456.IAuthRepository>(),
        gh<_i970.IVaultStorageRepository>(),
        gh<_i116.VaultCipher>(),
        gh<_i676.VaultSessionService>(),
      ),
    );
    gh.singleton<_i845.UnlockVault>(
      () => _i845.UnlockVault(
        gh<_i456.IAuthRepository>(),
        gh<_i970.IVaultStorageRepository>(),
        gh<_i116.VaultCipher>(),
        gh<_i676.VaultSessionService>(),
      ),
    );
    gh.singleton<_i78.GetAvailableProviders>(
      () => _i78.GetAvailableProviders(gh<_i456.IAuthRepository>()),
    );
    gh.singleton<_i1030.RefreshProfile>(
      () => _i1030.RefreshProfile(gh<_i456.IAuthRepository>()),
    );
    gh.singleton<_i838.RestoreSession>(
      () => _i838.RestoreSession(gh<_i456.IAuthRepository>()),
    );
    gh.singleton<_i184.Reconnect>(
      () =>
          _i184.Reconnect(gh<_i456.IAuthRepository>(), gh<_i933.LockService>()),
    );
    gh.singleton<_i998.SignIn>(
      () => _i998.SignIn(gh<_i456.IAuthRepository>(), gh<_i933.LockService>()),
    );
    gh.singleton<_i873.MarkSessionExpired>(
      () => _i873.MarkSessionExpired(
        gh<_i456.IAuthRepository>(),
        gh<_i676.VaultSessionService>(),
      ),
    );
    gh.singleton<_i599.SignOut>(
      () => _i599.SignOut(
        gh<_i456.IAuthRepository>(),
        gh<_i676.VaultSessionService>(),
      ),
    );
    gh.singleton<_i59.ConnectMigrationTarget>(
      () => _i59.ConnectMigrationTarget(
        gh<_i456.IAuthRepository>(),
        gh<_i970.IVaultStorageRepository>(),
        gh<_i933.LockService>(),
      ),
    );
    gh.factory<_i332.SettingsCubit>(
      () => _i332.SettingsCubit(
        gh<_i676.VaultSessionService>(),
        gh<_i160.GetClipboardClearDelay>(),
        gh<_i942.SaveClipboardClearDelay>(),
        gh<_i1032.GetHideInSwitcher>(),
        gh<_i1025.SaveHideInSwitcher>(),
        gh<_i1069.GetBlockScreenshots>(),
        gh<_i1039.SaveBlockScreenshots>(),
        gh<_i171.ApplyPrivacySettings>(),
        gh<_i1037.GetMigrationTargets>(),
        gh<_i849.LinkService>(),
      ),
    );
    gh.singleton<_i544.GetRecentItems>(
      () => _i544.GetRecentItems(gh<_i607.IRecentItemsRepository>()),
    );
    gh.singleton<_i592.RecordRecentItem>(
      () => _i592.RecordRecentItem(gh<_i607.IRecentItemsRepository>()),
    );
    gh.singleton<_i242.WatchRecentItems>(
      () => _i242.WatchRecentItems(gh<_i607.IRecentItemsRepository>()),
    );
    gh.lazySingleton<_i19.SessionCubit>(
      () => _i19.SessionCubit(
        gh<_i838.RestoreSession>(),
        gh<_i78.GetAvailableProviders>(),
        gh<_i998.SignIn>(),
        gh<_i317.CheckVault>(),
        gh<_i845.UnlockVault>(),
        gh<_i404.LockVault>(),
        gh<_i599.SignOut>(),
        gh<_i895.ArchiveVault>(),
        gh<_i873.MarkSessionExpired>(),
        gh<_i1030.RefreshProfile>(),
      ),
    );
    gh.factory<_i904.ChangeSecretCubit>(
      () => _i904.ChangeSecretCubit(
        gh<_i87.ChangeSecret>(),
        gh<_i1042.GenerateSecret>(),
      ),
    );
    gh.lazySingleton<_i540.SyncCubit>(
      () => _i540.SyncCubit(
        gh<_i63.SaveVault>(),
        gh<_i588.ReloadVault>(),
        gh<_i756.CheckNewerVersion>(),
        gh<_i184.Reconnect>(),
        gh<_i676.VaultSessionService>(),
        gh<_i769.ConnectivityCubit>(),
      ),
    );
    gh.factory<_i307.CodesCubit>(
      () => _i307.CodesCubit(
        gh<_i676.VaultSessionService>(),
        gh<_i592.RecordRecentItem>(),
        gh<_i630.ClipboardService>(),
      ),
    );
    gh.factory<_i591.MoveVaultCubit>(
      () => _i591.MoveVaultCubit(
        gh<_i59.ConnectMigrationTarget>(),
        gh<_i331.MoveVault>(),
        gh<_i1042.GenerateSecret>(),
        gh<_i676.VaultSessionService>(),
        gh<_i19.SessionCubit>(),
      ),
    );
    gh.factory<_i140.ExportCubit>(
      () => _i140.ExportCubit(
        gh<_i676.VaultSessionService>(),
        gh<_i410.FileService>(),
        gh<_i738.RecordExport>(),
        gh<_i540.SyncCubit>(),
      ),
    );
    gh.factory<_i223.MyVaultsCubit>(
      () => _i223.MyVaultsCubit(
        gh<_i676.VaultSessionService>(),
        gh<_i540.SyncCubit>(),
        gh<_i41.AddVault>(),
        gh<_i611.RenameVault>(),
        gh<_i700.DeleteVaults>(),
      ),
    );
    gh.factory<_i309.UnlockCubit>(
      () => _i309.UnlockCubit(gh<_i19.SessionCubit>()),
    );
    gh.factory<_i787.CreateVaultCubit>(
      () => _i787.CreateVaultCubit(
        gh<_i19.SessionCubit>(),
        gh<_i1042.GenerateSecret>(),
        gh<_i751.EncryptNewVault>(),
        gh<_i111.CreateVault>(),
      ),
    );
    gh.lazySingleton<_i641.AuditCubit>(
      () => _i641.AuditCubit(
        gh<_i972.RunAudit>(),
        gh<_i19.SessionCubit>(),
        gh<_i676.VaultSessionService>(),
      ),
    );
    gh.factory<_i511.NewVaultCubit>(
      () => _i511.NewVaultCubit(
        gh<_i19.SessionCubit>(),
        gh<_i1042.GenerateSecret>(),
        gh<_i751.EncryptNewVault>(),
        gh<_i857.ResetVault>(),
      ),
    );
    gh.factory<_i607.TagsCubit>(
      () => _i607.TagsCubit(
        gh<_i676.VaultSessionService>(),
        gh<_i540.SyncCubit>(),
        gh<_i996.AddTag>(),
        gh<_i176.RenameTag>(),
        gh<_i66.DeleteTags>(),
      ),
    );
    gh.lazySingleton<_i586.LockCubit>(
      () => _i586.LockCubit(
        gh<_i19.SessionCubit>(),
        gh<_i933.LockService>(),
        gh<_i1005.GetAutoLockDelay>(),
        gh<_i392.SaveAutoLockDelay>(),
      ),
    );
    gh.factory<_i117.ScanCubit>(
      () => _i117.ScanCubit(
        gh<_i676.VaultSessionService>(),
        gh<_i540.SyncCubit>(),
        gh<_i641.AuditCubit>(),
        gh<_i568.CreateItem>(),
        gh<_i1017.UpdateItem>(),
        gh<_i29.CameraPermissionService>(),
        gh<_i933.LockService>(),
      ),
    );
    gh.factory<_i477.ConnectCubit>(
      () => _i477.ConnectCubit(
        gh<_i19.SessionCubit>(),
        gh<_i134.GetRelativeTimeFormatter>(),
        gh<_i849.LinkService>(),
      ),
    );
    gh.factory<_i641.ItemDetailCubit>(
      () => _i641.ItemDetailCubit(
        gh<_i676.VaultSessionService>(),
        gh<_i540.SyncCubit>(),
        gh<_i641.AuditCubit>(),
        gh<_i592.RecordRecentItem>(),
        gh<_i968.ToggleFavourite>(),
        gh<_i555.MoveItems>(),
        gh<_i718.DeleteItems>(),
        gh<_i41.AddVault>(),
        gh<_i1032.RestoreHistoryEntry>(),
        gh<_i546.DeleteHistoryEntry>(),
        gh<_i134.GetRelativeTimeFormatter>(),
        gh<_i32.GetCountryNames>(),
        gh<_i630.ClipboardService>(),
        gh<_i849.LinkService>(),
      ),
    );
    gh.factory<_i973.SecurityCubit>(
      () => _i973.SecurityCubit(
        gh<_i676.VaultSessionService>(),
        gh<_i641.AuditCubit>(),
        gh<_i769.ConnectivityCubit>(),
      ),
    );
    gh.factory<_i423.ImportCubit>(
      () => _i423.ImportCubit(
        gh<_i410.FileService>(),
        gh<_i435.ImportItems>(),
        gh<_i676.VaultSessionService>(),
        gh<_i540.SyncCubit>(),
      ),
    );
    gh.factory<_i908.EditItemCubit>(
      () => _i908.EditItemCubit(
        gh<_i676.VaultSessionService>(),
        gh<_i540.SyncCubit>(),
        gh<_i641.AuditCubit>(),
        gh<_i568.CreateItem>(),
        gh<_i1017.UpdateItem>(),
        gh<_i509.GetIconCatalog>(),
        gh<_i32.GetCountryNames>(),
      ),
    );
    gh.factory<_i208.VaultListCubit>(
      () => _i208.VaultListCubit(
        gh<_i676.VaultSessionService>(),
        gh<_i540.SyncCubit>(),
        gh<_i641.AuditCubit>(),
        gh<_i544.GetRecentItems>(),
        gh<_i242.WatchRecentItems>(),
        gh<_i592.RecordRecentItem>(),
        gh<_i968.ToggleFavourite>(),
        gh<_i555.MoveItems>(),
        gh<_i718.DeleteItems>(),
        gh<_i41.AddVault>(),
        gh<_i630.ClipboardService>(),
        gh<_i849.LinkService>(),
      ),
    );
    return this;
  }
}

class _$ExternalLibraryInjectableModule
    extends _i101.ExternalLibraryInjectableModule {}

class _$RouterInjectableModule extends _i50.RouterInjectableModule {}
