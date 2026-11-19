import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/enums/audit_type.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/enums/sync_phase.dart';
import 'package:keeperpass/core/utils/items/item_sections.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/models/general/cubitStatus.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/presentation/common/cubit/bottom_nav_bar/bottom_nav_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/connectivity/connectivity_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/lock/lock_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/sync/sync_cubit.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_radius.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/utils/provider_ui.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/brand/app_brand.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_icon_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_small_button.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_vault_file_card.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_banner.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_spinner.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_status.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_trust_line.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/saving_pill_host.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_search_field.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_bars.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_filter_chip.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_scope_switcher.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_tag_chip.dart';
import 'package:keeperpass/presentation/common/widgets/text/highlighted_text.dart';
import 'package:keeperpass/presentation/features/edit_item/pages/edit_item_page.dart';
import 'package:keeperpass/presentation/features/security/widgets/security_texts.dart';
import 'package:keeperpass/presentation/features/settings/pages/settings_flows.dart';
import 'package:keeperpass/presentation/features/tags/pages/tags_page.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_cubit.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_view.dart';
import 'package:keeperpass/presentation/features/vault_list/widgets/vault_rows.dart';
import 'package:keeperpass/presentation/features/vault_list/widgets/vault_sheets.dart';

/// The Vault tab (boards `U3-Vault-home`, `U3-Vault-actions`,
/// `U3-Vault-empty`): the list, its search and its selection mode. Its
/// cubit is the home screen's, shared with the Security report.
class VaultListPage extends StatelessWidget {
  const VaultListPage({super.key});

  @override
  Widget build(BuildContext context) => const VaultListScreen();
}

/// [VaultListPage] under a given cubit (tests provide their own).
class VaultListScreen extends StatelessWidget {
  const VaultListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: <BlocListener<dynamic, dynamic>>[
        // Selection swaps the tab bar for Move and Delete (board C4).
        BlocListener<VaultListCubit, VaultListState>(
          listenWhen: (VaultListState a, VaultListState b) =>
              a.selecting != b.selecting,
          listener: (BuildContext context, VaultListState state) =>
              context.read<BottomNavCubit?>()?.setBarHidden(state.selecting),
        ),
        BlocListener<VaultListCubit, VaultListState>(
          listenWhen: (VaultListState a, VaultListState b) =>
              a.status != b.status &&
              b.status.statusType == CubitStatusType.failure,
          listener: (BuildContext context, VaultListState state) =>
              AppToastHost.of(context).show(
                AppToastData(
                  icon: AppIconName.cloudOff,
                  title: state.status.errorMsg ?? '',
                ),
              ),
        ),
      ],
      // The status line says what the saving pill would (your answer,
      // Part 14): no pill while this list is the screen showing.
      child: SilenceSavingPill(
        showing:
            context.select((BottomNavCubit? c) => c?.state.selectedIndex) == 0,
        child: Scaffold(
          backgroundColor: context.colors.background,
          resizeToAvoidBottomInset: false,
          body: BlocBuilder<VaultListCubit, VaultListState>(
            buildWhen: (VaultListState a, VaultListState b) =>
                a.selecting != b.selecting || a.searching != b.searching,
            builder: (BuildContext context, VaultListState state) {
              final Widget view = state.selecting
                  ? const _SelectView(key: ValueKey<String>('select'))
                  : state.searching
                  ? const _SearchView(key: ValueKey<String>('search'))
                  : const _BrowseView(key: ValueKey<String>('browse'));
              return AnimatedSwitcher(
                duration: AppMotion.reduceMotion(context)
                    ? Duration.zero
                    : AppMotion.fast,
                child: view,
              );
            },
          ),
        ),
      ),
    );
  }
}

String _storage(BuildContext context) =>
    context.select((SessionCubit c) => c.state.account?.provider.storageName) ??
    '';

/// The scope's name, as the title says it.
String scopeTitle(VaultListState state) => switch (state.scope) {
  VaultScope.all => t.vaultList.allVaults,
  VaultScope.favourites => t.vaultList.favorites,
  VaultScope.recent => t.vaultList.recentlyUsed,
  VaultScope.vault =>
    state.view.vaults
            .where((Vault v) => v.id == state.vaultId)
            .firstOrNull
            ?.name ??
        t.vaultList.allVaults,
};

