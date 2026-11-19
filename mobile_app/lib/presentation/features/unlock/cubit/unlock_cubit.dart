import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/enums/session_phase.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';

part 'unlock_cubit.freezed.dart';
part 'unlock_state.dart';

/// Unlock (board `U2-Unlock`, web `UnlockPage`): the secret opens the vault
/// with the file's own key settings. A wrong secret keeps the field's value;
/// an unreachable file offers Retry with the secret still filled in.
@injectable
class UnlockCubit extends Cubit<UnlockState> {
  UnlockCubit(this._session) : super(const UnlockState());

  final SessionCubit _session;

  Future<void> unlock(String secret) async {
    if (secret.isEmpty || state.status == UnlockStatus.unlocking) return;
    emit(state.copyWith(status: UnlockStatus.unlocking, failure: null));
    await _session.unlock(secret);
    if (isClosed) return;
    final SessionState session = _session.state;
    final Failure? failure = session.failure;
    if (session.phase != SessionPhase.awaitingSecret || failure == null) {
      // Unlocked, or the session expired: the app navigates.
      emit(state.copyWith(status: UnlockStatus.idle));
      return;
    }
    if (failure is WrongSecret) {
      emit(
        state.copyWith(
          status: UnlockStatus.wrongSecret,
          failure: failure,
          wrongAttempts: state.wrongAttempts + 1,
        ),
      );
      return;
    }
    final bool unreachable = failure.maybeMap(
      networkFailure: (_) => true,
      orElse: () => false,
    );
    emit(
      state.copyWith(
        status: unreachable ? UnlockStatus.unreachable : UnlockStatus.failed,
        failure: failure,
      ),
    );
  }

  /// "Not you? Disconnect".
  Future<void> disconnect() => _session.signOut();

  /// Re-reads the account's name for the dial (web `UnlockPage` on mount).
  Future<void> refreshProfile() => _session.refreshProfile();
}
