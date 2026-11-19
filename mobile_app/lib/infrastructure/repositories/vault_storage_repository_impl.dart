import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/infrastructure/datasources/remote_datasources/dropbox_remote_data_source.dart';
import 'package:keeperpass/infrastructure/datasources/remote_datasources/google_drive_remote_data_source.dart';
import 'package:keeperpass/infrastructure/datasources/remote_datasources/vault_storage_remote_data_source.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_file_info.dart';

/// The encrypted vault file in whichever storage [ProviderId] names (web
/// `VaultStorageService`).
abstract class IVaultStorageRepository {
  Future<Either<Failure, VaultFileInfo?>> findVault(
    ProviderId provider,
    String accessToken,
  );

  Future<Either<Failure, String?>> loadVault(
    ProviderId provider,
    String accessToken,
  );

  Future<Either<Failure, Unit>> saveVault(
    ProviderId provider,
    String accessToken,
    String content, {
    UploadProgress? onProgress,
  });

  Future<Either<Failure, Unit>> resetVault(
    ProviderId provider,
    String accessToken,
    String content, {
    required DateTime backupAt,
    void Function()? onBackedUp,
    UploadProgress? onProgress,
  });

  Future<Either<Failure, String?>> detachVault(
    ProviderId provider,
    String accessToken,
  );

  Future<Either<Failure, VaultFileInfo?>> newerVersion(
    ProviderId provider,
    String accessToken,
  );
}

@Singleton(as: IVaultStorageRepository)
class VaultStorageRepositoryImpl implements IVaultStorageRepository {
  VaultStorageRepositoryImpl(
    GoogleDriveRemoteDataSource drive,
    DropboxRemoteDataSource dropbox,
  ) : _storages = <ProviderId, VaultStorageRemoteDataSource>{
        ProviderId.google: drive,
        ProviderId.dropbox: dropbox,
      };

  final Map<ProviderId, VaultStorageRemoteDataSource> _storages;

  @override
  Future<Either<Failure, VaultFileInfo?>> findVault(
    ProviderId provider,
    String accessToken,
  ) => _storages[provider]!.findVault(accessToken);

  @override
  Future<Either<Failure, String?>> loadVault(
    ProviderId provider,
    String accessToken,
  ) => _storages[provider]!.loadVault(accessToken);

  @override
  Future<Either<Failure, Unit>> saveVault(
    ProviderId provider,
    String accessToken,
    String content, {
    UploadProgress? onProgress,
  }) => _storages[provider]!.saveVault(
    accessToken,
    content,
    onProgress: onProgress,
  );

  @override
  Future<Either<Failure, Unit>> resetVault(
    ProviderId provider,
    String accessToken,
    String content, {
    required DateTime backupAt,
    void Function()? onBackedUp,
    UploadProgress? onProgress,
  }) => _storages[provider]!.resetVault(
    accessToken,
    content,
    backupAt: backupAt,
    onBackedUp: onBackedUp,
    onProgress: onProgress,
  );

  @override
  Future<Either<Failure, String?>> detachVault(
    ProviderId provider,
    String accessToken,
  ) => _storages[provider]!.detachVault(accessToken);

  @override
  Future<Either<Failure, VaultFileInfo?>> newerVersion(
    ProviderId provider,
    String accessToken,
  ) => _storages[provider]!.newerVersion(accessToken);
}
