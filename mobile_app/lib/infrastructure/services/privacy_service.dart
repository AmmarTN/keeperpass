import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/debug/logger.dart';
import 'package:no_screenshot/no_screenshot.dart';

/// What the phone may show of KeeperPass outside it (board `Lock-privacy`),
/// over the no_screenshot plugin (your choice, Part 14): the cover in the
/// app switcher — the KeeperPass mark on black (`NoScreenshotImage` on iOS,
/// `drawable-nodpi/no_screenshot_image.png` on Android) — and Android's
/// "Block screenshots". The plugin's cover also blocks screenshots and
/// screen recording while KeeperPass is open, on both platforms (accepted).
@lazySingleton
class PrivacyService {
  Future<void> apply({
    required bool hideInSwitcher,
    required bool blockScreenshots,
  }) async {
    final NoScreenshot plugin = NoScreenshot.instance;
    try {
      if (hideInSwitcher) {
        await plugin.screenshotWithImage();
      } else {
        await plugin.overlayOff();
      }
      // iOS has no "Block screenshots" of its own (the row is Android's).
      if (blockScreenshots && Platform.isAndroid) {
        await plugin.screenshotOff();
      } else {
        await plugin.screenshotOn();
      }
    } on Object catch (error) {
      logger.w('Privacy settings not applied: ${error.runtimeType}');
    }
  }
}
