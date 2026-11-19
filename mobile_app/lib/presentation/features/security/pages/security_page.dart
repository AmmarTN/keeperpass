import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/enums/audit_type.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/common/cubit/bottom_nav_bar/bottom_nav_cubit.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_surface.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_icon_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_small_button.dart';
import 'package:keeperpass/presentation/common/widgets/cards/app_report_cards.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_banner.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_spinner.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_trust_line.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_bars.dart';
import 'package:keeperpass/presentation/features/edit_item/pages/edit_item_page.dart';
import 'package:keeperpass/presentation/features/item_detail/pages/item_detail_page.dart';
import 'package:keeperpass/presentation/features/security/cubit/security_cubit.dart';
import 'package:keeperpass/presentation/features/security/cubit/security_view.dart';
import 'package:keeperpass/presentation/features/security/widgets/fix_outcome.dart';
import 'package:keeperpass/presentation/features/security/widgets/security_texts.dart';
import 'package:keeperpass/presentation/features/security/widgets/why_it_matters_sheet.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_cubit.dart';
import 'package:keeperpass/presentation/features/vault_list/widgets/vault_rows.dart';

/// The Security tab with its own cubit.
class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<SecurityCubit>(
    create: (_) => getIt<SecurityCubit>(),
    child: const SecurityScreen(),
  );
}

