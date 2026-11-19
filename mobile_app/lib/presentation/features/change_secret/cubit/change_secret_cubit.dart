import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/change_secret_dto.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/generator/generate_secret.dart';
import 'package:keeperpass/core/usecases/vault/change_secret.dart';
import 'package:keeperpass/core/utils/validation/password_strength.dart';
import 'package:keeperpass/i18n/strings.g.dart';

part 'change_secret_cubit.freezed.dart';
part 'change_secret_state.dart';

/// Settings › Change secret (board `Change-secret`; web
/// `ChangePasswordDialog`): the current secret is proved by opening the
/// stored vault, then the vault is encrypted under the new one and
/// uploaded. A wrong current secret goes back to the form with nothing
/// cleared; a failed upload changes nothing.
@injectable
class ChangeSecretCubit extends Cubit<ChangeSecretState> {
  ChangeSecretCubit(this._changeSecret, this._generateSecret)
    : super(const ChangeSecretState());

  final ChangeSecret _changeSecret;
  final GenerateSecret _generateSecret;

  void setCurrent(String value) =>
      emit(state.copyWith(current: value, wrongCurrent: false));

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

  /// "Change secret", and "Try again" after a failed upload.
  Future<void> submit() async {
    if (!state.canSubmit || _working) return;
    emit(
      state.copyWith(
        step: ChangeSecretStep.verifying,
        progress: 0,
        failure: null,
        wrongCurrent: false,
      ),
    );
    final Either<Failure, Unit> result = await _changeSecret(
      ChangeSecretDto(
        currentSecret: state.current,
        newSecret: state.secret,
        onVerified: () {
          if (!isClosed) {
            emit(state.copyWith(step: ChangeSecretStep.encrypting));
          }
        },
        onProgress: (double fraction) {
          if (!isClosed) {
            emit(
              state.copyWith(step: ChangeSecretStep.saving, progress: fraction),
            );
          }
        },
      ),
    );
    if (isClosed) return;
    result.fold(
      (Failure failure) => emit(
        failure is WrongSecret
            ? state.copyWith(step: ChangeSecretStep.form, wrongCurrent: true)
            : state.copyWith(step: ChangeSecretStep.failed, failure: failure),
      ),
      (_) => emit(state.copyWith(step: ChangeSecretStep.done, progress: 1)),
    );
  }

  bool get _working => switch (state.step) {
    ChangeSecretStep.verifying ||
    ChangeSecretStep.encrypting ||
    ChangeSecretStep.saving => true,
    _ => false,
  };
}
