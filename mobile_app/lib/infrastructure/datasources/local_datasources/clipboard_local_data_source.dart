import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

/// The phone's clipboard through KeeperPass's own channel
/// (`keeperpass/clipboard`: `ClipboardChannel` in `MainActivity` and
/// `AppDelegate`). A sensitive copy is kept out of Android's clipboard
/// preview and, on iOS, stays on this device and expires by itself.
abstract class IClipboardLocalDataSource {
  /// Puts [text] on the clipboard; the result marks this copy for
  /// [clearIfOurs].
  Future<String?> copy(
    String text, {
    required bool sensitive,
    Duration? expiresIn,
  });

  /// Empties the clipboard if it still holds the copy [marker] names; false
  /// when something else was copied since.
  Future<bool> clearIfOurs(String marker);
}

@Singleton(as: IClipboardLocalDataSource)
class ClipboardLocalDataSourceImpl implements IClipboardLocalDataSource {
  static const MethodChannel _channel = MethodChannel('keeperpass/clipboard');

  @override
  Future<String?> copy(
    String text, {
    required bool sensitive,
    Duration? expiresIn,
  }) => _channel.invokeMethod<String>('copy', <String, Object?>{
    'text': text,
    'sensitive': sensitive,
    'expiresInSeconds': expiresIn?.inSeconds,
  });

  @override
  Future<bool> clearIfOurs(String marker) async =>
      await _channel.invokeMethod<bool>('clearIfOurs', <String, Object?>{
        'marker': marker,
      }) ??
      false;
}
