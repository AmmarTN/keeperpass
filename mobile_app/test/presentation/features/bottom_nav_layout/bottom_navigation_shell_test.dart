import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/presentation/common/cubit/bottom_nav_bar/bottom_nav_cubit.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_tab_bar.dart';
import 'package:keeperpass/presentation/features/bottom_nav_layout/models/bottom_nav_destination.dart';
import 'package:keeperpass/presentation/features/bottom_nav_layout/widgets/bottom_navigation_shell.dart';

import '../../../helpers/screen_harness.dart';

void main() {
  late BottomNavCubit tabs;

  setUp(() => tabs = BottomNavCubit());
  tearDown(() => tabs.close());

  Future<void> pumpShell(WidgetTester tester) => pumpScreen(
    tester,
    BottomNavigationShell(
      destinations: <BottomNavDestination>[
        for (final String name in <String>['Vault', 'Codes'])
          BottomNavDestination(
            label: name,
            icon: AppIconName.layers,
            builder: (_) => Scaffold(body: Center(child: Text('$name page'))),
          ),
      ],
    ),
    providers: <BlocProvider<dynamic>>[
      BlocProvider<BottomNavCubit>.value(value: tabs),
    ],
  );

  testWidgets('toasts sit just above the tab bar', (WidgetTester tester) async {
    await pumpShell(tester);
    final AppToastHostState toasts = tester.state(find.byType(AppToastHost));
    expect(toasts.bottomOffset.value, greaterThan(40));
  });

  testWidgets('selection mode hides the tab bar', (WidgetTester tester) async {
    await pumpShell(tester);
    expect(find.byType(AppTabBar), findsOneWidget);

    tabs.setBarHidden(true);
    await tester.pump();
    await tester.pump();
    expect(find.byType(AppTabBar), findsNothing);

    tabs.setBarHidden(false);
    await tester.pump();
    await tester.pump();
    expect(find.byType(AppTabBar), findsOneWidget);
  });
}
