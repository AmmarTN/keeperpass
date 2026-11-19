import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/storage/key_value_storage.dart';
import 'package:keeperpass/infrastructure/constants/storage_constants.dart';

/// Settings › Security — auto-lock, clear clipboard, hide in app switcher —
/// saved on this phone only (not part of the vault).
abstract class ILockSettingsLocalDataSource {
  String? readAutoLockDelay();
  Future<void> writeAutoLockDelay(String delay);
  String? readClipboardClearDelay();
  Future<void> writeClipboardClearDelay(String delay);
  bool? readHideInSwitcher();
  Future<void> writeHideInSwitcher(bool hide);
  bool? readBlockScreenshots();
  Future<void> writeBlockScreenshots(bool block);
}

@Singleton(as: ILockSettingsLocalDataSource)
class LockSettingsLocalDataSourceImpl implements ILockSettingsLocalDataSource {
  final KeyValueStorage _storage;

  LockSettingsLocalDataSourceImpl(this._storage);

  @override
  String? readAutoLockDelay() =>
      _storage.read<String>(StorageConstants.autoLockDelay);

  @override
  Future<void> writeAutoLockDelay(String delay) =>
      _storage.write<String>(StorageConstants.autoLockDelay, delay);

  @override
  String? readClipboardClearDelay() =>
      _storage.read<String>(StorageConstants.clipboardClearDelay);

  @override
  Future<void> writeClipboardClearDelay(String delay) =>
      _storage.write<String>(StorageConstants.clipboardClearDelay, delay);

  @override
  bool? readHideInSwitcher() =>
      _storage.read<bool>(StorageConstants.hideInSwitcher);

  @override
  Future<void> writeHideInSwitcher(bool hide) =>
      _storage.write<bool>(StorageConstants.hideInSwitcher, hide);

  @override
  bool? readBlockScreenshots() =>
      _storage.read<bool>(StorageConstants.blockScreenshots);

  @override
  Future<void> writeBlockScreenshots(bool block) =>
      _storage.write<bool>(StorageConstants.blockScreenshots, block);
}
