import 'dart:async';
import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keeperpass/core/enums/auto_lock_delay.dart';
import 'package:keeperpass/core/enums/lock_reason.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/extensions/failures.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/common/cubit/connectivity/connectivity_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/lock/lock_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/common/routes/router.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_fixed_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_haptics.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/utils/provider_ui.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_backdrop.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_small_button.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_avatar.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_unlock_dial.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_banner.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_secret_field.dart';
import 'package:keeperpass/presentation/common/widgets/text/secret_text.dart';
import 'package:keeperpass/presentation/features/unlock/cubit/unlock_cubit.dart';

/// Unlock (board `U2-Unlock`): the vault dial holding the account, one field
/// and one button above the keyboard. The arc turns while the key is
/// derived; a wrong secret rings the dial red with a shake.
@RoutePage()
class UnlockPage extends StatelessWidget implements AutoRouteWrapper {
  const UnlockPage({this.fromLaunch = false, super.key});

  /// Arriving from the launch screen: the mark heads for the dial.
  final bool fromLaunch;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<UnlockCubit>(
    create: (_) => getIt<UnlockCubit>()..refreshProfile(),
    child: this,
  );

  @override
  Widget build(BuildContext context) => _UnlockView(fromLaunch: fromLaunch);
}

class _UnlockView extends StatefulWidget {
  const _UnlockView({required this.fromLaunch});

  final bool fromLaunch;

  @override
  State<_UnlockView> createState() => _UnlockViewState();
}

