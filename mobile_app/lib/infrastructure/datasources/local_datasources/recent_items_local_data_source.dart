import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/storage/key_value_storage.dart';
import 'package:keeperpass/infrastructure/constants/storage_constants.dart';

/// Recently Used, kept on this phone only (web `RecentItemsService`, which
/// keeps it in `localStorage`): a JSON list of item ids.
abstract class IRecentItemsLocalDataSource {
  String? readRecentItemIds();
  Future<void> writeRecentItemIds(String json);
}

@Singleton(as: IRecentItemsLocalDataSource)
class RecentItemsLocalDataSourceImpl implements IRecentItemsLocalDataSource {
  final KeyValueStorage _storage;

  RecentItemsLocalDataSourceImpl(this._storage);

  @override
  String? readRecentItemIds() =>
      _storage.read<String>(StorageConstants.recentItemIds);

  @override
  Future<void> writeRecentItemIds(String json) =>
      _storage.write<String>(StorageConstants.recentItemIds, json);
}