/// New Vault Item from the list: the vault in view first; the new item
/// goes back to this list.
Future<void> newVaultItem(BuildContext context) {
  final VaultListCubit cubit = context.read<VaultListCubit>();
  final VaultListState state = cubit.state;
  return openNewItem(
    context,
    vaults: cubit.vaults,
    vaultInView: state.scope == VaultScope.vault ? state.vaultId : null,
    backLabel: scopeTitle(state),
    onShowTag: cubit.showTag,
  );
}

/// The hint under a finding's list (board `S4-19`; your answer, Part 11).
String _reportHint(AuditType report, VaultListView view) => switch (report) {
  AuditType.weakPassword => t.report.hintWeak,
  AuditType.compromisedPassword => t.report.hintCompromised,
  AuditType.reusedPassword =>
    view.reusedPasswords == 1
        ? t.report.hintReusedOne(n: view.rows.length)
        : t.report.hintReusedSome,
};

String reportLabel(AuditType report) => switch (report) {
  AuditType.weakPassword => t.vaultList.reportWeak,
  AuditType.reusedPassword => t.vaultList.reportReused,
  AuditType.compromisedPassword => t.vaultList.reportCompromised,
};

// ---- Browse

class _BrowseView extends StatefulWidget {
  const _BrowseView({super.key});

  @override
  State<_BrowseView> createState() => _BrowseViewState();
}

class _BrowseViewState extends State<_BrowseView> {
  /// How far the list was pulled past its top during the current drag.
  double _pulled = 0;

  /// Pulling this far and letting go re-reads the vault (the 64 pt status
  /// block of board `U3-Vault-home` 03).
  double get _threshold => 64.h;

  bool _onScroll(ScrollNotification notification) {
    if (notification.depth != 0 || notification.metrics.axis != Axis.vertical) {
      return false;
    }
    if (notification is ScrollUpdateNotification) {
      final double overscroll = -notification.metrics.pixels;
      if (notification.dragDetails != null) {
        _pulled = math.max(_pulled, overscroll);
      } else if (_pulled >= _threshold) {
        _pulled = 0;
        context.read<VaultListCubit>().refresh();
      }
    } else if (notification is ScrollEndNotification) {
      _pulled = 0;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final VaultListCubit cubit = context.read<VaultListCubit>();
    final VaultListState state = context.watch<VaultListCubit>().state;
    final VaultListView view = state.view;
    final String title = scopeTitle(state);
    final double bottom = MediaQuery.paddingOf(context).bottom;

    return NotificationListener<ScrollNotification>(
      onNotification: _onScroll,
      child: AppLargeTitleScrollView(
        title: title,
        titleWidget: AppScopeSwitcher(
          title: title,
          onPressed: () => showScopeSheet(context),
        ),
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        actions: <Widget>[
          AppIconButton(
            icon: AppIconName.lockKeyhole,
            semanticLabel: t.vaultList.lock,
            onPressed: () => context.read<LockCubit>().lockNow(),
          ),
          AppIconButton(
            icon: AppIconName.plus,
            semanticLabel: t.vaultList.newItem,
            onPressed: () => newVaultItem(context),
          ),
        ],
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 2.h),
                  const _StatusLine(),
                  SizedBox(height: 14.h),
                  _SearchButton(
                    placeholder: t.vaultList.searchPlaceholder(
                      n: view.searchableCount,
                    ),
                    onTap: cubit.startSearch,
                  ),
                  if (state.report != null || view.tags.isNotEmpty) ...<Widget>[
                    SizedBox(height: 12.h),
                    const _Chips(),
                  ],
                  const _SyncBanner(),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: AnimatedSize(
              duration: AppMotion.reduceMotion(context)
                  ? Duration.zero
                  : AppMotion.base,
              curve: AppMotion.easeOut,
              child: state.refreshing
                  ? _Refreshing(storage: _storage(context))
                  : const SizedBox(width: double.infinity),
            ),
          ),
          if (view.rows.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.only(bottom: bottom + 24.h),
                child: const _EmptyState(),
              ),
            )
          else ...<Widget>[
            if (view.favourites.isNotEmpty)
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverToBoxAdapter(
                  child: VaultFavoritesStrip(rows: view.favourites),
                ),
              ),
            for (int i = 0; i < view.sections.length; i++) ...<Widget>[
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverToBoxAdapter(
                  child: switch (view.sections[i].kind) {
                    final ItemSectionKind kind => VaultSectionHeader(
                      label: sectionLabel(kind),
                      showSort: i == 0,
                    ),
                    // A finding's list goes under its name (board `S4-19`).
                    null when state.report != null && state.search.isEmpty =>
                      VaultSectionHeader(label: reportLabel(state.report!)),
                    null => SizedBox(height: 18.h),
                  },
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: VaultRowsSliver(rows: view.sections[i].rows),
              ),
            ],
            if (state.report != null && state.search.isEmpty)
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverToBoxAdapter(
                  child: AppTrustLine(
                    _reportHint(state.report!, view),
                    icon: AppIconName.info,
                  ),
                ),
              ),
            SliverToBoxAdapter(child: SizedBox(height: bottom + 24.h)),
          ],
        ],
      ),
    );
  }
}