class _UnlockViewState extends State<_UnlockView>
    with TickerProviderStateMixin {
  final SecretTextEditingController _secret = SecretTextEditingController();
  final FocusNode _focus = FocusNode();

  /// The wrong-secret shake (board C6 motion: 400 ms, 3 cycles, 8 pt).
  late final AnimationController _shake = AnimationController(
    vsync: this,
    duration: AppMotion.shake,
  );

  /// The returning person's launch: mark → dial, ticks draw in (700 ms).
  late final AnimationController _launch = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
    value: widget.fromLaunch ? 0 : 1,
  );

  Timer? _redRing;
  bool _ringRed = false;
  bool _reduceMotion = false;

  @override
  void initState() {
    super.initState();
    _secret.addListener(() => setState(() {}));
    _launch.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) _focus.requestFocus();
    });
    if (!widget.fromLaunch) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _focus.requestFocus();
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reduceMotion = AppMotion.reduceMotion(context);
    if (widget.fromLaunch && _launch.value == 0 && !_launch.isAnimating) {
      if (_reduceMotion) _launch.duration = AppMotion.fast;
      _launch.forward();
    }
  }

  @override
  void dispose() {
    _redRing?.cancel();
    _secret.dispose();
    _focus.dispose();
    _shake.dispose();
    _launch.dispose();
    super.dispose();
  }

  void _unlock() => context.read<UnlockCubit>().unlock(_secret.text);

  void _wrongSecret() {
    AppHaptics.wrongSecret();
    _redRing?.cancel();
    setState(() => _ringRed = true);
    _redRing = Timer(const Duration(milliseconds: 600), () {
      if (mounted) setState(() => _ringRed = false);
    });
    if (!_reduceMotion) _shake.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);

    return BlocListener<UnlockCubit, UnlockState>(
      listenWhen: (UnlockState a, UnlockState b) =>
          a.wrongAttempts != b.wrongAttempts,
      listener: (_, _) => _wrongSecret(),
      child: Scaffold(
        backgroundColor: colors.background,
        body: Stack(
          children: <Widget>[
            const Positioned.fill(
              child: AppBackdrop(glowLeft: -74, glowTop: -90),
            ),
            SafeArea(
              bottom: false,
              child: Builder(
                builder: (BuildContext context) {
                  final SessionState session = context
                      .watch<SessionCubit>()
                      .state;
                  final UnlockState unlock = context.watch<UnlockCubit>().state;
                  final AutoLockDelay delay = context.watch<LockCubit>().state;
                  final bool offline =
                      context.watch<ConnectivityCubit>().state
                          is ConnectivityDisconnected;
                  final ProviderAccount? account = session.account;
                  if (account == null) return const SizedBox.shrink();
                  final bool unlocking =
                      unlock.status == UnlockStatus.unlocking;
                  final String storage = account.provider.storageName;
                  final String? reason = switch (session.lockReason) {
                    LockReason.inactivity => t.unlock.lockedInactivity(
                      n: delay.duration.inMinutes,
                    ),
                    LockReason.leftApp => t.unlock.leftApp,
                    _ => null,
                  };

                  return SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 24.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        if (reason != null) ...<Widget>[
                          Center(child: _ReasonPill(reason)),
                          SizedBox(height: 14.h),
                        ],
                        Center(
                          child: ExcludeSemantics(
                            child: AnimatedBuilder(
                              animation: Listenable.merge(<Listenable>[
                                _shake,
                                _launch,
                              ]),
                              builder: (BuildContext context, _) {
                                final double reveal = _reduceMotion
                                    ? 1
                                    : ((_launch.value * 700 - 180) / 240).clamp(
                                        0.0,
                                        1.0,
                                      );
                                return Transform.translate(
                                  offset: Offset(
                                    math.sin(
                                          _shake.value *
                                              math.pi *
                                              2 *
                                              AppMotion.shakeCycles,
                                        ) *
                                        AppMotion.shakeDistance.w *
                                        (1 - _shake.value),
                                    0,
                                  ),
                                  child: AppUnlockDial(
                                    size: 156,
                                    tickReveal: reveal,
                                    state: unlocking
                                        ? AppDialState.turning
                                        : _ringRed
                                        ? AppDialState.error
                                        : AppDialState.resting,
                                    child: Opacity(
                                      opacity: reveal,
                                      child: AppAvatar(
                                        initials: account.initials,
                                        provider: account.provider.logo,
                                        size: 64,
                                        badgeRing: colors.card,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Semantics(
                          container: true,
                          child: Column(
                            children: <Widget>[
                              Text(
                                account.displayName,
                                textAlign: TextAlign.center,
                                style: styles.title().copyWith(
                                  color: colors.foreground,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                t.unlock.accountLine(
                                  email: account.email,
                                  storage: storage,
                                ),
                                textAlign: TextAlign.center,
                                style: styles.secondary().copyWith(
                                  color: colors.mutedForeground,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (unlocking) ...<Widget>[
                          SizedBox(height: 6.h),
                          Semantics(
                            liveRegion: true,
                            child: Text(
                              t.unlock.unlockingStatus,
                              textAlign: TextAlign.center,
                              style: styles
                                  .secondary()
                                  .resized(
                                    13,
                                    line: 18,
                                    weight: FontWeight.w700,
                                  )
                                  .copyWith(color: colors.accentStrong),
                            ),
                          ),
                        ] else
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 2.w,
                              children: <Widget>[
                                Text(
                                  t.unlock.notYou,
                                  style: styles.secondary().copyWith(
                                    color: colors.mutedForeground,
                                  ),
                                ),
                                AppLinkButton(
                                  label: t.common.disconnect,
                                  fontSize: 13,
                                  horizontalPadding: 4,
                                  onPressed: context
                                      .read<UnlockCubit>()
                                      .disconnect,
                                ),
                              ],
                            ),
                          ),
                        SizedBox(height: 20.h),
                        Semantics(
                          label: t.unlock.secret,
                          child: AppSecretField(
                            controller: _secret,
                            focusNode: _focus,
                            large: true,
                            placeholder: t.unlock.placeholder,
                            textInputAction: TextInputAction.go,
                            autofillHints: const <String>[
                              AutofillHints.password,
                            ],
                            onSubmitted: offline || unlocking
                                ? null
                                : (_) => _unlock(),
                            errorText: switch (unlock.status) {
                              UnlockStatus.wrongSecret =>
                                t.auth.unlock.incorrectSecret,
                              UnlockStatus.failed =>
                                unlock.failure?.getMessage(),
                              _ => null,
                            },
                          ),
                        ),
                        if (unlock.status == UnlockStatus.unreachable &&
                            !offline) ...<Widget>[
                          SizedBox(height: 12.h),
                          AppBanner(
                            tone: AppBannerTone.error,
                            icon: AppIconName.cloudOff,
                            title: t.unlock.unreachableTitle(storage: storage),
                            body: t.unlock.unreachableDetail,
                            actions: <Widget>[
                              AppSmallButton(
                                label: t.common.retry,
                                icon: AppIconName.rotateCw,
                                onPressed: _unlock,
                              ),
                            ],
                          ),
                        ],
                        if (offline) ...<Widget>[
                          SizedBox(height: 12.h),
                          AppBanner(
                            tone: AppBannerTone.neutral,
                            icon: AppIconName.wifiOff,
                            title: t.common.offlineTitle,
                            body: t.unlock.offlineDetail(storage: storage),
                            // Board `Lock-privacy`, Offline: check again;
                            // the secret typed is kept.
                            actions: <Widget>[
                              AppSmallButton(
                                label: t.common.tryAgain,
                                icon: AppIconName.rotateCw,
                                variant: AppSmallButtonVariant.outlined,
                                onPressed: () => unawaited(
                                  context.read<ConnectivityCubit>().recheck(),
                                ),
                              ),
                            ],
                          ),
                        ],
                        SizedBox(height: 12.h),
                        AppButton(
                          label: unlocking
                              ? t.unlock.unlocking
                              : t.unlock.unlock,
                          onPressed:
                              _secret.text.isEmpty || offline || unlocking
                              ? null
                              : _unlock,
                        ),
                        if (unlocking) ...<Widget>[
                          SizedBox(height: 12.h),
                          Text(
                            t.unlock.slowNote,
                            textAlign: TextAlign.center,
                            style: styles.secondary().copyWith(
                              color: colors.mutedForeground,
                            ),
                          ),
                        ],
                        SizedBox(height: 12.h),
                        Center(
                          child: AppLinkButton(
                            label: t.unlock.forgot,
                            onPressed: unlocking
                                ? null
                                : () => context.router.push(
                                    const NewVaultRoute(),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            if (widget.fromLaunch)
              _LaunchToDial(animation: _launch, reduceMotion: _reduceMotion),
          ],
        ),
      ),
    );
  }
}

/// "Locked after 10 minutes of inactivity" (`.spill`).
class _ReasonPill extends StatelessWidget {
  const _ReasonPill(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return Semantics(
      liveRegion: true,
      child: Container(
        constraints: BoxConstraints(minHeight: 32.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: ShapeDecoration(
          color: colors.secondary,
          shape: const StadiumBorder(),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8.w,
          children: <Widget>[
            AppIcon(
              AppIconName.timer,
              size: AppIconSizes.sm,
              stroke: 2,
              color: colors.mutedForeground,
            ),
            Flexible(
              child: Text(
                text,
                style: AppTextStyles(context)
                    .secondary()
                    .resized(13, line: 18, weight: FontWeight.w600)
                    .copyWith(color: colors.foreground),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The launch screen for a returning person: black gives way while the mark
/// heads for the centre of the dial (0–180 ms) and cross-fades into the
/// avatar as the ticks draw in (180–420 ms). Under Reduce Motion it only
/// fades (150 ms).
class _LaunchToDial extends StatelessWidget {
  const _LaunchToDial({required this.animation, required this.reduceMotion});

  final Animation<double> animation;
  final bool reduceMotion;

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.sizeOf(context);
    final double safeTop = MediaQuery.paddingOf(context).top;
    const double markAspect = 142.5 / 120;
    final Rect from = Rect.fromCenter(
      center: screen.center(Offset.zero),
      width: 120,
      height: 120 * markAspect,
    );
    final Rect to = Rect.fromCenter(
      center: Offset(screen.width / 2, safeTop + 12.h + 78.r),
      width: 36.r,
      height: 36.r * markAspect,
    );

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, _) {
          if (reduceMotion) {
            return Opacity(
              opacity: 1 - animation.value,
              child: const ColoredBox(color: AppFixedColors.markBackground),
            );
          }
          final double ms = animation.value * 700;
          if (ms >= 420) return const SizedBox.shrink();
          final double lift = Curves.easeOut.transform((ms / 180).clamp(0, 1));
          final double seat = ((ms - 180) / 240).clamp(0, 1);
          return Stack(
            children: <Widget>[
              Positioned.fill(
                child: Opacity(
                  opacity: ms < 180 ? 1 - 0.45 * lift : 0.55 * (1 - seat),
                  child: const ColoredBox(color: AppFixedColors.markBackground),
                ),
              ),
              Positioned.fromRect(
                rect: Rect.lerp(from, to, lift)!,
                child: Opacity(
                  opacity: 1 - seat,
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
