import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/network/network_info.dart';

part 'connectivity_cubit.freezed.dart';
part 'connectivity_state.dart';

@lazySingleton
final class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit(
    this._networkInfo, {
    @ignoreParam this.offlineConfirmation = const Duration(seconds: 3),
  }) : super(const ConnectivityState.initial());

  final NetworkInfo _networkInfo;
  final Duration offlineConfirmation;
  StreamSubscription<bool>? _subscription;
  Timer? _offlineTimer;

  Future<void> start() async {
    _apply(await _networkInfo.isConnected);
    _subscription ??= _networkInfo.onConnectivityChanged.listen(_apply);
  }

  Future<void> recheck() async => _apply(await _networkInfo.isConnected);

  void _apply(bool isConnected) {
    _offlineTimer?.cancel();
    if (isConnected) {
      emit(const ConnectivityState.connected());
      return;
    }

    _offlineTimer = Timer(offlineConfirmation, () {
      if (!isClosed) emit(const ConnectivityState.disconnected());
    });
  }

  @override
  Future<void> close() async {
    _offlineTimer?.cancel();
    await _subscription?.cancel();
    return super.close();
  }
}
