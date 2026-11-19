import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:keeperpass/core/storage/key_value_storage.dart';
import 'package:keeperpass/infrastructure/constants/network_timeouts.dart';
import 'package:keeperpass/infrastructure/constants/storage_constants.dart';
import 'package:keeperpass/infrastructure/datasources/local_datasources/hive_key_value_storage.dart';

@module
abstract class ExternalLibraryInjectableModule {
  @lazySingleton
  Dio get dio => Dio(
    BaseOptions(
      connectTimeout: NetworkTimeouts.connect,
      sendTimeout: NetworkTimeouts.send,
      receiveTimeout: NetworkTimeouts.receive,
    ),
  );

  @lazySingleton
  InternetConnection get internetConnection => InternetConnection();

  /// The app's bundled assets (word lists, locale data).
  @lazySingleton
  AssetBundle get assetBundle => rootBundle;

  /// The remembered sign-in (D10). iOS: this device only, so it never moves
  /// to another phone through a backup; Android: excluded from Auto Backup
  /// (`res/xml/backup_rules.xml`, `data_extraction_rules.xml`).
  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage(
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  /// Dropbox sign-in in the system browser sheet (X6).
  @lazySingleton
  FlutterAppAuth get appAuth => const FlutterAppAuth();

  @lazySingleton
  GoogleSignIn get googleSignIn => GoogleSignIn.instance;

  @preResolve
  @LazySingleton(as: KeyValueStorage)
  Future<HiveKeyValueStorage> get keyValueStorage async {
    await Hive.initFlutter();
    final Box<dynamic> box = await Hive.openBox<dynamic>(
      StorageConstants.settingsBox,
    );
    return HiveKeyValueStorage(box);
  }
}
