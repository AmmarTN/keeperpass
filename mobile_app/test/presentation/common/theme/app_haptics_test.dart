import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/presentation/common/theme/app_haptics.dart';

/// The Motion board's haptics table, as the platform calls Flutter makes.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final List<String?> calls = <String?>[];

  setUp(() {
    calls.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (
          MethodCall call,
        ) async {
          if (call.method == 'HapticFeedback.vibrate') {
            calls.add(call.arguments as String?);
          }
          return null;
        });
  });

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, null);
  });

  Future<List<String?>> run(TargetPlatform platform) async {
    debugDefaultTargetPlatformOverride = platform;
    await AppHaptics.copy();
    await AppHaptics.regenerate();
    await AppHaptics.wrongSecret();
    await AppHaptics.success();
    await AppHaptics.selection();
    return List<String?>.of(calls);
  }

  test('iOS', () async {
    expect(await run(TargetPlatform.iOS), <String>[
      'HapticFeedbackType.lightImpact',
      'HapticFeedbackType.selectionClick',
      'HapticFeedbackType.errorNotification',
      'HapticFeedbackType.successNotification',
      'HapticFeedbackType.selectionClick',
    ]);
  });

  test('Android: CONFIRM, CLOCK_TICK, REJECT', () async {
    expect(await run(TargetPlatform.android), <String>[
      'HapticFeedbackType.successNotification',
      'HapticFeedbackType.selectionClick',
      'HapticFeedbackType.errorNotification',
      'HapticFeedbackType.successNotification',
      'HapticFeedbackType.selectionClick',
    ]);
  });
}
