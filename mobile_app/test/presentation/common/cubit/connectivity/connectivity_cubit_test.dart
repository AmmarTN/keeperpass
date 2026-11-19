import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/network/network_info.dart';
import 'package:keeperpass/presentation/common/cubit/connectivity/connectivity_cubit.dart';

final class FakeNetworkInfo implements NetworkInfo {
  FakeNetworkInfo(this.current);

  bool current;
  final StreamController<bool> controller = StreamController<bool>.broadcast();

  @override
  Future<bool> get isConnected async => current;

  @override
  Stream<bool> get onConnectivityChanged => controller.stream;

  Future<void> close() => controller.close();
}

void main() {
  late FakeNetworkInfo networkInfo;

  setUp(() {
    networkInfo = FakeNetworkInfo(true);
  });

  tearDown(() async {
    await networkInfo.close();
  });

  blocTest<ConnectivityCubit, ConnectivityState>(
    'emits connected after a successful initial reachability check',
    build: () =>
        ConnectivityCubit(networkInfo, offlineConfirmation: Duration.zero),
    act: (ConnectivityCubit cubit) => cubit.start(),
    expect: () => <ConnectivityState>[const ConnectivityState.connected()],
  );

  blocTest<ConnectivityCubit, ConnectivityState>(
    'confirms a disconnected state from the live stream',
    build: () =>
        ConnectivityCubit(networkInfo, offlineConfirmation: Duration.zero),
    act: (ConnectivityCubit cubit) async {
      await cubit.start();
      networkInfo.controller.add(false);
    },
    wait: const Duration(milliseconds: 10),
    expect: () => <ConnectivityState>[
      const ConnectivityState.connected(),
      const ConnectivityState.disconnected(),
    ],
  );
}
