import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/clipboard_clear_delay.dart';
import 'package:keeperpass/infrastructure/services/clipboard_service.dart';

import '../../helpers/screen_states.dart';
import '../../helpers/vault_world.dart';

void main() {
  late FakeClipboard clipboard;
  late MemoryLockSettings settings;
  late bool open;
  late ClipboardService service;
  late int cleared;

  setUp(() {
    clipboard = FakeClipboard();
    settings = MemoryLockSettings();
    open = true;
    service = ClipboardService(clipboard, settings, isOpen: () => open);
    cleared = 0;
    service.cleared.listen((_) => cleared++);
  });

  testWidgets('a secret is cleared after the delay, while KeeperPass is open', (
    WidgetTester tester,
  ) async {
    final Duration? clearsIn = await service.copy('hunter2', sensitive: true);
    expect(clearsIn, const Duration(seconds: 30));
    expect(clipboard.sensitive.single, isTrue);
    // iOS expires it a moment later by itself.
    expect(clipboard.expiries.single, const Duration(seconds: 31));

    await tester.pump(const Duration(seconds: 29));
    expect(clipboard.cleared, isEmpty);
    await tester.pump(const Duration(seconds: 1));
    expect(clipboard.cleared, hasLength(1));
    expect(cleared, 1);
  });

  testWidgets('something copied since is left alone', (
    WidgetTester tester,
  ) async {
    await service.copy('hunter2', sensitive: true);
    clipboard.replaced = true;
    await tester.pump(const Duration(seconds: 31));
    expect(clipboard.cleared, isEmpty);
    expect(cleared, 0);
  });

  testWidgets('in the background nothing is cleared (your answer, Part 14)', (
    WidgetTester tester,
  ) async {
    await service.copy('hunter2', sensitive: true);
    open = false;
    await tester.pump(const Duration(seconds: 31));
    expect(clipboard.cleared, isEmpty);
  });

  testWidgets('the Settings delay; Never keeps it', (
    WidgetTester tester,
  ) async {
    settings.clipboard = ClipboardClearDelay.twoMinutes;
    Duration? clearsIn = await service.copy('a', sensitive: true);
    expect(clearsIn, const Duration(minutes: 2));

    settings.clipboard = ClipboardClearDelay.never;
    clearsIn = await service.copy('b', sensitive: true);
    expect(clearsIn, isNull);
    expect(clipboard.expiries.last, isNull);
    await tester.pump(const Duration(minutes: 5));
    expect(clipboard.cleared, isEmpty);
  });

  testWidgets('a username or a website stays, unmarked', (
    WidgetTester tester,
  ) async {
    final Duration? clearsIn = await service.copy('janedoe');
    expect(clearsIn, isNull);
    expect(clipboard.sensitive.single, isFalse);
    await tester.pump(const Duration(minutes: 1));
    expect(clipboard.cleared, isEmpty);
  });

  testWidgets('a new copy replaces the countdown', (WidgetTester tester) async {
    await service.copy('first', sensitive: true);
    await tester.pump(const Duration(seconds: 20));
    await service.copy('second', sensitive: true);
    await tester.pump(const Duration(seconds: 15));
    expect(clipboard.cleared, isEmpty);
    await tester.pump(const Duration(seconds: 15));
    expect(clipboard.cleared, <String>['copy-2']);
  });
}