/// What saving needs from the person, under the chips (board
/// `Sync-states`; your answer, Part 14: here only): a failed save with
/// Retry and Dismiss, its retry, an expired session with Reconnect and
/// Later, and being offline. Reading and copying go on underneath.
class _SyncBanner extends StatefulWidget {
  const _SyncBanner();

  @override
  State<_SyncBanner> createState() => _SyncBannerState();
}

class _SyncBannerState extends State<_SyncBanner> {
  /// "Later" on the expired session, until the session changes.
  bool _later = false;

  @override
  Widget build(BuildContext context) {
    final SyncCubit sync = context.read<SyncCubit>();
    final SyncState state = context.watch<SyncCubit>().state;
    final bool offline =
        context.watch<ConnectivityCubit>().state is ConnectivityDisconnected;
    final ProviderId? provider = context.select(
      (SessionCubit c) => c.state.account?.provider,
    );
    final String storage = provider?.storageName ?? '';
    final bool reconnecting =
        state.status.action == CubitAction.reconnect &&
        state.status.statusType == CubitStatusType.loading;

    final Widget? banner = switch (state.phase) {
      _ when state.retrying && state.isSaving => AppBanner(
        tone: AppBannerTone.neutral,
        icon: AppIconName.loaderCircle,
        busy: true,
        title: t.sync.retryingTitle,
        body: t.sync.retryingBody(storage: storage),
      ),
      SyncPhase.failed => AppBanner(
        tone: AppBannerTone.error,
        icon: AppIconName.cloudOff,
        title: t.sync.notSavedTitle,
        body: t.sync.notSavedBody(storage: storage),
        actions: <Widget>[
          AppSmallButton(
            label: t.common.retry,
            icon: AppIconName.rotateCw,
            variant: AppSmallButtonVariant.outlined,
            onPressed: () => unawaited(sync.retry()),
          ),
          AppSmallButton(label: t.sync.dismiss, onPressed: sync.dismissError),
        ],
      ),
      SyncPhase.sessionExpired when !_later => AppBanner(
        tone: AppBannerTone.warning,
        icon: AppIconName.cloudAlert,
        title: t.sync.reconnectTitle(storage: storage),
        body:
            '${provider == ProviderId.dropbox ? t.errors.dropbox.authExpired : t.errors.drive.authExpired} '
            '${t.sync.keepReading}',
        actions: <Widget>[
          AppSmallButton(
            label: t.sync.reconnect,
            leading: provider == null
                ? null
                : AppProviderLogo(provider.logo, size: 15),
            variant: AppSmallButtonVariant.outlined,
            onPressed: reconnecting ? null : () => unawaited(sync.reconnect()),
          ),
          AppSmallButton(
            label: t.sync.later,
            onPressed: () => setState(() => _later = true),
          ),
        ],
      ),
      _ when offline => AppBanner(
        tone: AppBannerTone.neutral,
        icon: AppIconName.wifiOff,
        title: t.common.offlineTitle,
        body: t.sync.offlineBody(storage: storage),
      ),
      _ => null,
    };

    return BlocListener<SyncCubit, SyncState>(
      listenWhen: (SyncState a, SyncState b) => a.phase != b.phase,
      listener: (BuildContext context, SyncState state) {
        if (state.phase != SyncPhase.sessionExpired && _later) {
          setState(() => _later = false);
        }
      },
      child: AnimatedSize(
        duration: AppMotion.reduceMotion(context)
            ? Duration.zero
            : AppMotion.base,
        curve: AppMotion.easeOut,
        alignment: Alignment.topCenter,
        child: banner == null
            ? const SizedBox(width: double.infinity)
            : Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: banner,
              ),
      ),
    );
  }
}

