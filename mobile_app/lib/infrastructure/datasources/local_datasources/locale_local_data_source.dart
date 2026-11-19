import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/storage/key_value_storage.dart';
import 'package:keeperpass/infrastructure/constants/storage_constants.dart';

abstract class ILocaleLocalDataSource {
  String? readLocale();
  Future<void> writeLocale(String localeCode);
}

@Singleton(as: ILocaleLocalDataSource)
class LocaleLocalDataSourceImpl implements ILocaleLocalDataSource {
  final KeyValueStorage _storage;

  LocaleLocalDataSourceImpl(this._storage);

  @override
  String? readLocale() => _storage.read<String>(StorageConstants.locale);

  @override
  Future<void> writeLocale(String localeCode) {
    return _storage.write<String>(StorageConstants.locale, localeCode);
  }
}
