import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/storage/key_value_storage.dart';
import 'package:keeperpass/infrastructure/constants/storage_constants.dart';

abstract class IThemeLocalDataSource {
  String? readThemePreference();
  Future<void> writeThemePreference(String preference);
}

@Singleton(as: IThemeLocalDataSource)
class ThemeLocalDataSourceImpl implements IThemeLocalDataSource {
  final KeyValueStorage _storage;

  ThemeLocalDataSourceImpl(this._storage);

  @override
  String? readThemePreference() =>
      _storage.read<String>(StorageConstants.themePreference);

  @override
  Future<void> writeThemePreference(String preference) {
    return _storage.write<String>(StorageConstants.themePreference, preference);
  }
}
