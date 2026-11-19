import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/app.dart';
import 'package:keeperpass/core/enums/session_phase.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/services/clipboard_service.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/common/constants/ui_constants.dart';
import 'package:keeperpass/presentation/common/cubit/audit/audit_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/connectivity/connectivity_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/language/language_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/lock/lock_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/sync/sync_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/theme/theme_cubit.dart';
import 'package:keeperpass/presentation/common/routes/router.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_theme_data.dart';
import 'package:keeperpass/presentation/common/widgets/connectivity_banner.dart';
import 'package:keeperpass/presentation/common/widgets/dismiss_keyboard.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/saving_pill_host.dart';
import 'package:keeperpass/presentation/common/widgets/scroll_behaviors/no_glow_scroll_behavior.dart';
import 'package:keeperpass/presentation/features/sync/widgets/system_prompts.dart';

class KeeperPassAppProvided extends StatelessWidget {
  const KeeperPassAppProvided({super.key});

  @override
  Widget build(BuildContext context) {
    return TranslationProvider(
      child: MultiBlocProvider(
        providers: <BlocProvider<dynamic>>[
          BlocProvider<LanguageCubit>(
            lazy: false,
            create: (_) => getIt<LanguageCubit>()..restore(),
          ),
          BlocProvider<ThemeCubit>(
            lazy: false,
            create: (_) => getIt<ThemeCubit>()..restore(),
          ),
          BlocProvider<ConnectivityCubit>(
            lazy: false,
            create: (_) => getIt<ConnectivityCubit>()..start(),
          ),
          // The remembered sign-in (D10); the secret is always asked.
          BlocProvider<SessionCubit>(
            lazy: false,
            create: (_) => getIt<SessionCubit>()..restore(),
          ),
          BlocProvider<LockCubit>(
            lazy: false,
            create: (_) => getIt<LockCubit>()..start(),
          ),
          BlocProvider<SyncCubit>(
            lazy: false,
            create: (_) => getIt<SyncCubit>(),
          ),
          // The security audit, run after every unlock (web `AuditService`).
          BlocProvider<AuditCubit>(
            lazy: false,
            create: (_) => getIt<AuditCubit>()..start(),
          ),
        ],
        child: const KeeperPassApp(),
      ),
    );
  }
}

class KeeperPassApp extends StatelessWidget {
  const KeeperPassApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeMode themeMode = context.select(
      (ThemeCubit cubit) => cubit.themeMode,
    );

    return BlocBuilder<LanguageCubit, LocaleLanguage>(
      builder: (BuildContext context, LocaleLanguage language) {
        return ScreenUtilInit(
          designSize: UiConstants.designSize,
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (BuildContext context, Widget? child) {
            final AppConfig config = getIt<AppConfig>();

            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: config.appName,
              routerConfig: getIt<AppRouter>().config(),
              locale: TranslationProvider.of(context).flutterLocale,
              supportedLocales: AppLocaleUtils.supportedLocales,
              localizationsDelegates: GlobalMaterialLocalizations.delegates,
              theme: AppThemeData.getAppThemeData(
                brightness: Brightness.light,
                context: context,
              ),
              darkTheme: AppThemeData.getAppThemeData(
                brightness: Brightness.dark,
                context: context,
              ),
              themeMode: themeMode,
              builder: (BuildContext context, Widget? routeChild) {
                Widget content = _ActivityListener(
                  child: ConnectivityBanner(
                    child: AppToastHost(
                      child: SavingPillHost(
                        child: SystemPrompts(
                          clipboard: getIt<ClipboardService>(),
                          navigatorContext: () =>
                              getIt<AppRouter>().navigatorKey.currentContext,
                          child: DismissKeyboard(
                            child: ScrollConfiguration(
                              behavior: const NoGlowScrollBehavior(),
                              child: routeChild ?? const SizedBox.shrink(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );

                content = _SessionNavigator(
                  router: getIt<AppRouter>(),
                  child: content,
                );

                if (!config.isProduction) {
                  content = Banner(
                    message: config.environment.name.toUpperCase(),
                    location: BannerLocation.bottomEnd,
                    color: AppColors.light.accentStrong,
                    child: content,
                  );
                }

                return content;
              },
            );
          },
        );
      },
    );
  }
}

/// Every touch counts as use for the auto-lock (web `AutoLockService`'s
/// `pointerdown`/`touchstart`); it never takes part in hit testing.
class _ActivityListener extends StatelessWidget {
  const _ActivityListener({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => context.read<LockCubit>().recordActivity(),
      child: child,
    );
  }
}

/// Moves the app when the session changes phase (web `auth.guard.ts`):
/// signed out → Welcome; locked → Unlock; ready → the tabs. Signing in and
/// checking for the vault are led by the Welcome screen itself, and the
/// launch by the Splash screen.
class _SessionNavigator extends StatelessWidget {
  const _SessionNavigator({required this.router, required this.child});

  final AppRouter router;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionCubit, SessionState>(
      listenWhen: (SessionState a, SessionState b) =>
          a.restored && a.phase != b.phase,
      listener: (BuildContext context, SessionState session) {
        switch (session.phase) {
          case SessionPhase.ready:
            router.replaceAll(<PageRouteInfo>[const HomeRoute()]);
          case SessionPhase.signedOut:
            router.replaceAll(<PageRouteInfo>[
              WelcomeRoute(farewell: session.farewell),
            ]);
          case SessionPhase.awaitingSecret:
            // Locked: back to Unlock. Signing in is led by Welcome.
            if (session.lockReason != null) {
              router.replaceAll(<PageRouteInfo>[UnlockRoute()]);
            }
        }
      },
      child: child,
    );
  }
}
