import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/new_vault_dto.dart';
import 'package:keeperpass/core/dtos/vault_secret_dto.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/generator/generate_secret.dart';
import 'package:keeperpass/core/usecases/vault/create_vault.dart';
import 'package:keeperpass/core/usecases/vault/encrypt_new_vault.dart';
import 'package:keeperpass/core/utils/validation/password_strength.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/models/vault/prepared_vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';

part 'create_vault_cubit.freezed.dart';
part 'create_vault_state.dart';

/// Create (board `U2-Create`, web `SetupPage`): three short steps — choose
/// the secret, type it again, write it down — then the first vault is
/// encrypted on this phone and saved. A failed save keeps the encrypted
/// vault, so Try again only uploads.
@injectable
class CreateVaultCubit extends Cubit<CreateVaultState> {
  CreateVaultCubit(
    this._session,
    this._generateSecret,
    this._encryptNewVault,
    this._createVault,
  ) : super(const CreateVaultState());

  final SessionCubit _session;
  final GenerateSecret _generateSecret;
  final EncryptNewVault _encryptNewVault;
  final CreateVault _createVault;

  /// The vault encrypted for the current secret, kept for Try again.
  PreparedVault? _prepared;

  void setSecret(String secret) {
    if (secret == state.secret) return;
    _prepared = null;
    emit(
      state.copyWith(
        secret: secret,
        generated: false,
        repeat: '',
        acknowledged: false,
      ),
    );
  }

  void setRepeat(String repeat) => emit(state.copyWith(repeat: repeat));

  void setAcknowledged(bool acknowledged) =>
      emit(state.copyWith(acknowledged: acknowledged));

  /// "Generate a secret": five words in the app language; the retype step
  /// is skipped (web `onGenerated` fills both fields).
  Future<void> generate() async {
    final Either<Failure, String> result = await _generateSecret(
      LocaleSettings.currentLocale.languageCode,
    );
    result.fold((_) {}, (String secret) {
      _prepared = null;
      emit(
        state.copyWith(
          secret: secret,
          generated: true,
          repeat: secret,
          acknowledged: false,
          generation: state.generation + 1,
        ),
      );
    });
  }

  void next() {
    if (!state.canContinue) return;
    switch (state.step) {
      case CreateStep.secret:
        emit(
          state.copyWith(
            step: state.generated ? CreateStep.writeDown : CreateStep.repeat,
          ),
        );
      case CreateStep.repeat:
        emit(state.copyWith(step: CreateStep.writeDown));
      case CreateStep.writeDown:
        create();
      default:
        break;
    }
  }

  void back() {
    switch (state.step) {
      case CreateStep.repeat:
        emit(state.copyWith(step: CreateStep.secret));
      case CreateStep.writeDown:
        emit(
          state.copyWith(
            step: state.generated ? CreateStep.secret : CreateStep.repeat,
          ),
        );
      default:
        break;
    }
  }

  /// "Back to your secret": step 1 with everything kept.
  void backToSecret() => emit(state.copyWith(step: CreateStep.secret));

  /// "Create vault", and "Try again".
  Future<void> create() async {
    if (state.step == CreateStep.working) return;
    emit(
      state.copyWith(
        step: CreateStep.working,
        stage: CreateStage.encrypting,
        failure: null,
      ),
    );
    final PreparedVault prepared =
        _prepared ??
        (await _encryptNewVault(
          VaultSecretDto(secret: state.secret, vaultName: t.vaults.defaultName),
        )).getOrElse(() => throw StateError('Encryption cannot fail'));
    _prepared = prepared;
    if (isClosed) return;

    emit(state.copyWith(stage: CreateStage.saving));
    final Either<Failure, VaultSnapshot> result = await _createVault(
      NewVaultDto(vault: prepared),
    );
    if (isClosed) return;
    await result.fold(
      (Failure failure) async {
        if (failure is StorageAuthExpired) {
          await _session.sessionExpired(failure);
          return;
        }
        emit(state.copyWith(step: CreateStep.failed, failure: failure));
      },
      (_) async {
        emit(state.copyWith(step: CreateStep.done));
        _session.vaultOpened();
      },
    );
  }

  /// "Disconnect".
  Future<void> disconnect() => _session.signOut();
}
