import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/common/cubit/audit/audit_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/bottom_nav_bar/bottom_nav_cubit.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/features/bottom_nav_layout/models/bottom_nav_destination.dart';
import 'package:keeperpass/presentation/features/bottom_nav_layout/widgets/bottom_navigation_shell.dart';
import 'package:keeperpass/presentation/features/codes/pages/codes_page.dart';
import 'package:keeperpass/presentation/features/generator/pages/generator_page.dart';
import 'package:keeperpass/presentation/features/security/pages/security_page.dart';
import 'package:keeperpass/presentation/features/settings/pages/settings_page.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_cubit.dart';
import 'package:keeperpass/presentation/features/vault_list/pages/vault_list_page.dart';

/// The unlocked app (board C4): five tabs, each with its own back history —
/// Vault, Codes, Generator, Security (with the flagged-item count) and
/// Settings.
@RoutePage()
class HomePage extends StatelessWidget implements AutoRouteWrapper {
  const HomePage({super.key});

  /// The Vault list's cubit lives here, above the tabs: the Security
  /// report's "Show all" filters it (Part 11).
  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
    providers: <BlocProvider<dynamic>>[
      BlocProvider<BottomNavCubit>(create: (_) => getIt<BottomNavCubit>()),
      BlocProvider<VaultListCubit>(create: (_) => getIt<VaultListCubit>()),
    ],
    child: this,
  );

  @override
  Widget build(BuildContext context) {
    final int flagged = context.select(
      (AuditCubit audit) => audit.state.flaggedCount,
    );
    return BottomNavigationShell(
      destinations: <BottomNavDestination>[
        BottomNavDestination(
          label: t.tabs.vault,
          icon: AppIconName.layers,
          builder: (_) => const VaultListPage(),
        ),
        BottomNavDestination(
          label: t.tabs.codes,
          icon: AppIconName.timer,
          builder: (_) => const CodesPage(),
        ),
        BottomNavDestination(
          label: t.tabs.generator,
          icon: AppIconName.wandSparkles,
          builder: (_) => const GeneratorPage(),
        ),
        BottomNavDestination(
          label: t.tabs.security,
          icon: AppIconName.shieldCheck,
          badgeCount: flagged,
          semanticLabel: flagged == 0
              ? null
              : t.tabs.securityFlagged(n: flagged),
          builder: (_) => const SecurityPage(),
        ),
        BottomNavDestination(
          label: t.tabs.settings,
          icon: AppIconName.settings,
          builder: (_) => const SettingsPage(),
        ),
      ],
    );
  }
}