/// `.srch` before it is used: a button dressed as the field.
class _SearchButton extends StatelessWidget {
  const _SearchButton({required this.placeholder, required this.onTap});

  final String placeholder;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final OutlinedBorder shape = AppRadius.shape(context, AppRadius.xl);
    return AppPressable(
      onTap: onTap,
      shape: shape,
      semanticLabel: placeholder,
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: ShapeDecoration(color: colors.secondary, shape: shape),
        child: Row(
          spacing: 8.w,
          children: <Widget>[
            AppIcon(
              AppIconName.search,
              size: 18,
              stroke: 2,
              color: colors.mutedForeground,
            ),
            Expanded(
              child: Text(
                placeholder,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles(context)
                    .body()
                    .resized(16, line: 20)
                    .copyWith(color: colors.mutedForeground),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Tag chips (board `U3-Vault-home` 02: "A tag chip filters in place and says
/// how many match"), or the security filter with its clear button.
class _Chips extends StatelessWidget {
  const _Chips();

  @override
  Widget build(BuildContext context) {
    final VaultListCubit cubit = context.read<VaultListCubit>();
    final VaultListState state = context.watch<VaultListCubit>().state;
    final AuditType? report = state.report;
    return AppFilterChipBar(
      semanticLabel: t.vaultList.filterByTag,
      children: report != null
          ? <Widget>[
              AppFilterChip(
                label: reportLabel(report),
                // The finding's own icon (boards `S3-18`, `S4-19`).
                leading: AppIcon(auditIcon(report), size: 14, stroke: 2.25),
                selected: true,
                clearable: true,
                onPressed: cubit.clearReport,
              ),
            ]
          : <Widget>[
              for (final VaultTagCount tag in state.view.tags)
                AppFilterChip.tag(
                  tag: tag.name,
                  count: tag.count,
                  selected: state.tag == tag.name,
                  onPressed: () => cubit.toggleTag(tag.name),
                ),
              AppFilterChip(
                label: t.vaultList.manageTags,
                leading: const AppIcon(
                  AppIconName.settings2,
                  size: 14,
                  stroke: 2,
                ),
                selected: false,
                onPressed: () =>
                    openTags(context, backLabel: scopeTitle(state)),
              ),
            ],
    );
  }
}

/// The status line (`.stl`): what is listed, and — for the whole vault or
/// one vault — where saving stands (board `Sync-states`: "lists say the
/// same thing in their status line").
class _StatusLine extends StatelessWidget {
  const _StatusLine();

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final VaultListState state = context.watch<VaultListCubit>().state;
    final SyncState sync = context.watch<SyncCubit>().state;
    final bool offline =
        context.watch<ConnectivityCubit>().state is ConnectivityDisconnected;
    final String storage = _storage(context);
    final String items = t.vaultList.itemCount(n: state.view.rows.length);
    final String? tag = state.tag;
    final AuditType? report = state.report;

    if (report != null) {
      // "3 of 23 items · Reused passwords" (board `S4-19`; your answer,
      // Part 11).
      return _Line(
        text: t.vaultList.statusReport(
          items: t.vaultList.itemsOf(
            count: state.view.rows.length,
            n: state.view.total,
          ),
          report: reportLabel(report),
        ),
      );
    }
    if (tag != null) {
      return _Line(
        icon: AppTagGlyph(tag, size: 12),
        text: t.vaultList.statusTagged(items: items, tag: tag),
      );
    }
    if (state.scope == VaultScope.favourites ||
        state.scope == VaultScope.recent) {
      return _Line(text: items);
    }

    final String saved = state.scope == VaultScope.vault
        ? t.vaultList.statusInVault(items: items, vault: scopeTitle(state))
        : t.vaultList.statusSaved(items: items, storage: storage);
    return switch (sync.phase) {
      SyncPhase.encrypting => AppStatusLine(
        state: AppSaveState.working,
        label: t.createVault.encrypting,
      ),
      SyncPhase.uploading => AppStatusLine(
        state: AppSaveState.working,
        label: t.common.savingTo(provider: storage),
      ),
      SyncPhase.sessionExpired => _Line(
        icon: AppIcon(
          AppIconName.cloudAlert,
          size: 15,
          stroke: 2,
          color: colors.warningStrong,
        ),
        text: t.vaultList.statusNotConnected(storage: storage),
      ),
      // A change still waiting is counted — offline, and after Dismiss too
      // (board `Sync-states`: "The status line keeps counting").
      _ when sync.pendingChanges > 0 => AppStatusLine(
        state: AppSaveState.notSaved,
        label: t.vaultList.statusNotSaved(n: sync.pendingChanges),
      ),
      // Offline is plain information (board `Sync-states`).
      _ when offline => _Line(
        icon: AppIcon(
          AppIconName.wifiOff,
          size: 15,
          stroke: 2,
          color: colors.mutedForeground,
        ),
        text: t.vaultList.statusOffline(items: items),
      ),
      _ => AppStatusLine(state: AppSaveState.saved, label: saved),
    };
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.text, this.icon});

  final String text;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 6.w,
      children: <Widget>[
        ?icon,
        Flexible(
          child: Text(
            text,
            style: AppTextStyles(
              context,
            ).secondary().copyWith(color: context.colors.mutedForeground),
          ),
        ),
      ],
    );
  }
}

/// "Reading your vault from Google Drive…" until it lands.
class _Refreshing extends StatelessWidget {
  const _Refreshing({required this.storage});

  final String storage;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: SizedBox(
        height: 64.h,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 6.h,
          children: <Widget>[
            const RepaintBoundary(child: AppSpinner(size: 20)),
            Text(
              t.vaultList.refreshing(storage: storage),
              style: AppTextStyles(
                context,
              ).secondary().copyWith(color: context.colors.mutedForeground),
            ),
          ],
        ),
      ),
    );
  }
}

