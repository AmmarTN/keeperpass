// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [ComponentGalleryPage]
class ComponentGalleryRoute extends PageRouteInfo<void> {
  const ComponentGalleryRoute({List<PageRouteInfo>? children})
    : super(ComponentGalleryRoute.name, initialChildren: children);

  static const String name = 'ComponentGalleryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ComponentGalleryPage();
    },
  );
}

/// generated route for
/// [CreateVaultPage]
class CreateVaultRoute extends PageRouteInfo<void> {
  const CreateVaultRoute({List<PageRouteInfo>? children})
    : super(CreateVaultRoute.name, initialChildren: children);

  static const String name = 'CreateVaultRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CreateVaultPage());
    },
  );
}

/// generated route for
/// [DesignTokensPage]
class DesignTokensRoute extends PageRouteInfo<void> {
  const DesignTokensRoute({List<PageRouteInfo>? children})
    : super(DesignTokensRoute.name, initialChildren: children);

  static const String name = 'DesignTokensRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DesignTokensPage();
    },
  );
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const HomePage());
    },
  );
}

/// generated route for
/// [NewVaultPage]
class NewVaultRoute extends PageRouteInfo<void> {
  const NewVaultRoute({List<PageRouteInfo>? children})
    : super(NewVaultRoute.name, initialChildren: children);

  static const String name = 'NewVaultRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const NewVaultPage());
    },
  );
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashPage();
    },
  );
}

/// generated route for
/// [UnlockPage]
class UnlockRoute extends PageRouteInfo<UnlockRouteArgs> {
  UnlockRoute({
    bool fromLaunch = false,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         UnlockRoute.name,
         args: UnlockRouteArgs(fromLaunch: fromLaunch, key: key),
         initialChildren: children,
       );

  static const String name = 'UnlockRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UnlockRouteArgs>(
        orElse: () => const UnlockRouteArgs(),
      );
      return WrappedRoute(
        child: UnlockPage(fromLaunch: args.fromLaunch, key: args.key),
      );
    },
  );
}

class UnlockRouteArgs {
  const UnlockRouteArgs({this.fromLaunch = false, this.key});

  final bool fromLaunch;

  final Key? key;

  @override
  String toString() {
    return 'UnlockRouteArgs{fromLaunch: $fromLaunch, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UnlockRouteArgs) return false;
    return fromLaunch == other.fromLaunch && key == other.key;
  }

  @override
  int get hashCode => fromLaunch.hashCode ^ key.hashCode;
}

/// generated route for
/// [WelcomePage]
class WelcomeRoute extends PageRouteInfo<WelcomeRouteArgs> {
  WelcomeRoute({
    bool fromLaunch = false,
    SessionFarewell? farewell,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         WelcomeRoute.name,
         args: WelcomeRouteArgs(
           fromLaunch: fromLaunch,
           farewell: farewell,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'WelcomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WelcomeRouteArgs>(
        orElse: () => const WelcomeRouteArgs(),
      );
      return WrappedRoute(
        child: WelcomePage(
          fromLaunch: args.fromLaunch,
          farewell: args.farewell,
          key: args.key,
        ),
      );
    },
  );
}

class WelcomeRouteArgs {
  const WelcomeRouteArgs({this.fromLaunch = false, this.farewell, this.key});

  final bool fromLaunch;

  final SessionFarewell? farewell;

  final Key? key;

  @override
  String toString() {
    return 'WelcomeRouteArgs{fromLaunch: $fromLaunch, farewell: $farewell, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WelcomeRouteArgs) return false;
    return fromLaunch == other.fromLaunch &&
        farewell == other.farewell &&
        key == other.key;
  }

  @override
  int get hashCode => fromLaunch.hashCode ^ farewell.hashCode ^ key.hashCode;
}
