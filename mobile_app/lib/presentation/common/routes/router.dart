import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/features/bottom_nav_layout/pages/home_page.dart';
import 'package:keeperpass/presentation/features/component_gallery/pages/component_gallery_page.dart';
import 'package:keeperpass/presentation/features/create_vault/pages/create_vault_page.dart';
import 'package:keeperpass/presentation/features/design_tokens/pages/design_tokens_page.dart';
import 'package:keeperpass/presentation/features/new_vault/pages/new_vault_page.dart';
import 'package:keeperpass/presentation/features/splash_page/pages/splash_page.dart';
import 'package:keeperpass/presentation/features/unlock/pages/unlock_page.dart';
import 'package:keeperpass/presentation/features/welcome/pages/welcome_page.dart';

part 'router.gr.dart';

/// Push and back keep each platform's own motion (board: Motion and haptics),
/// so routes use the adaptive (Cupertino on iOS, Material on Android) type.
@AutoRouterConfig(replaceInRouteName: 'Page,Route')
final class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  /// Steps of the sign-in flow replace each other with a cross-fade
  /// (boards `U2-*`: "Unlock cross-fades in").
  static CustomRoute<void> _flow(PageInfo page, String path) =>
      CustomRoute<void>(
        page: page,
        path: path,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        duration: const Duration(milliseconds: 250),
        reverseDuration: const Duration(milliseconds: 200),
      );

  @override
  List<AutoRoute> get routes => <AutoRoute>[
    CustomRoute<void>(
      page: SplashRoute.page,
      path: '/',
      initial: true,
      transitionsBuilder: TransitionsBuilders.noTransition,
    ),
    _flow(WelcomeRoute.page, '/welcome'),
    _flow(UnlockRoute.page, '/unlock'),
    _flow(CreateVaultRoute.page, '/create'),
    AutoRoute(page: NewVaultRoute.page, path: '/new-vault'),
    // The unlocked app: five tabs (Part 7).
    _flow(HomeRoute.page, '/vault'),
    // Debug builds only: the design-system reference pages.
    if (kDebugMode) ...<AutoRoute>[
      AutoRoute(page: DesignTokensRoute.page, path: '/debug/design-tokens'),
      AutoRoute(page: ComponentGalleryRoute.page, path: '/debug/components'),
    ],
  ];
}