// ---- Empty states

/// Each empty state has its own words and the one action that fills it
/// (board `U3-Vault-empty`).
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final VaultListCubit cubit = context.read<VaultListCubit>();
    final VaultListState state = context.watch<VaultListCubit>().state;
    final VaultListView view = state.view;
    final String storage = _storage(context);
    final AuditType? report = state.report;

    void newItem() => newVaultItem(context);
    final Widget newItemButton = AppButton(
      label: t.vaultList.newItem,
      icon: AppIconName.plus,
      onPressed: newItem,
    );

    if (report != null) {
      return VaultEmptyLayout(
        icon: const AppTileIcon(AppIconName.check),
        title: switch (report) {
          AuditType.weakPassword => t.vaultList.allClearWeak,
          AuditType.reusedPassword => t.vaultList.allClearReused,
          AuditType.compromisedPassword => t.vaultList.allClearCompromised,
        },
        message: t.vaultList.allClearBody,
        actions: <Widget>[
          AppButton(
            label: t.vaultList.backToSecurity,
            variant: AppButtonVariant.secondary,
            expand: false,
            onPressed: () {
              cubit.clearReport();
              context.read<BottomNavCubit?>()?.selectTab(3, tabCount: 5);
            },
          ),
        ],
      );
    }
    switch (state.scope) {
      case VaultScope.favourites:
        return VaultEmptyLayout(
          icon: const AppTileIcon(AppIconName.star),
          title: t.vaultList.noFavoritesTitle,
          message: t.vaultList.noFavoritesBody,
        );
      case VaultScope.recent:
        return VaultEmptyLayout(
          icon: const AppTileIcon(AppIconName.rotateCcwClock),
          title: t.vaultList.nothingRecentTitle,
          message: t.vaultList.nothingRecentBody,
        );
      case VaultScope.vault when state.tag == null:
        final Vault? other =
            view.vaults
                .where((Vault v) => v.id == kPersonalVaultId)
                .where((Vault v) => v.id != state.vaultId)
                .firstOrNull ??
            view.vaults.where((Vault v) => v.id != state.vaultId).firstOrNull;
        return VaultEmptyLayout(
          icon: const AppTileGlyph(FaGlyphs.vault),
          title: t.vaultList.vaultEmptyTitle,
          message: other == null
              ? ''
              : t.vaultList.vaultEmptyBody(vault: other.name),
          actions: <Widget>[newItemButton],
        );
      default:
        if (view.total > 0) {
          // A tag no item carries yet (web: the same sentence as an empty
          // vault set; not drawn on the boards).
          return VaultEmptyLayout(
            icon: const AppTileGlyph(FaGlyphs.tag),
            title: t.vaultList.noItemsTitle,
            message: '',
            actions: <Widget>[newItemButton],
          );
        }
        return VaultEmptyLayout(
          topMargin: 30,
          header: Padding(
            padding: EdgeInsets.only(bottom: 18.h),
            child: Transform.rotate(
              angle: -2 * math.pi / 180,
              child: AppVaultFileCard(
                fileName: 'vault.json.enc',
                meta: t.vaultList.savedMeta(
                  storage: storage,
                  items: t.vaultList.itemCount(n: view.total),
                ),
                note: t.vaultList.vaultReady,
                width: 290,
              ),
            ),
          ),
          title: t.vaultList.noItemsTitle,
          message: t.vaultList.noItemsBody,
          actions: <Widget>[
            newItemButton,
            AppButton(
              label: t.vaultList.importCsv,
              icon: AppIconName.fileUp,
              variant: AppButtonVariant.secondary,
              onPressed: () =>
                  unawaited(startImport(context, backLabel: scopeTitle(state))),
            ),
          ],
        );
    }
  }
}

