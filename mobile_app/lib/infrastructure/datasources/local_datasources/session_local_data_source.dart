import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/infrastructure/constants/storage_constants.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';

/// The storage sign-in remembered on this phone (D10), in the Keychain /
/// Android Keystore-backed storage — never the secret, never the vault.
abstract class ISessionLocalDataSource {
  Future<RememberedSession?> read();
  Future<void> write(RememberedSession session);
  Future<void> clear();
}

@Singleton(as: ISessionLocalDataSource)
class SessionLocalDataSourceImpl implements ISessionLocalDataSource {
  SessionLocalDataSourceImpl(this._storage);

  final FlutterSecureStorage _storage;

  @override
  Future<RememberedSession?> read() async {
    final Map<String, String> values = await _storage.readAll();
    final ProviderId? provider = ProviderId.tryParse(
      values[StorageConstants.sessionProvider],
    );
    final String? email = values[StorageConstants.sessionEmail];
    // A provider this build does not know cannot be talked to (web
    // `restoreSession`): treated as signed out.
    if (provider == null || email == null) return null;
    return RememberedSession(
      account: ProviderAccount(
        provider: provider,
        email: email,
        name: values[StorageConstants.sessionName] ?? '',
      ),
      refreshToken: values[StorageConstants.sessionRefreshToken],
      expired: values[StorageConstants.sessionExpired] == 'true',
    );
  }

  @override
  Future<void> write(RememberedSession session) async {
    await _storage.write(
      key: StorageConstants.sessionProvider,
      value: session.account.provider.value,
    );
    await _storage.write(
      key: StorageConstants.sessionEmail,
      value: session.account.email,
    );
    await _storage.write(
      key: StorageConstants.sessionName,
      value: session.account.name,
    );
    final String? refreshToken = session.refreshToken;
    if (refreshToken == null || refreshToken.isEmpty) {
      await _storage.delete(key: StorageConstants.sessionRefreshToken);
    } else {
      await _storage.write(
        key: StorageConstants.sessionRefreshToken,
        value: refreshToken,
      );
    }
    if (session.expired) {
      await _storage.write(key: StorageConstants.sessionExpired, value: 'true');
    } else {
      await _storage.delete(key: StorageConstants.sessionExpired);
    }
  }

  @override
  Future<void> clear() async {
    for (final String key in StorageConstants.sessionKeys) {
      await _storage.delete(key: key);
    }
  }
}
