import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/enums/session_phase.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/common/get_relative_time_formatter.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/utils/text/relative_time.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/constants/app_links.dart';
import 'package:keeperpass/infrastructure/models/general/cubitStatus.dart';
import 'package:keeperpass/infrastructure/services/link_service.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';

part 'connect_cubit.freezed.dart';
part 'connect_state.dart';

/// Welcome and Connect, one screen (board `U2-Connect`: "the same screen
/// keeps going"): sign in in the provider's sheet, check for the vault
/// file, then Unlock (after a beat of "Found your vault") or Create. Mirrors
/// the web's `StartPage` and `vaultStepGuard`.
@injectable
class ConnectCubit extends Cubit<ConnectState> {
  ConnectCubit(
    this._session,
    this._getRelativeTimeFormatter,
    this._links, {
    @ignoreParam this._now = DateTime.now,
    @ignoreParam this._foundBeat = const Duration(milliseconds: 900),
  }) : super(const ConnectState());

  final SessionCubit _session;
  final GetRelativeTimeFormatter _getRelativeTimeFormatter;
  final LinkService _links;
  final DateTime Function() _now;

  /// How long "Found your vault" shows before Unlock cross-fades in.
  final Duration _foundBeat;

  bool get _busy =>
      state.stage == ConnectStage.signingIn ||
      state.stage == ConnectStage.checking;

  Future<void> signIn(ProviderId provider) async {
    if (_busy) return;
    emit(
      state.copyWith(
        stage: ConnectStage.signingIn,
        signingIn: provider,
        signInFailure: null,
      ),
    );
    await _session.signIn(provider);
    if (isClosed) return;
    final SessionState session = _session.state;
    if (session.phase == SessionPhase.awaitingSecret) {
      await _check();
      return;
    }
    final Failure? failure = session.failure;
    emit(
      state.copyWith(
        stage: ConnectStage.idle,
        signingIn: null,
        signInFailure: failure is SignInCancelled ? null : failure,
        cancelled: failure is SignInCancelled
            ? state.cancelled + 1
            : state.cancelled,
      ),
    );
  }

  /// "Try again" after the vault check failed.
  Future<void> retryCheck() => _check();

  /// Disconnects and shows both providers again.
  Future<void> useAnotherAccount() async {
    await _session.signOut();
    if (!isClosed) emit(const ConnectState());
  }

  void destinationHandled() => emit(state.copyWith(destination: null));

  Future<void> openSourceCode() => _links.open(AppLinks.sourceCode);

  Future<void> _check() async {
    emit(state.copyWith(stage: ConnectStage.checking, signingIn: null));
    await _session.checkVault();
    if (isClosed) return;
    final SessionState session = _session.state;
    if (session.phase != SessionPhase.awaitingSecret) {
      // The session expired: the page greets the account again.
      emit(const ConnectState());
      return;
    }
    if (session.status.statusType == CubitStatusType.failure) {
      emit(state.copyWith(stage: ConnectStage.checkFailed));
      return;
    }
    if (session.hasVault != true) {
      emit(state.copyWith(destination: ConnectDestination.create));
      return;
    }
    emit(
      state.copyWith(
        stage: ConnectStage.found,
        foundMeta: await _foundMeta(session),
      ),
    );
    await Future<void>.delayed(_foundBeat);
    if (!isClosed) {
      emit(state.copyWith(destination: ConnectDestination.unlock));
    }
  }

  Future<String> _foundMeta(SessionState session) async {
    final String storage = session.account!.provider.storageName;
    final DateTime? modified = session.vaultFile?.modifiedAt;
    if (modified == null) return t.connect.foundMeta(storage: storage);
    final RelativeTimeFormatter? formatter = (await _getRelativeTimeFormatter(
      const NoParams(),
    )).fold((_) => null, (RelativeTimeFormatter formatter) => formatter);
    if (formatter == null) return t.connect.foundMeta(storage: storage);
    return t.connect.foundMetaUpdated(
      storage: storage,
      time: formatter.format(
        modified,
        now: _now(),
        locale: LocaleSettings.currentLocale.languageCode,
      ),
    );
  }
}
