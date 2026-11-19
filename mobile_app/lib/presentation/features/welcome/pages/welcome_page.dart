import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/services/clipboard_service.dart';
import 'package:keeperpass/infrastructure/services/link_service.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/common/cubit/connectivity/connectivity_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/common/routes/router.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_fixed_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/utils/provider_ui.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_backdrop.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_vault_file_card.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/features/farewell/pages/farewell_page.dart';
import 'package:keeperpass/presentation/features/how_it_works/widgets/how_it_works_sheet.dart';
import 'package:keeperpass/presentation/features/technical_details/widgets/technical_details_sheet.dart';
import 'package:keeperpass/presentation/features/welcome/cubit/connect_cubit.dart';
import 'package:keeperpass/presentation/features/welcome/widgets/welcome_dock.dart';
import 'package:keeperpass/presentation/features/welcome/widgets/welcome_hero.dart';

/// Welcome and Connect (boards `U2-Launch`, `U2-Connect`): a hero and a dock.
/// Signing in, checking for the vault and every outcome happen on this one
/// screen; it then hands over to Unlock or Create.
@RoutePage()
class WelcomePage extends StatelessWidget implements AutoRouteWrapper {
  const WelcomePage({this.fromLaunch = false, this.farewell, super.key});

  /// Arriving from the launch screen: the mark travels into the wordmark.
  final bool fromLaunch;

  /// Signed out by archiving or moving the vault: what happened, shown over
  /// this screen (boards `S5-29`, `S5-30`, `S5-37`).
  final SessionFarewell? farewell;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<ConnectCubit>(
    create: (_) => getIt<ConnectCubit>(),
    child: this,
  );

  @override
  Widget build(BuildContext context) {
    return _WelcomeView(fromLaunch: fromLaunch, farewell: farewell);
  }
}

class _WelcomeView extends StatefulWidget {
  const _WelcomeView({required this.fromLaunch, this.farewell});

  final bool fromLaunch;
  final SessionFarewell? farewell;

  @override
  State<_WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<_WelcomeView>
    with SingleTickerProviderStateMixin {
  /// The launch motion, 700 ms (board `U2-Launch` 03 · Motion): lift
  /// (0–180), arrive (180–420), settle (420–700).
  late final AnimationController _launch = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
    value: widget.fromLaunch ? 0 : 1,
  );
  final GlobalKey _dockKey = GlobalKey();
  late AppToastHostState _toasts;
  bool _reduceMotion = false;

