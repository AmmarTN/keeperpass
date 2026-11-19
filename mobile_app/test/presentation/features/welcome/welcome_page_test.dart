import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/infrastructure/constants/app_links.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/services/clipboard_service.dart';
import 'package:keeperpass/infrastructure/services/link_service.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/features/welcome/cubit/connect_cubit.dart';
import 'package:keeperpass/presentation/features/welcome/pages/welcome_page.dart';

import '../../../helpers/fake_vault_layer.dart';
import '../../../helpers/screen_harness.dart';
import '../../../helpers/screen_states.dart';
import '../../../helpers/vault_world.dart';

/// Records the buttons' intents instead of signing in (no router here).
class TapConnectCubit extends StubConnectCubit {
  TapConnectCubit(super.session);

  final List<ProviderId> signIns = <ProviderId>[];
  int retries = 0;

  @override
  Future<void> signIn(ProviderId provider) async => signIns.add(provider);

  @override
  Future<void> retryCheck() async => retries++;
}

class ExpiredAuth extends FakeAuthRepository {
  @override
  Future<Either<Failure, RememberedSession?>> restoreSession() async =>
      const Right(RememberedSession(account: kJane, expired: true));
}

void main() {
  late ScreenWorld world;
  late TapConnectCubit connect;

  Future<void> pumpWelcome(
    WidgetTester tester, {
    FakeAuthRepository? auth,
    bool signedIn = false,
    Brightness brightness = Brightness.light,
    SessionFarewell? farewell,
  }) async {
    world = ScreenWorld(auth: auth);
    if (auth == null && !signedIn) world.auth.current = null;
    await world.restore();
    connect = TapConnectCubit(world.session);
    addTearDown(
      () => tester.runAsync(() async {
        await connect.close();
        await world.close();
      }),
    );
    await pumpScreen(
      tester,
      WelcomePage(farewell: farewell),
      // The later provider is the nearer one: it replaces the stub.
      providers: world.providers
        ..add(BlocProvider<ConnectCubit>.value(value: connect)),
      brightness: brightness,
    );
  }

  Future<void> show(WidgetTester tester, ConnectState state) async {
    connect.show(state);
    // The state arrives a microtask later; the second pump draws it.
    await tester.pump();
    await tester.pump();
  }

  for (final Brightness brightness in Brightness.values) {
    testWidgets('signed out: both providers and the facts '
        '(${brightness.name})', (WidgetTester tester) async {
      await pumpWelcome(tester, brightness: brightness);

      expect(find.text('Welcome to KeeperPass'), findsOneWidget);
      expect(find.text('End-to-end encrypted'), findsOneWidget);
      expect(find.text('Continue with Google'), findsOneWidget);
      expect(find.text('Continue with Dropbox'), findsOneWidget);
      expect(
        find.text('Access only to the files KeeperPass creates'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('a provider button signs in with that provider', (
    WidgetTester tester,
  ) async {
    await pumpWelcome(tester);

    await tester.tap(find.text('Continue with Dropbox'));
    await tester.pump();

    expect(connect.signIns, <ProviderId>[ProviderId.dropbox]);
  });

  testWidgets('offline: a banner, and the buttons wait', (
    WidgetTester tester,
  ) async {
    await pumpWelcome(tester);

    await world.goOffline();
    await tester.pump(Duration.zero);
    await tester.pump();
    await tester.tap(find.text('Continue with Google'), warnIfMissed: false);
    await tester.pump();

    expect(find.text('You’re offline'), findsOneWidget);
    expect(connect.signIns, isEmpty);
  });

  testWidgets('a closed provider page: a toast, nothing connected', (
    WidgetTester tester,
  ) async {
    await pumpWelcome(tester);

    await show(tester, const ConnectState(cancelled: 1));
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Sign-in canceled'), findsOneWidget);
    expect(find.text('Nothing was connected.'), findsOneWidget);
    await tester.pump(const Duration(seconds: 5));
  });

  testWidgets('a failed sign-in shows a banner above the buttons', (
    WidgetTester tester,
  ) async {
    await pumpWelcome(tester);

    await show(
      tester,
      const ConnectState(
        signInFailure: Failure.signInFailed(ProviderId.google),
      ),
    );

    expect(find.text('Sign-in failed'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);
  });

  group('after signing in', () {
    testWidgets('checking for the vault', (WidgetTester tester) async {
      await pumpWelcome(tester, signedIn: true);

      await show(tester, const ConnectState(stage: ConnectStage.checking));

      expect(find.text('Jane Doe'), findsOneWidget);
      expect(find.text('Checking your vault…'), findsOneWidget);
      expect(
        find.text('Looking for vault.json.enc in Google Drive.'),
        findsOneWidget,
      );
      expect(find.text('Looking in Google Drive…'), findsOneWidget);
    });

    testWidgets('found it', (WidgetTester tester) async {
      await pumpWelcome(tester, signedIn: true);

      await show(
        tester,
        const ConnectState(
          stage: ConnectStage.found,
          foundMeta: 'Found in Google Drive · updated 2 days ago',
        ),
      );

      expect(find.text('Found your vault'), findsOneWidget);
      expect(find.text('Opening Unlock…'), findsOneWidget);
      expect(
        find.text('Found in Google Drive · updated 2 days ago'),
        findsOneWidget,
      );
    });

    testWidgets('could not read it: Try again checks again', (
      WidgetTester tester,
    ) async {
      await pumpWelcome(tester, signedIn: true, brightness: Brightness.dark);

      await show(tester, const ConnectState(stage: ConnectStage.checkFailed));

      expect(find.text('Could not read your vault'), findsOneWidget);
      expect(
        find.text('Google Drive didn’t respond. Nothing was changed.'),
        findsOneWidget,
      );
      await tester.tap(find.text('Try again'));
      await tester.pump();
      expect(connect.retries, 1);
    });
  });

  testWidgets('an expired session greets the account by name', (
    WidgetTester tester,
  ) async {
    await pumpWelcome(tester, auth: ExpiredAuth());

    expect(world.session.state.expired, isTrue);
    expect(find.text('Welcome Back,\nJane'), findsOneWidget);
    expect(
      find.text(
        'Your Google session has expired. Sign in again to unlock your vault.',
      ),
      findsOneWidget,
    );
    expect(find.text('Last used'), findsOneWidget);
    expect(find.text('End-to-end encrypted'), findsNothing);
  });

  testWidgets('How it works: three pages, then Technical details', (
    WidgetTester tester,
  ) async {
    await pumpWelcome(tester);

    await tester.tap(find.text('How it works'));
    await tester.pumpAndSettle();
    expect(find.text('Your vault lives\nin your cloud'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Choose a secret'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('It takes both'), findsOneWidget);
    expect(find.text('Got it'), findsOneWidget);

    await tester.tap(find.text('Technical details'));
    await tester.pumpAndSettle();
    expect(find.text('Technical Details'), findsOneWidget);
    expect(find.text('View source on GitHub'), findsOneWidget);
    expect(
      find.text(
        'Free and open source under AGPL-3.0, so all of this can be checked.',
      ),
      findsOneWidget,
    );

    await tester.tapAt(const Offset(200, 80));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Got it'));
    await tester.pumpAndSettle();
    expect(find.text('It takes both'), findsNothing);
  });

  group('after archiving or moving, the outcome shows over Welcome', () {
    late FakeLinks links;
    late FakeClipboard clipboard;

    setUp(() {
      links = FakeLinks();
      clipboard = FakeClipboard();
      getIt
        ..registerSingleton<LinkService>(links)
        ..registerSingleton<ClipboardService>(
          ClipboardService(clipboard, MemoryLockSettings(), isOpen: () => true),
        );
    });
    tearDown(() async {
      await getIt.unregister<LinkService>();
      await getIt.unregister<ClipboardService>();
    });

    testWidgets('S5-37: archived; Done shows Welcome', (
      WidgetTester tester,
    ) async {
      await pumpWelcome(
        tester,
        farewell: const SessionFarewell.archived(
          provider: ProviderId.google,
          renamedFile: 'vault.removed-2026-10-29T14-32-00.json.enc',
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Your vault file has been renamed'), findsOneWidget);
      expect(
        find.bySemanticsLabel(
          RegExp(
            RegExp.escape(
              'Google Drive › keeperpass/vault.removed-2026-10-29T14-32-00.json.enc',
            ),
          ),
        ),
        findsOneWidget,
      );
      expect(find.text('You are signed out on this phone.'), findsOneWidget);

      await tester.tap(find.bySemanticsLabel('Copy file name'));
      await tester.pump();
      expect(clipboard.copied, <String>[
        'vault.removed-2026-10-29T14-32-00.json.enc',
      ]);
      expect(find.text('File name copied'), findsOneWidget);
      await tester.pump(const Duration(seconds: 5));

      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();
      expect(find.text('Your vault file has been renamed'), findsNothing);
      expect(connect.signIns, isEmpty);
    });

    testWidgets('S5-29: moved; Continue with Dropbox signs in there', (
      WidgetTester tester,
    ) async {
      await pumpWelcome(
        tester,
        farewell: const SessionFarewell.moved(
          from: ProviderId.google,
          to: ProviderId.dropbox,
          renamedFile: 'vault.removed-2026-10-29T14-32-00.json.enc',
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Your vault now lives in Dropbox'), findsOneWidget);
      expect(find.text('Saved to Dropbox'), findsOneWidget);
      expect(
        find.bySemanticsLabel(
          RegExp(
            RegExp.escape(
              'keeperpass/vault.removed-2026-10-29T14-32-00.json.enc',
            ),
          ),
        ),
        findsOneWidget,
      );

      await tester.tap(find.text('Continue with Dropbox'));
      await tester.pumpAndSettle();
      expect(connect.signIns, <ProviderId>[ProviderId.dropbox]);
    });

    testWidgets('S5-30: copied, the old file kept its name', (
      WidgetTester tester,
    ) async {
      await pumpWelcome(
        tester,
        farewell: const SessionFarewell.moved(
          from: ProviderId.google,
          to: ProviderId.dropbox,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Your vault was copied to Dropbox'), findsOneWidget);
      expect(
        find.bySemanticsLabel(
          RegExp(RegExp.escape('Google Drive › keeperpass/vault.json.enc')),
        ),
        findsOneWidget,
      );
      await tester.tap(find.text('Open Google Drive'));
      await tester.pump();
      expect(links.opened, <Uri>[AppLinks.googleDrive]);
    });
  });
}
