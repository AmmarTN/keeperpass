import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/enums/sync_phase.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/sync/sync_cubit.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_status.dart';

/// The saving pill under the top bar (board `Sync-states`): "Encrypting
/// your vault…", "Saving to Google Drive…", then "Saved to Google Drive"
/// for 1.5 s; "1 change not saved" while a save waits. It never blocks
/// reading or copying. Screens that say the same in their status line (the
/// Vault list) silence it while they show (your answer, Part 14).
class SavingPillHost extends StatefulWidget {
  const SavingPillHost({required this.child, super.key});

  final Widget child;

  /// How long "Saved" stays.
  static const Duration savedFor = Duration(milliseconds: 1500);

  static SavingPillHostState? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<SavingPillHostState>();

  @override
  State<SavingPillHost> createState() => SavingPillHostState();
}

class SavingPillHostState extends State<SavingPillHost> {
  /// Screens showing that say it themselves.
  final ValueNotifier<int> silencers = ValueNotifier<int>(0);
  bool _justSaved = false;
  Timer? _savedTimer;

  @override
  void dispose() {
    _savedTimer?.cancel();
    silencers.dispose();
    super.dispose();
  }

  void _saved() {
    _savedTimer?.cancel();
    setState(() => _justSaved = true);
    _savedTimer = Timer(SavingPillHost.savedFor, () {
      if (mounted) setState(() => _justSaved = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool reduceMotion = AppMotion.reduceMotion(context);
    return BlocListener<SyncCubit, SyncState>(
      listenWhen: (SyncState a, SyncState b) =>
          b.savedAt != null && a.savedAt != b.savedAt,
      listener: (_, _) => _saved(),
      child: Stack(
        children: <Widget>[
          widget.child,
          Positioned(
            left: 0,
            right: 0,
            top: MediaQuery.paddingOf(context).top + 52.h,
            child: IgnorePointer(
              // Above the routes, outside any Material: without one, text
              // falls back to the debug style (yellow underline).
              child: Material(
                type: MaterialType.transparency,
                child: ValueListenableBuilder<int>(
                  valueListenable: silencers,
                  builder: (BuildContext context, int silenced, _) {
                    final _Pill? pill = silenced > 0 ? null : _pill(context);
                    return AnimatedSwitcher(
                      duration: AppMotion.base,
                      switchInCurve: AppMotion.easeOut,
                      switchOutCurve: AppMotion.easeOut,
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                            final Widget faded = FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                            // Reduce Motion: a plain cross-fade, no slide.
                            if (reduceMotion) return faded;
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, -0.4),
                                end: Offset.zero,
                              ).animate(animation),
                              child: faded,
                            );
                          },
                      child: pill == null
                          ? const SizedBox.shrink()
                          : Center(
                              key: ValueKey<String>(pill.label),
                              child: AppSavingPill(
                                state: pill.state,
                                label: pill.label,
                              ),
                            ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _Pill? _pill(BuildContext context) {
    final SessionState session = context.watch<SessionCubit>().state;
    if (!session.isReady) return null;
    final SyncState sync = context.watch<SyncCubit>().state;
    final String storage = session.account?.provider.storageName ?? '';
    return switch (sync.phase) {
      SyncPhase.encrypting => _Pill(
        AppSaveState.working,
        t.createVault.encrypting,
      ),
      SyncPhase.uploading => _Pill(
        AppSaveState.working,
        t.common.savingTo(provider: storage),
      ),
      // Waiting, whatever the reason (failed, dismissed, offline, expired).
      _ when sync.pendingChanges > 0 => _Pill(
        AppSaveState.notSaved,
        t.vaultList.statusNotSaved(n: sync.pendingChanges),
      ),
      _ when _justSaved => _Pill(
        AppSaveState.saved,
        t.sync.savedTo(storage: storage),
      ),
      _ => null,
    };
  }
}

class _Pill {
  const _Pill(this.state, this.label);

  final AppSaveState state;
  final String label;
}

/// Keeps the saving pill away while [child]'s screen is the one showing
/// and says the same in its status line. [showing] adds what the route
/// cannot tell (the Vault tab is the selected one).
class SilenceSavingPill extends StatefulWidget {
  const SilenceSavingPill({
    required this.child,
    this.showing = true,
    super.key,
  });

  final Widget child;
  final bool showing;

  @override
  State<SilenceSavingPill> createState() => _SilenceSavingPillState();
}

class _SilenceSavingPillState extends State<SilenceSavingPill> {
  SavingPillHostState? _host;
  bool _silencing = false;

  void _update(bool silence) {
    if (silence == _silencing) return;
    _silencing = silence;
    final SavingPillHostState? host = _host;
    if (host == null) return;
    // After the frame: the host must not change while building.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (host.mounted) host.silencers.value += silence ? 1 : -1;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _host ??= SavingPillHost.maybeOf(context);
  }

  @override
  void dispose() {
    _update(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Covered by a pushed screen (its route is not current, or the screens
    // over it stopped its tickers), or on another tab: not showing.
    _update(
      widget.showing &&
          TickerMode.valuesOf(context).enabled &&
          (ModalRoute.of(context)?.isCurrent ?? true),
    );
    return widget.child;
  }
}