/// `.empty2`: the tile with its halo, a 20 pt title, one line and the
/// actions, centred.
class VaultEmptyLayout extends StatelessWidget {
  const VaultEmptyLayout({
    required this.title,
    required this.message,
    this.icon,
    this.header,
    this.actions = const <Widget>[],
    this.topMargin = 56,
    this.sides = 32,
    super.key,
  });

  final AppTileContent? icon;
  final Widget? header;
  final String title;
  final String message;
  final List<Widget> actions;
  final double topMargin;

  /// `.empty2`'s 32 pt sides (8 pt inside a padded page, board `S6-31`).
  final double sides;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(sides.w, topMargin.h, sides.w, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 10.h,
        children: <Widget>[
          ?header,
          if (icon != null)
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: AppIconTile(icon!, size: AppTileSize.empty),
            ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: styles
                .title()
                .resized(20, line: 26, weight: FontWeight.w800, tracking: 0)
                .copyWith(color: colors.foreground),
          ),
          if (message.isNotEmpty)
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 300.w),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: styles
                    .body()
                    .resized(15, line: 22)
                    .copyWith(color: colors.mutedForeground),
              ),
            ),
          if (actions.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 10.h,
                children: actions,
              ),
            ),
        ],
      ),
    );
  }
}

// ---- Search

/// Search (board `U3-Vault-home` 02): every word must match, in any order;
/// matches are marked. The query stays in view when nothing matches.
class _SearchView extends StatefulWidget {
  const _SearchView({super.key});

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  late final TextEditingController _query = TextEditingController(
    text: context.read<VaultListCubit>().state.search,
  );
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focus.requestFocus();
    });
  }

  @override
  void dispose() {
    _query.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final VaultListCubit cubit = context.read<VaultListCubit>();
    final VaultListState state = context.watch<VaultListCubit>().state;
    final VaultListView view = state.view;
    final List<String> words = searchWords(state.search);
    final double bottom = MediaQuery.paddingOf(context).bottom;
    final AppColors colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: MediaQuery.paddingOf(context).top + 8.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            spacing: 8.w,
            children: <Widget>[
              Expanded(
                child: AppSearchField(
                  controller: _query,
                  focusNode: _focus,
                  placeholder: t.vaultList.searchPlaceholder(
                    n: view.searchableCount,
                  ),
                  onChanged: cubit.setSearch,
                ),
              ),
              AppLinkButton.bar(
                label: t.common.cancel,
                horizontalPadding: 4,
                onPressed: cubit.cancelSearch,
              ),
            ],
          ),
        ),
        Expanded(
          child: state.search.trim().isNotEmpty && view.rows.isEmpty
              ? SingleChildScrollView(
                  child: VaultEmptyLayout(
                    topMargin: 40,
                    icon: const AppTileIcon(AppIconName.search),
                    title: t.vaultList.noResultsTitle,
                    message: t.vaultList.noResultsBody,
                    actions: <Widget>[
                      Center(
                        child: AppButton(
                          label: t.common.clearSearch,
                          variant: AppButtonVariant.secondary,
                          expand: false,
                          onPressed: () {
                            _query.clear();
                            cubit.setSearch('');
                            _focus.requestFocus();
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : CustomScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  slivers: <Widget>[
                    if (words.isNotEmpty)
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 0),
                        sliver: SliverToBoxAdapter(
                          child: VaultSectionHeader(
                            label: t.vaultList.results(n: view.rows.length),
                          ),
                        ),
                      ),
                    for (final VaultSectionView section in view.sections)
                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        sliver: VaultRowsSliver(
                          rows: section.rows,
                          highlight: words,
                        ),
                      ),
                    if (words.isNotEmpty)
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(28.w, 16.h, 28.w, 0),
                        sliver: SliverToBoxAdapter(
                          child: Text(
                            t.vaultList.searchHint,
                            textAlign: TextAlign.center,
                            style: AppTextStyles(context).secondary().copyWith(
                              color: colors.mutedForeground,
                            ),
                          ),
                        ),
                      ),
                    SliverToBoxAdapter(child: SizedBox(height: bottom + 24.h)),
                  ],
                ),
        ),
      ],
    );
  }
}

