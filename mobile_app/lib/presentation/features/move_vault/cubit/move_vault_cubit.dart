import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/move_vault_dto.dart';
import 'package:keeperpass/core/enums/migration_stage.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/generator/generate_secret.dart';
import 'package:keeperpass/core/usecases/vault/connect_migration_target.dart';
import 'package:keeperpass/core/usecases/vault/move_vault.dart';
import 'package:keeperpass/core/utils/validation/password_strength.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_file_info.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';

part 'move_vault_cubit.freezed.dart';
part 'move_vault_state.dart';

/// Settings › Move vault (board `Move-vault`; web `MoveVaultDialog`): sign
/// in to the destination, say how to move it, then wait. Nothing is written
/// before Move vault. On success the phone signs out at once and Welcome
/// shows where the vault went; a failed move changes nothing and can be
/// tried again.
@injectable
class MoveVaultCubit extends Cubit<MoveVaultState> {
  MoveVaultCubit(
    this._connect,
    this._moveVault,
    this._generateSecret,
    this._vault,
    this._session,
  ) : super(const MoveVaultState());

  final ConnectMigrationTarget _connect;
  final MoveVault _moveVault;
  final GenerateSecret _generateSecret;
  final VaultSessionService _vault;
  final SessionCubit _session;

  /// Where the vault goes; from where is the session's storage.
  void start(ProviderId destination) => emit(
    MoveVaultState(
      from: _session.state.account?.provider,
      destination: destination,
    ),
  );

  /// "Connect Dropbox": signs in there and looks for a vault.
  Future<void> connect() async {
    final ProviderId? destination = state.destination;
    if (destination == null || state.connecting) return;
    emit(state.copyWith(connecting: true, connectFailure: null));
    final Either<Failure, MigrationTarget> result = await _connect(destination);
    if (isClosed) return;
    result.fold(
      (Failure failure) =>
          emit(state.copyWith(connecting: false, connectFailure: failure)),
      (MigrationTarget target) => emit(
        state.copyWith(
          connecting: false,
          target: target,
          step: MoveVaultStep.confirm,
        ),
      ),
    );
  }

  /// "Replace it — the existing vault is kept as a backup".
  void setReplace(bool value) => emit(state.copyWith(replaceConfirmed: value));

  void setNewSecret(bool value) => emit(state.copyWith(newSecret: value));

  void setSecret(String value) => emit(state.copyWith(secret: value));

  void setRepeat(String value) => emit(state.copyWith(repeat: value));

  /// "Generate": a new passphrase in both fields, shown.
  Future<void> generate() async {
    final Either<Failure, String> result = await _generateSecret(
      LocaleSettings.currentLocale.languageCode,
    );
    result.fold((_) {}, (String secret) {
      if (isClosed) return;
      emit(
        state.copyWith(
          secret: secret,
          repeat: secret,
          generation: state.generation + 1,
        ),
      );
    });
  }

  /// "Move vault", and "Try again" after a failed move.
  Future<void> move() async {
    final MigrationTarget? target = state.target;
    final ProviderId? destination = state.destination;
    final ProviderId? from = state.from;
    if (target == null || destination == null || from == null) return;
    // A second tap before the screen turns into the progress: one move.
    if (!state.canMove || state.step == MoveVaultStep.moving) return;
    final String secret = state.newSecret
        ? state.secret
        : (_vault.secret ?? '');
    emit(
      state.copyWith(
        step: MoveVaultStep.moving,
        stage: MigrationStage.encrypting,
        progress: 0,
        failure: null,
      ),
    );
    final Either<Failure, String?> result = await _moveVault(
      MoveVaultDto(
        targetProvider: destination,
        target: target,
        secret: secret,
        replaceExisting: state.replaceConfirmed,
        onStage: (MigrationStage stage) {
          if (!isClosed) emit(state.copyWith(stage: stage));
        },
        onProgress: (double fraction) {
          if (!isClosed) emit(state.copyWith(progress: fraction));
        },
      ),
    );
    if (isClosed) return;
    await result.fold(
      (Failure failure) async =>
          emit(state.copyWith(step: MoveVaultStep.failed, failure: failure)),
      (String? renamed) => _session.vaultMoved(
        SessionFarewell.moved(
          from: from,
          to: destination,
          renamedFile: renamed,
        ),
      ),
    );
  }
}
