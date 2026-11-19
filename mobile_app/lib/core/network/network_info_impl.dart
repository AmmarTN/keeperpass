import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:keeperpass/core/network/network_info.dart';

@LazySingleton(as: NetworkInfo)
final class NetworkInfoImpl implements NetworkInfo {
  const NetworkInfoImpl(this._internetConnection);

  final InternetConnection _internetConnection;

  @override
  Future<bool> get isConnected => _internetConnection.hasInternetAccess;

  @override
  Stream<bool> get onConnectivityChanged => _internetConnection.onStatusChange
      .map((InternetStatus status) => status == InternetStatus.connected);
}
