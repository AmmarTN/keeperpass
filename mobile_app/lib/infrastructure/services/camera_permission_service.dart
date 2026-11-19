import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/debug/logger.dart';
import 'package:permission_handler/permission_handler.dart';

/// Where camera access stands, as the scanner needs it (board `Scan-QR`).
enum CameraAccess {
  /// Scanning can start.
  allowed,

  /// The phone can still ask: the primer comes first.
  askable,

  /// Refused (or restricted): "Camera access is off".
  refused,
}

/// Camera access over permission_handler (your choice, Part 15): the
/// status without asking, the system prompt, and KeeperPass's page in the
/// phone's Settings.
@lazySingleton
class CameraPermissionService {
  /// Never asks.
  Future<CameraAccess> status() async {
    try {
      return _access(await Permission.camera.status);
    } on Object catch (error) {
      logger.w('Camera access unknown: ${error.runtimeType}');
      return CameraAccess.refused;
    }
  }

  /// The system prompt (nothing shows when the phone no longer asks). A
  /// refusal is [CameraAccess.refused] even where the phone could ask again
  /// (Android): the person just said no.
  Future<CameraAccess> request() async {
    try {
      final PermissionStatus status = await Permission.camera.request();
      return status.isGranted || status.isLimited
          ? CameraAccess.allowed
          : CameraAccess.refused;
    } on Object catch (error) {
      logger.w('Camera access not asked: ${error.runtimeType}');
      return CameraAccess.refused;
    }
  }

  /// KeeperPass's page in the phone's Settings.
  Future<void> openSettings() async {
    try {
      await openAppSettings();
    } on Object catch (error) {
      logger.w('Settings not opened: ${error.runtimeType}');
    }
  }

  // On iOS "not asked yet" reads as denied, a refusal as permanently denied;
  // on Android denied means the phone can still ask.
  CameraAccess _access(PermissionStatus status) => switch (status) {
    PermissionStatus.granted ||
    PermissionStatus.limited => CameraAccess.allowed,
    PermissionStatus.denied => CameraAccess.askable,
    PermissionStatus.permanentlyDenied ||
    PermissionStatus.restricted ||
    PermissionStatus.provisional => CameraAccess.refused,
  };
}
