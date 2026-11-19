import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/enums/auto_lock_delay.dart';
import 'package:keeperpass/core/enums/clipboard_clear_delay.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/infrastructure/datasources/local_datasources/lock_settings_local_data_source.dart';

abstract class ILockSettingsRepository {
  /// The auto-lock delay saved on this phone; [AutoLockDelay.standard] when
  /// none was chosen.
  Future<Either<Failure, AutoLockDelay>> getAutoLockDelay();

  Future<Either<Failure, Unit>> saveAutoLockDelay(AutoLockDelay delay);

  /// Settings › Clear clipboard; [ClipboardClearDelay.standard] when none
  /// was chosen.
  Future<Either<Failure, ClipboardClearDelay>> getClipboardClearDelay();

  Future<Either<Failure, Unit>> saveClipboardClearDelay(
    ClipboardClearDelay delay,
  );

  /// Settings › Hide in app switcher; on unless turned off (board `S5-13`).
  Future<Either<Failure, bool>> getHideInSwitcher();

  Future<Either<Failure, Unit>> saveHideInSwitcher(bool hide);

  /// Android's "Block screenshots" (board `Lock-privacy`); on by default.
  Future<Either<Failure, bool>> getBlockScreenshots();

  Future<Either<Failure, Unit>> saveBlockScreenshots(bool block);
}

@Singleton(as: ILockSettingsRepository)
class LockSettingsRepositoryImpl implements ILockSettingsRepository {
  final ILockSettingsLocalDataSource _localDataSource;

  LockSettingsRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, AutoLockDelay>> getAutoLockDelay() async {
    try {
      return Right(
        AutoLockDelay.tryParse(_localDataSource.readAutoLockDelay()) ??
            AutoLockDelay.standard,
      );
    } catch (e) {
      return const Left(Failure.cacheReadFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> saveAutoLockDelay(AutoLockDelay delay) async {
    try {
      await _localDataSource.writeAutoLockDelay(delay.value);
      return const Right(unit);
    } catch (e) {
      return const Left(Failure.cacheWriteFailure());
    }
  }

  @override
  Future<Either<Failure, ClipboardClearDelay>> getClipboardClearDelay() async {
    try {
      return Right(
        ClipboardClearDelay.tryParse(
              _localDataSource.readClipboardClearDelay(),
            ) ??
            ClipboardClearDelay.standard,
      );
    } catch (e) {
      return const Left(Failure.cacheReadFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> saveClipboardClearDelay(
    ClipboardClearDelay delay,
  ) async {
    try {
      await _localDataSource.writeClipboardClearDelay(delay.value);
      return const Right(unit);
    } catch (e) {
      return const Left(Failure.cacheWriteFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> getHideInSwitcher() async {
    try {
      return Right(_localDataSource.readHideInSwitcher() ?? true);
    } catch (e) {
      return const Left(Failure.cacheReadFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> saveHideInSwitcher(bool hide) async {
    try {
      await _localDataSource.writeHideInSwitcher(hide);
      return const Right(unit);
    } catch (e) {
      return const Left(Failure.cacheWriteFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> getBlockScreenshots() async {
    try {
      return Right(_localDataSource.readBlockScreenshots() ?? true);
    } catch (e) {
      return const Left(Failure.cacheReadFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> saveBlockScreenshots(bool block) async {
    try {
      await _localDataSource.writeBlockScreenshots(block);
      return const Right(unit);
    } catch (e) {
      return const Left(Failure.cacheWriteFailure());
    }
  }
}