  @override
  void initState() {
    super.initState();
    final SessionFarewell? farewell = widget.farewell;
    if (farewell != null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _showFarewell(farewell),
      );
    }
  }

  /// Already on top as Welcome arrives, so the move or archive ends on its
  /// outcome; "Continue with Dropbox" signs in from here.
  Future<void> _showFarewell(SessionFarewell farewell) async {
    if (!mounted) return;
    final ConnectCubit connect = context.read<ConnectCubit>();
    final ProviderId? next = await Navigator.of(context).push<ProviderId>(
      PageRouteBuilder<ProviderId>(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: AppMotion.enter,
        pageBuilder: (_, _, _) => FarewellPage(
          farewell: farewell,
          links: getIt<LinkService>(),
          clipboard: getIt<ClipboardService>(),
        ),
        transitionsBuilder: (_, Animation<double> animation, _, Widget child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
    if (next != null && mounted) await connect.signIn(next);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _toasts = AppToastHost.of(context);
    _reduceMotion = AppMotion.reduceMotion(context);
    if (widget.fromLaunch && _launch.value == 0 && !_launch.isAnimating) {
      if (_reduceMotion) {
        // One 150 ms cross-fade instead of the move.
        _launch.duration = AppMotion.fast;
      }
      _launch.forward();
    }
  }

  @override
  void dispose() {
    _toasts.bottomOffset.value = 0;
    _launch.dispose();
    super.dispose();
  }

  Animation<double> _interval(double begin, double end, [Curve? curve]) =>
      _reduceMotion
      ? const AlwaysStoppedAnimation<double>(1)
      : CurvedAnimation(
          parent: _launch,
          curve: Interval(
            begin / 700,
            end / 700,
            curve: curve ?? AppMotion.easeOut,
          ),
        );

  void _showCancelled() {
    final RenderBox? dock =
        _dockKey.currentContext?.findRenderObject() as RenderBox?;
    if (dock != null) {
      _toasts.bottomOffset.value =
          dock.size.height - MediaQuery.paddingOf(context).bottom;
    }
    _toasts.show(
      AppToastData(
        icon: AppIconName.info,
        title: t.errors.vault.signInCanceled,
        detail: t.connect.canceledDetail,
        visible: const Duration(seconds: 4),
      ),
    );
  }

  void _openHowItWorks() {
    final ConnectCubit connect = context.read<ConnectCubit>();
    showHowItWorks(
      context,
      onTechnicalDetails: () => showTechnicalDetailsSheet(
        context,
        onViewSource: connect.openSourceCode,
      ),
    );
  }

  void _navigate(ConnectDestination destination) {
    context.read<ConnectCubit>().destinationHandled();
    context.router.replaceAll(<PageRouteInfo>[
      switch (destination) {
        ConnectDestination.unlock => UnlockRoute(),
        ConnectDestination.create => const CreateVaultRoute(),
      },
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final double safeTop = MediaQuery.paddingOf(context).top;

    return BlocListener<ConnectCubit, ConnectState>(
      listenWhen: (ConnectState a, ConnectState b) =>
          a.destination != b.destination || a.cancelled != b.cancelled,
      listener: (BuildContext context, ConnectState state) {
        final ConnectDestination? destination = state.destination;
        if (destination != null) {
          _navigate(destination);
        } else {
          _showCancelled();
        }
      },
      child: Scaffold(
        backgroundColor: colors.background,
        resizeToAvoidBottomInset: false,
        body: BackdropGroup(
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: FadeTransition(
                  opacity: _interval(180, 420),
                  child: const AppBackdrop(
                    glowLeft: 110,
                    glowTop: -220,
                    dots: true,
                  ),
                ),
              ),
              Builder(
                builder: (BuildContext context) {
                  final SessionState session = context
                      .watch<SessionCubit>()
                      .state;
                  final ConnectState connect = context
                      .watch<ConnectCubit>()
                      .state;
                  final bool offline =
                      context.watch<ConnectivityCubit>().state
                          is ConnectivityDisconnected;
                  final ProviderAccount? account = session.account;
                  final bool returning =
                      session.expired &&
                      account != null &&
                      connect.stage == ConnectStage.idle;

                  return Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(height: safeTop),
                          AnimatedBuilder(
                            animation: _launch,
                            builder: (BuildContext context, _) => WelcomeTopBar(
                              onHowItWorks: _openHowItWorks,
                              wordmarkOpacity: _interval(180, 420).value,
                              pillOpacity: _interval(180, 420).value,
                            ),
                          ),
                          _Rise(
                            animation: _interval(180, 420),
                            child: WelcomeHeadline(
                              showBadge: !returning,
                              title: returning
                                  ? '${t.connect.welcomeBack}\n${_firstName(account)}'
                                  : t.welcome.title,
                              description: returning
                                  ? t.connect.expiredDetail(
                                      provider: account.provider.displayName,
                                    )
                                  : t.welcome.description,
                            ),
                          ),
                          _Drop(
                            animation: _interval(420, 700),
                            child: WelcomeCard(
                              card: _card(connect, session.account),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.62),
                            end: Offset.zero,
                          ).animate(_interval(420, 700, Curves.easeOutBack)),
                          child: KeyedSubtree(
                            key: _dockKey,
                            child: WelcomeDock(
                              data: WelcomeDockData(
                                connect: connect,
                                providers: context
                                    .read<SessionCubit>()
                                    .availableProviders,
                                offline: offline,
                                account: account,
                                returning: returning,
                              ),
                              onSignIn: context.read<ConnectCubit>().signIn,
                              onUseAnotherAccount: context
                                  .read<ConnectCubit>()
                                  .useAnotherAccount,
                              onRetryCheck: context
                                  .read<ConnectCubit>()
                                  .retryCheck,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              if (widget.fromLaunch)
                _LaunchOverlay(
                  animation: _launch,
                  reduceMotion: _reduceMotion,
                  safeTop: safeTop,
                ),
            ],
          ),
        ),
      ),
    );
  }

  static String _firstName(ProviderAccount account) => account.name.isEmpty
      ? account.email
      : account.name.trim().split(RegExp(r'\s+')).first;

  AppVaultFileCard _card(ConnectState connect, ProviderAccount? account) {
    final ProviderId? provider = account?.provider;
    return switch (connect.stage) {
      ConnectStage.checking => AppVaultFileCard(
        fileName: 'vault.json.enc',
        meta: t.connect.lookingIn(storage: provider!.storageName),
        provider: provider.logo,
        badge: AppVaultFileBadge.working,
        skeleton: true,
      ),
      ConnectStage.found => AppVaultFileCard(
        fileName: 'vault.json.enc',
        meta: connect.foundMeta ?? '',
        cipherPreview: kCipherPreview,
      ),
      ConnectStage.checkFailed => AppVaultFileCard(
        fileName: 'vault.json.enc',
        meta: t.connect.checkFailedMeta(storage: provider!.storageName),
        icon: AppIconName.cloudAlert,
        tone: AppVaultFileTone.destructive,
        badge: AppVaultFileBadge.failed,
        skeleton: true,
      ),
      _ => restingCard(),
    };
  }
}

/// Fades in while rising 10 pt (the headline, "Arrive").
class _Rise extends StatelessWidget {
  const _Rise({required this.animation, required this.child});

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) => Transform.translate(
          offset: Offset(0, (1 - animation.value) * 10.h),
          child: child,
        ),
        child: child,
      ),
    );
  }
}

/// Drops into place (the card, "Settle").
class _Drop extends StatelessWidget {
  const _Drop({required this.animation, required this.child});

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) => Transform.translate(
          offset: Offset(0, -(1 - animation.value) * 16.h),
          child: child,
        ),
        child: child,
      ),
    );
  }
}

