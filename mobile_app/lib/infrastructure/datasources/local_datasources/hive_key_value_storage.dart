import 'package:hive_flutter/hive_flutter.dart';
import 'package:keeperpass/core/storage/key_value_storage.dart';

final class HiveKeyValueStorage implements KeyValueStorage {
  const HiveKeyValueStorage(this._box);

  final Box<dynamic> _box;

  @override
  T? read<T>(String key) => _box.get(key) as T?;

  @override
  Future<void> write<T>(String key, T value) => _box.put(key, value);

  @override
  Future<void> remove(String key) => _box.delete(key);

  @override
  Future<void> clear() => _box.clear();
}
