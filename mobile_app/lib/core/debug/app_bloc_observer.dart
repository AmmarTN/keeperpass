import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeperpass/core/debug/logger.dart';

/// Logs state-owner lifecycles. Only types are logged, never state contents:
/// states hold decrypted vault data and the secret once the vault is open.
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<Object?> bloc) {
    logger.d('Created ${bloc.runtimeType}');
    super.onCreate(bloc);
  }

  @override
  void onError(BlocBase<Object?> bloc, Object error, StackTrace stackTrace) {
    logger.e('${bloc.runtimeType} error', error: error, stackTrace: stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<Object?> bloc) {
    logger.d('Closed ${bloc.runtimeType}');
    super.onClose(bloc);
  }
}