/// The Security report (boards `Security`, `S4-13` … `S4-18`): the vault's
/// health, the three kinds of finding as tiles and as cards with the items
/// they affect, and the states of the check behind them.
class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  final Map<AuditType, GlobalKey> _cards = <AuditType, GlobalKey>{
    for (final AuditType type in AuditType.values) type: GlobalKey(),
  };

  /// A stat tile jumps to its card (web `scrollTo`).
  void _jumpTo(AuditType type) {
    final BuildContext? card = _cards[type]!.currentContext;
    if (card == null) return;
    unawaited(
      Scrollable.ensureVisible(
        card,
        alignment: 0.12,
        duration: AppMotion.reduceMotion(context)
            ? Duration.zero
            : AppMotion.slow,
        curve: AppMotion.easeOut,
      ),
    );
  }

  /// "Show all": the Vault list filtered to that finding, as a chip that
  /// clears with its × (board `Fix-finding` 01).
  void _showAll(AuditType type) {
    context.read<VaultListCubit>().showReport(type);
    context.read<BottomNavCubit>().openTabRoot(0, tabCount: 5);
  }

  Future<void> _info(AuditType type, int count) async {
    if (await showWhyItMatters(context, type: type, count: count) && mounted) {
      _showAll(type);
    }
  }

  /// An item from the report; a fix saved from it comes back here with the
  /// report updated and the toast (your answer, Part 11).
  Future<void> _open(SecurityRow row) async {
    final AppToastHostState toasts = AppToastHost.of(context);
    final Future<FixOutcome?>? fixed = await openItem(
      context,
      itemId: row.row.id,
      backLabel: t.report.title,
      returnAfterFix: true,
    );
    final FixOutcome? outcome = await fixed;
    if (outcome != null && mounted) showFixToast(toasts, outcome);
  }

  void _newItem() {
    final SecurityCubit cubit = context.read<SecurityCubit>();
    unawaited(
      openNewItem(
        context,
        vaults: cubit.vaults,
        vaultInView: null,
        backLabel: t.report.title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final SecurityCubit cubit = context.read<SecurityCubit>();
    final SecurityState state = context.watch<SecurityCubit>().state;
    final SecurityView view = state.view;
    final double bottom = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: context.colors.background,
      body: AppLargeTitleScrollView(
        title: t.report.title,
        subtitle: t.report.subtitle,
        actions: <Widget>[
          AppIconButton(
            icon: AppIconName.rotateCw,
            semanticLabel: t.report.checkAgain,
            // Drawn as usual while a check runs (board `S4-15`); a tap then
            // does nothing.
            onPressed: cubit.checkAgain,
          ),
        ],
        slivers: <Widget>[
          if (view.status == SecurityStatus.nothingToCheck)
            SliverToBoxAdapter(child: _NothingToCheck(onNewItem: _newItem))
          else
            // At most fifteen rows: built at once, so a tile can always
            // jump to its card.
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    if (view.failed && !view.checking) ...<Widget>[
                      _CheckFailed(
                        offline: state.offline,
                        onTryAgain: cubit.checkAgain,
                      ),
                      SizedBox(height: 12.h),
                    ],
                    ...switch (view.status) {
                      SecurityStatus.waiting => _waiting(view),
                      SecurityStatus.report => _report(view, cubit),
                      _ => const <Widget>[],
                    },
                  ],
                ),
              ),
            ),
          SliverToBoxAdapter(child: SizedBox(height: bottom + 24.h)),
        ],
      ),
    );
  }

  /// The first check of the session (board `S4-15`): everything waits; the
  /// bar and one row show how far it is (your answer, Part 11).
  List<Widget> _waiting(SecurityView view) {
    final int total = view.toLookUp;
    final double progress = total == 0 ? 0 : view.lookedUp / total;
    return <Widget>[
      AppHealthCard.checking(
        title: t.report.healthLabel,
        progress: progress,
        note: total == 0
            ? t.report.checking
            : t.report.checkingBreaches(done: view.lookedUp, total: total),
      ),
      SizedBox(height: 12.h),
      _StatRow(
        tiles: <Widget>[
          for (final AuditType type in AuditType.values)
            AppStatTile.waiting(
              label: statLabel(type),
              semanticLabel: t.report.statNotChecked(label: statLabel(type)),
            ),
        ],
      ),
      if (total > 0) ...<Widget>[
        SizedBox(height: 12.h),
        AppSurface(
          clip: true,
          child: AppFindingRow(
            tile: const AppIconTile(
              AppTileChild(AppSpinner(size: 18)),
              size: AppTileSize.item,
              tone: AppTileTone.muted,
            ),
            name: t.report.checkingPasswords(n: total),
            detail: view.timeLeft == null
                ? t.report.progress(done: view.lookedUp, total: total)
                : t.report.progressTime(
                    done: view.lookedUp,
                    total: total,
                    time: timeLeftText(view.timeLeft!),
                  ),
            onTap: null,
          ),
        ),
      ],
    ];
  }

  /// The findings (boards `S4-13`, `S4-16`, `S4-22`).
  List<Widget> _report(SecurityView view, SecurityCubit cubit) {
    final AppColors colors = context.colors;
    final int score = view.score ?? 0;
    final String locale = LocaleSettings.currentLocale.languageCode;
    return <Widget>[
      AppHealthCard(
        title: t.report.healthLabel,
        score: score,
        band: healthBandOf(view.band!),
        bandLabel: healthBandLabel(view.band!),
        note: t.report.itemsChecked(n: view.checked),
        semanticLabel: t.report.healthPercent(
          title: t.report.healthLabel,
          score: score,
        ),
      ),
      SizedBox(height: 12.h),
      _StatRow(
        tiles: <Widget>[
          for (final SecuritySection section in view.sections)
            AppStatTile(
              icon: auditIcon(section.type),
              count: section.count,
              label: statLabel(section.type),
              semanticLabel: t.report.statValue(
                label: statLabel(section.type),
                count: section.count,
              ),
              onTap: view.allClear ? () {} : () => _jumpTo(section.type),
            ),
        ],
      ),
      if (view.allClear) ...<Widget>[
        SizedBox(height: 12.h),
        const _AllClear(),
      ] else
        for (final SecuritySection section in view.sections) ...<Widget>[
          SizedBox(height: 12.h),
          KeyedSubtree(
            key: _cards[section.type],
            child: _FindingCard(
              section: section,
              onInfo: () => _info(section.type, section.count),
              onShowAll: () => _showAll(section.type),
              onOpen: _open,
            ),
          ),
        ],
      AppTrustLine(t.report.trust),
      Padding(
        padding: EdgeInsets.fromLTRB(27.w, 8.h, 4.w, 0),
        child: Text(
          view.checking
              ? t.report.checking
              : lastCheckedText(view.checkedAt!, cubit.now(), locale),
          style: AppTextStyles(context)
              .secondary()
              .resized(13, line: 18)
              .copyWith(color: colors.mutedForeground),
        ),
      ),
    ];
  }
}

/// Three tiles side by side (`.stats`: 8 pt apart), as tall as the tallest.
class _StatRow extends StatelessWidget {
  const _StatRow({required this.tiles});

  final List<Widget> tiles;

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8.w,
      children: <Widget>[
        for (final Widget tile in tiles) Expanded(child: tile),
      ],
    ),
  );
}