/// The launch screen, continued: black gives way to the theme while the
/// white mark lifts into the wordmark (0–180 ms) and lands there
/// (180–420 ms). Under Reduce Motion it only fades (150 ms).
class _LaunchOverlay extends StatelessWidget {
  const _LaunchOverlay({
    required this.animation,
    required this.reduceMotion,
    required this.safeTop,
  });

  final Animation<double> animation;
  final bool reduceMotion;
  final double safeTop;

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.sizeOf(context);
    // The native launch screen: the mark 120 pt wide, centred.
    const double markAspect = 142.5 / 120;
    final Rect from = Rect.fromCenter(
      center: screen.center(Offset.zero),
      width: 120,
      height: 120 * markAspect,
    );
    // The wordmark's own mark: 19 pt wide at the bar's start.
    final double toWidth = 19.r;
    final Rect to = Rect.fromLTWH(
      24.w,
      safeTop + (44.h - 22.r) / 2,
      toWidth,
      toWidth * markAspect,
    );

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, _) {
          final double ms = animation.value * (reduceMotion ? 150 : 700);
          if (reduceMotion) {
            return Opacity(opacity: 1 - animation.value, child: const _Black());
          }
          if (ms >= 420) return const SizedBox.shrink();
          final double lift = Curves.easeOut.transform((ms / 180).clamp(0, 1));
          final double arrive = ((ms - 180) / 240).clamp(0, 1);
          final Rect mark = Rect.lerp(from, to, lift)!;
          final double black = ms < 180 ? 1 - 0.45 * lift : 0.55 * (1 - arrive);
          return Stack(
            children: <Widget>[
              Positioned.fill(
                child: Opacity(opacity: black, child: const _Black()),
              ),
              Positioned.fromRect(
                rect: mark,
                child: Opacity(
                  opacity: 1 - arrive,
                  child: SvgPicture.asset(
                    'assets/icons/svg/keeperpass_mark.svg',
                    colorFilter: ColorFilter.mode(
                      Color.lerp(
                        AppFixedColors.markForeground,
                        context.colors.foreground,
                        lift,
                      )!,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Black extends StatelessWidget {
  const _Black();

  @override
  Widget build(BuildContext context) =>
      const ColoredBox(color: AppFixedColors.markBackground);
}