// ---- Selection

/// Select several (board `U3-Vault-actions` 05): Cancel, the count and
/// Select All; leading circles; Move and Delete replace the tab bar.
class _SelectView extends StatelessWidget {
  const _SelectView({super.key});

  @override
  Widget build(BuildContext context) {
    final VaultListCubit cubit = context.read<VaultListCubit>();
    final VaultListState state = context.watch<VaultListCubit>().state;
    final AppTextStyles styles = AppTextStyles(context);
    final AppColors colors = context.colors;
    final List<VaultRow> selected = state.selectedRows;
    final int n = selected.length;

    return PopScope<Object?>(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, _) {
        if (!didPop) cubit.cancelSelecting();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: MediaQuery.paddingOf(context).top),
          SizedBox(
            height: 52.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 100.w,
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: AppLinkButton.bar(
                        label: t.common.cancel,
                        weight: FontWeight.w400,
                        onPressed: cubit.cancelSelecting,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Semantics(
                      liveRegion: true,
                      child: Text(
                        t.vaultList.selectedCount(n: n),
                        textAlign: TextAlign.center,
                        style: styles.navTitle().copyWith(
                          color: colors.foreground,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100.w,
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: AppLinkButton.bar(
                        label: t.vaultList.selectAll,
                        semanticLabel: t.vaultList.selectOrDeselectAll,
                        weight: FontWeight.w400,
                        onPressed: cubit.toggleSelectAll,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 0),
            child: Text(
              scopeTitle(state),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textScaler: AppTextStyles.largeStyleTextScaler(context),
              style: styles.largeTitle().copyWith(color: colors.foreground),
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                for (final VaultSectionView section
                    in state.view.sections) ...<Widget>[
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    sliver: SliverToBoxAdapter(
                      child: section.kind == null
                          ? SizedBox(height: 18.h)
                          : VaultSectionHeader(
                              label: sectionLabel(section.kind!),
                            ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    sliver: VaultRowsSliver(rows: section.rows),
                  ),
                ],
                SliverToBoxAdapter(child: SizedBox(height: 24.h)),
              ],
            ),
          ),
          AppSelectionToolbar(
            actions: <AppButton>[
              AppButton(
                label: t.vaultList.moveItems(n: n),
                icon: AppIconName.folderInput,
                variant: AppButtonVariant.secondary,
                size: AppButtonSize.medium,
                onPressed: n == 0
                    ? null
                    : () => showMoveSheet(
                        context,
                        context.read<VaultListCubit>(),
                        selected,
                      ),
              ),
              AppButton(
                label: t.vaultList.deleteItems(n: n),
                icon: AppIconName.trash,
                variant: AppButtonVariant.destructive,
                size: AppButtonSize.medium,
                onPressed: n == 0
                    ? null
                    : () async {
                        if (await confirmDeleteItems(context, selected)) {
                          await cubit.deleteItems(<String>[
                            for (final VaultRow row in selected) row.id,
                          ]);
                        }
                      },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
