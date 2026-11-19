// ignore_for_file: file_names
import 'package:equatable/equatable.dart';

enum CubitStatusType { idle, loading, success, failure }

/// Every action a cubit can report through [CubitStatus]. One app-wide enum:
/// each feature adds its own actions here as it is built.
enum CubitAction {
  none,

  // Session (Part 5)
  restoreSession,
  signIn,
  checkVault,
  unlock,
  createVault,
  resetVault,
  signOut,
  archiveVault,

  // Saving (Part 5)
  reconnect,
  loadLatest,

  // Vault list (Part 7)
  refreshVault,

  // Scan a QR code (Part 15)
  saveCode,
}

class CubitStatus extends Equatable {
  final CubitStatusType statusType;
  final CubitAction? action;
  final String? errorMsg;
  final Map<String, dynamic>? args;
  const CubitStatus({
    this.args,
    this.action = CubitAction.none,
    this.statusType = CubitStatusType.idle,
    this.errorMsg,
  });

  @override
  List<Object?> get props => <Object?>[statusType, action, errorMsg, args];
}
