import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:keeperpass/core/debug/logger.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// What the camera says besides the codes it reads.
enum ScanCameraProblem {
  /// It runs only with camera access, and has none.
  refused,

  /// It could not start (no camera, or another app holds it).
  failed,
}

/// The camera under the scanning view (board `S6-28`): mobile_scanner on a
/// phone; tests give a still one. Reads QR codes only, and keeps no image
/// ("Nothing is recorded, and no image is kept").
abstract class ScanCamera {
  /// The preview, filling its box.
  Widget view(BuildContext context);

  /// Each QR code's text, as it is read.
  Stream<String> get reads;

  /// A refusal or a failure, once per start.
  Stream<ScanCameraProblem> get problems;

  /// The light: null when this camera has none.
  ValueListenable<bool?> get light;

  Future<void> toggleLight();

  Future<void> start();

  Future<void> stop();

  Future<void> dispose();
}

/// [ScanCamera] over mobile_scanner. Its lifecycle is the screen's: started
/// and stopped with the app coming and going (the plugin's own lifecycle
/// handling needs no controller, and the light needs one).
class MobileScannerCamera implements ScanCamera {
  MobileScannerCamera() {
    _controller.addListener(_changed);
    _codes = _controller.barcodes.listen((BarcodeCapture capture) {
      for (final Barcode code in capture.barcodes) {
        final String? text = code.rawValue;
        if (text != null && text.isNotEmpty) _reads.add(text);
      }
    });
  }

  final MobileScannerController _controller = MobileScannerController(
    autoStart: false,
    formats: const <BarcodeFormat>[BarcodeFormat.qrCode],
  );
  final StreamController<String> _reads = StreamController<String>.broadcast();
  final StreamController<ScanCameraProblem> _problems =
      StreamController<ScanCameraProblem>.broadcast();
  final ValueNotifier<bool?> _light = ValueNotifier<bool?>(null);
  StreamSubscription<BarcodeCapture>? _codes;
  MobileScannerException? _reported;

  @override
  Stream<String> get reads => _reads.stream;

  @override
  Stream<ScanCameraProblem> get problems => _problems.stream;

  @override
  ValueListenable<bool?> get light => _light;

  @override
  Widget view(BuildContext context) => MobileScanner(
    controller: _controller,
    // The scanning view draws its own dark background and error toast.
    errorBuilder: (_, _) => const SizedBox.expand(),
    placeholderBuilder: (_) => const SizedBox.expand(),
  );

  void _changed() {
    final MobileScannerState state = _controller.value;
    _light.value = switch (state.torchState) {
      TorchState.unavailable => null,
      TorchState.on => true,
      TorchState.off || TorchState.auto => false,
    };
    final MobileScannerException? error = state.error;
    if (error == null || identical(error, _reported)) return;
    _reported = error;
    logger.w('Camera not started: ${error.errorCode.name}');
    // Starting and stopping out of turn is the screen's timing, not a
    // camera that cannot run.
    final ScanCameraProblem? problem = switch (error.errorCode) {
      MobileScannerErrorCode.permissionDenied => ScanCameraProblem.refused,
      MobileScannerErrorCode.genericError ||
      MobileScannerErrorCode.unsupported => ScanCameraProblem.failed,
      _ => null,
    };
    if (problem != null) _problems.add(problem);
  }

  @override
  Future<void> toggleLight() async {
    try {
      await _controller.toggleTorch();
    } on Object catch (error) {
      logger.w('Light not switched: ${error.runtimeType}');
    }
  }

  @override
  Future<void> start() async {
    try {
      await _controller.start();
    } on MobileScannerException {
      // Also in the controller's state, and reported from there.
    } on Object catch (error) {
      logger.w('Camera not started: ${error.runtimeType}');
      _problems.add(ScanCameraProblem.failed);
    }
  }

  @override
  Future<void> stop() async {
    try {
      await _controller.stop();
    } on Object catch (error) {
      logger.w('Camera not stopped: ${error.runtimeType}');
    }
  }

  @override
  Future<void> dispose() async {
    _controller.removeListener(_changed);
    await _codes?.cancel();
    await _reads.close();
    await _problems.close();
    _light.dispose();
    await _controller.dispose();
  }
}
