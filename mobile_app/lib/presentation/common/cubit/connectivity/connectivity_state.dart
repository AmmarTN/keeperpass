part of 'connectivity_cubit.dart';

@freezed
sealed class ConnectivityState with _$ConnectivityState {
  const factory ConnectivityState.initial() = ConnectivityInitial;
  const factory ConnectivityState.connected() = ConnectivityConnected;
  const factory ConnectivityState.disconnected() = ConnectivityDisconnected;
}
