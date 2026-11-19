abstract interface class KeyValueStorage {
  T? read<T>(String key);

  Future<void> write<T>(String key, T value);

  Future<void> remove(String key);

  Future<void> clear();
}