/// One kind of finding: its items (at most five, web), "Show all"; with
/// nothing found, the web's sentence (your answer, Part 11).
class _FindingCard extends StatelessWidget {
  const _FindingCard({
    required this.section,
    required this.onInfo,
    required this.onShowAll,
    required this.onOpen,
  });

  final SecuritySection section;
  final VoidCallback onInfo;
  final VoidCallback onShowAll;
  final ValueChanged<SecurityRow> onOpen;

  @override
  Widget build(BuildContext context) {
    final String title = auditLabel(section.type);
    final bool found = section.count > 0;
    return AppFindingCard(
      icon: auditIcon(section.type),
      title: title,
      count: found ? section.count : null,
      infoLabel: t.report.aboutSection(title: title),
      onInfo: onInfo,
      onShowAll: found ? onShowAll : null,
      rows: found
          ? <Widget>[
              for (final SecurityRow row in section.rows)
                AppFindingRow(
                  tile: VaultItemTile(row.row),
                  name: rowName(row.row),
                  detail: detailText(row),
                  onTap: () => onOpen(row),
                ),
            ]
          : <Widget>[_NothingFound(emptyText(section.type))],
    );
  }
}

class _NothingFound extends StatelessWidget {
  const _NothingFound(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: BoxConstraints(minHeight: 64.h),
    child: Padding(
      padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 12.h),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(
          text,
          style: AppTextStyles(context)
              .secondary()
              .resized(13, line: 18)
              .copyWith(color: context.colors.mutedForeground),
        ),
      ),
    ),
  );
}

/// "No problems found" (board `S4-16`, the web's words).
class _AllClear extends StatelessWidget {
  const _AllClear();

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    return AppSurface(
      padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 28.h),
      child: Column(
        spacing: 6.h,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: const AppIconTile(
              AppTileIcon(AppIconName.shieldCheck),
              size: AppTileSize.empty,
            ),
          ),
          Text(
            t.report.allClearTitle,
            textAlign: TextAlign.center,
            style: styles
                .title()
                .resized(18, line: 24, weight: FontWeight.w800, tracking: 0)
                .copyWith(color: colors.foreground),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 260.w),
            child: Text(
              t.report.allClearDescription,
              textAlign: TextAlign.center,
              style: styles
                  .secondary()
                  .resized(13, line: 18)
                  .copyWith(color: colors.mutedForeground),
            ),
          ),
        ],
      ),
    );
  }
}

/// The check could not finish (board `S4-17`'s banner with your Part 11
/// words): offline, or the service refused.
class _CheckFailed extends StatelessWidget {
  const _CheckFailed({required this.offline, required this.onTryAgain});

  final bool offline;
  final VoidCallback onTryAgain;

  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: true,
    child: AppBanner(
      tone: AppBannerTone.neutral,
      icon: offline ? AppIconName.wifiOff : AppIconName.circleAlert,
      title: offline ? t.common.offlineTitle : t.report.failedTitle,
      body: offline ? t.report.offlineBody : t.report.failedBody,
      actions: <Widget>[
        AppSmallButton(
          label: t.common.tryAgain,
          icon: AppIconName.rotateCw,
          variant: AppSmallButtonVariant.outlined,
          onPressed: onTryAgain,
        ),
      ],
    ),
  );
}

/// "Nothing to check yet" (board `S4-18`).
class _NothingToCheck extends StatelessWidget {
  const _NothingToCheck({required this.onNewItem});

  final VoidCallback onNewItem;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(32.w, 96.h, 32.w, 0),
      child: Column(
        spacing: 10.h,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: const AppIconTile(
              AppTileIcon(AppIconName.shieldCheck),
              size: AppTileSize.empty,
            ),
          ),
          Text(
            t.report.nothingTitle,
            textAlign: TextAlign.center,
            style: styles.title().copyWith(color: colors.foreground),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 300.w),
            child: Text(
              t.report.nothingBody,
              textAlign: TextAlign.center,
              style: styles.body().copyWith(color: colors.mutedForeground),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 18.h),
            child: AppButton(
              label: t.vaultList.newItem,
              icon: AppIconName.plus,
              expand: false,
              onPressed: onNewItem,
            ),
          ),
        ],
      ),
    );
  }
}
