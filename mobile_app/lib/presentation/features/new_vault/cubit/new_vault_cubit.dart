import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/new_vault_dto.dart';
import 'package:keeperpass/core/dtos/vault_secret_dto.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/generator/generate_secret.dart';
import 'package:keeperpass/core/usecases/vault/encrypt_new_vault.dart';
import 'package:keeperpass/core/usecases/vault/reset_vault.dart';
import 'package:keeperpass/core/utils/validation/password_strength.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/constants/vault_file_names.dart';
import 'package:keeperpass/infrastructure/models/vault/prepared_vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';

part 'new_vault_cubit.freezed.dart';
part 'new_vault_state.dart';

/// Start a New Vault after a forgotten secret (board `U2-New-vault`, web
/// `RecoverPage`): the old file is kept as a dated backup and a new, empty
/// vault takes its place. If the backup cannot be made nothing moves, and
/// trying again reuses the vault already encrypted.
@injectable
class NewVaultCubit extends Cubit<NewVaultState> {
  NewVaultCubit(
    this._session,
    this._generateSecret,
    this._encryptNewVault,
    this._resetVault, {
    @ignoreParam this._now = DateTime.now,
  }) : super(NewVaultState(backupAt: _now()));

  final SessionCubit _session;
  final GenerateSecret _generateSecret;
  final EncryptNewVault _encryptNewVault;
  final ResetVault _resetVault;
  final DateTime Function() _now;

  /// The vault encrypted for the current secret, kept for Try again.
  PreparedVault? _prepared;

  void setSecret(String secret) {
    if (secret == state.secret) return;
    _prepared = null;
    emit(state.copyWith(secret: secret));
  }

  void setRepeat(String repeat) => emit(state.copyWith(repeat: repeat));

  /// "Generate a secret" fills both fields (web `onGenerated`).
  Future<void> generate() async {
    final Either<Failure, String> result = await _generateSecret(
      LocaleSettings.currentLocale.languageCode,
    );
    result.fold((_) {}, (String secret) {
      _prepared = null;
      emit(
        state.copyWith(
          secret: secret,
          repeat: secret,
          generation: state.generation + 1,
        ),
      );
    });
  }

  /// After the confirmation sheet, and Try again.
  Future<void> start() async {
    if (!state.canStart || state.step == NewVaultStep.working) return;
    emit(
      state.copyWith(
        step: NewVaultStep.working,
        stage: NewVaultStage.encrypting,
        failure: null,
        backupAt: _now(),
      ),
    );
    final PreparedVault prepared =
        _prepared ??
        (await _encryptNewVault(
          VaultSecretDto(secret: state.secret, vaultName: t.vaults.defaultName),
        )).getOrElse(() => throw StateError('Encryption cannot fail'));
    _prepared = prepared;
    if (isClosed) return;

    emit(state.copyWith(stage: NewVaultStage.backingUp));
    final Either<Failure, VaultSnapshot> result = await _resetVault(
      NewVaultDto(
        vault: prepared,
        backupAt: state.backupAt,
        onBackedUp: () {
          if (!isClosed) emit(state.copyWith(stage: NewVaultStage.saving));
        },
      ),
    );
    if (isClosed) return;
    await result.fold(
      (Failure failure) async {
        if (failure is StorageAuthExpired) {
          await _session.sessionExpired(failure);
          return;
        }
        emit(state.copyWith(step: NewVaultStep.failed, failure: failure));
      },
      (_) async {
        emit(state.copyWith(step: NewVaultStep.done));
        _session.vaultOpened();
      },
    );
  }
}
