import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/utils/text/date_formats.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/common/cubit/bottom_nav_bar/bottom_nav_cubit.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_inset_group.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_section_label.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_surface.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_icon_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_bars.dart';
import 'package:keeperpass/presentation/common/widgets/overlays/app_dialog.dart';
import 'package:keeperpass/presentation/common/widgets/overlays/app_menu.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_manage_row.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_swipe_actions.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_cubit.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_view.dart';
import 'package:keeperpass/presentation/features/vault_list/widgets/vault_sheets.dart';
import 'package:keeperpass/presentation/features/vaults/cubit/my_vaults_cubit.dart';
import 'package:keeperpass/presentation/features/vaults/widgets/rename_vault_sheet.dart';

/// "Manage vaults" in the scope sheet: My Vaults, inside the Vault tab.
Future<void> openMyVaults(BuildContext context, {required String backLabel}) =>
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => MyVaultsPage(backLabel: backLabel),
      ),
    );

/// My Vaults with its own cubit.
class MyVaultsPage extends StatelessWidget {
  const MyVaultsPage({required this.backLabel, super.key});

  final String backLabel;

  @override
  Widget build(BuildContext context) => BlocProvider<MyVaultsCubit>(
    create: (_) => getIt<MyVaultsCubit>(),
    child: MyVaultsScreen(backLabel: backLabel),
  );
}

/// Your vaults (boards `Vaults`, `S5-01` … `S5-06`): tap one to open it in
/// the Vault tab; swipe, long-press or select for rename and delete. My
/// Vault, the default, has no actions.
class MyVaultsScreen extends StatelessWidget {
  const MyVaultsScreen({required this.backLabel, super.key});

  /// The Vault list's title ("All Vaults").
  final String backLabel;

  Future<void> _newVault(BuildContext context) async {
    final MyVaultsCubit cubit = context.read<MyVaultsCubit>();
    final String? name = await showNewVaultSheet(
      context,
      cubit.state.allVaults,
    );
    if (name != null) await cubit.create(name);
  }

  Future<void> _rename(BuildContext context, VaultEntry entry) async {
    final MyVaultsCubit cubit = context.read<MyVaultsCubit>();
    final String? name = await showRenameVaultSheet(
      context,
      current: entry.vault.name,
      taken: <String>{
        for (final VaultEntry e in cubit.state.vaults) e.vault.name,
      },
    );
    if (name != null) await cubit.rename(entry.vault.id, name);
  }

  /// One vault (board `S5-05`): where its items go, with the count — the
  /// one solid red button.
  Future<void> _delete(BuildContext context, VaultEntry entry) async {
    final MyVaultsCubit cubit = context.read<MyVaultsCubit>();
    final bool confirmed = await showAppDialog(
      context,
      icon: AppIconName.trash,
      tone: AppDialogTone.solid,
      title: t.myVaults.deleteTitle(name: entry.vault.name),
      message: t.myVaults.deleteBody(
        n: entry.items,
        vault: cubit.state.personal?.vault.name ?? '',
      ),
      confirmLabel: t.myVaults.deleteAction,
    );
    if (confirmed) await cubit.delete(<String>[entry.vault.id]);
  }

  Future<void> _deleteSelected(BuildContext context) async {
    final MyVaultsCubit cubit = context.read<MyVaultsCubit>();
    final MyVaultsState state = cubit.state;
    final int n = state.selected.length;
    final bool confirmed = await showAppDialog(
      context,
      icon: AppIconName.trash,
      tone: AppDialogTone.solid,
      title: t.myVaults.deleteSelectedTitle(n: n),
      message: t.myVaults.deleteSelectedBody(
        n: state.selectedItems,
        vault: state.personal?.vault.name ?? '',
      ),
      confirmLabel: t.myVaults.deleteVaults(n: n),
    );
    if (confirmed) await cubit.delete(state.selected.toList());
  }

  /// Long press: the swipe's two actions in a menu (board `Vaults` 01).
  Future<void> _menu(BuildContext anchor, VaultEntry entry) async {
    final _Action? action = await showAppMenu<_Action>(
      anchor,
      items: <AppMenuItem<_Action>>[
        AppMenuItem<_Action>(
          value: _Action.rename,
          label: t.common.rename,
          icon: AppIconName.pencil,
        ),
        AppMenuItem<_Action>(
          value: _Action.delete,
          label: t.vaultList.delete,
          icon: AppIconName.trash,
          destructive: true,
        ),
      ],
    );
    if (!anchor.mounted || action == null) return;
    switch (action) {
      case _Action.rename:
        await _rename(anchor, entry);
      case _Action.delete:
        await _delete(anchor, entry);
    }
  }

  /// A vault opens in the Vault tab (board `Vaults` 01).
  void _open(BuildContext context, VaultEntry entry) {
    context.read<VaultListCubit>().setScope(
      VaultScope.vault,
      vaultId: entry.vault.id,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final MyVaultsCubit cubit = context.read<MyVaultsCubit>();
    final MyVaultsState state = context.watch<MyVaultsCubit>().state;
    final bool selecting = state.selecting;
    final int n = state.selected.length;
    final VaultEntry? personal = state.personal;
    final double bottom = MediaQuery.paddingOf(context).bottom;

    return BlocListener<MyVaultsCubit, MyVaultsState>(
      listenWhen: (MyVaultsState a, MyVaultsState b) =>
          a.selecting != b.selecting,
      // Selection swaps the tab bar for its counted action (board C4).
      listener: (BuildContext context, MyVaultsState state) =>
          context.read<BottomNavCubit?>()?.setBarHidden(state.selecting),
      child: PopScope<Object?>(
        canPop: !selecting,
        onPopInvokedWithResult: (bool didPop, _) {
          if (!didPop) cubit.cancelSelecting();
        },
        child: Scaffold(
          backgroundColor: context.colors.background,
          bottomNavigationBar: selecting
              ? AppSelectionToolbar(
                  actions: <AppButton>[
                    AppButton(
                      label: t.myVaults.deleteVaults(n: n),
                      icon: AppIconName.trash,
                      variant: AppButtonVariant.destructive,
                      size: AppButtonSize.medium,
                      onPressed: n == 0 ? null : () => _deleteSelected(context),
                    ),
                  ],
                )
              : null,
          body: AppLargeTitleScrollView(
            title: t.myVaults.title,
            subtitle: selecting
                ? t.myVaults.selected(n: n)
                : t.myVaults.subtitle,
            subtitleHighlighted: selecting,
            leading: selecting
                ? AppLinkButton.bar(
                    label: t.common.cancel,
                    onPressed: cubit.cancelSelecting,
                  )
                : AppLinkButton.back(
                    label: backLabel,
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
            actions: selecting
                ? <Widget>[
                    AppLinkButton.bar(
                      label: t.vaultList.selectAll,
                      semanticLabel: t.vaultList.selectOrDeselectAll,
                      onPressed: cubit.toggleSelectAll,
                    ),
                  ]
                : <Widget>[
                    // Only when there is something to select (your
                    // answer, Part 12).
                    if (state.others.isNotEmpty)
                      AppLinkButton.bar(
                        label: t.vaultList.select,
                        onPressed: cubit.startSelecting,
                      ),
                    AppIconButton(
                      icon: AppIconName.plus,
                      semanticLabel: t.myVaults.newVault,
                      onPressed: () => _newVault(context),
                    ),
                  ],
            slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      AppInsetGroup(
                        dividerInset: AppDividerInset.item,
                        children: <Widget>[
                          for (final VaultEntry entry in state.vaults)
                            _VaultRow(
                              entry: entry,
                              selecting: selecting,
                              selected: state.selected.contains(entry.vault.id),
                              onTap: () => selecting
                                  ? cubit.toggle(entry.vault.id)
                                  : _open(context, entry),
                              onRename: () => _rename(context, entry),
                              onDelete: () => _delete(context, entry),
                              onMenu: (BuildContext anchor) =>
                                  _menu(anchor, entry),
                            ),
                        ],
                      ),
                      if (personal != null)
                        AppFootnote(
                          t.myVaults.personalSummary(
                            n: personal.items,
                            name: personal.vault.name,
                          ),
                        ),
                      if (state.others.isEmpty && !selecting) ...<Widget>[
                        SizedBox(height: 16.h),
                        _OnlyTheDefault(onNewVault: () => _newVault(context)),
                      ],
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: bottom + 24.h)),
            ],
          ),
        ),
      ),
    );
  }
}

enum _Action { rename, delete }

class _VaultRow extends StatelessWidget {
  const _VaultRow({
    required this.entry,
    required this.selecting,
    required this.selected,
    required this.onTap,
    required this.onRename,
    required this.onDelete,
    required this.onMenu,
  });

  final VaultEntry entry;
  final bool selecting;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onRename;
  final VoidCallback onDelete;
  final ValueChanged<BuildContext> onMenu;

  @override
  Widget build(BuildContext context) {
    final String locale = LocaleSettings.currentLocale.languageCode;
    final String name = entry.vault.name;
    final DateTime? created = entry.vault.created;
    final bool actions = !entry.isDefault && !selecting;
    final Widget row = Builder(
      builder: (BuildContext anchor) => AppManageRow(
        height: 72,
        tile: const AppIconTile(AppTileGlyph(FaGlyphs.vault)),
        title: name,
        badge: entry.isDefault ? t.myVaults.defaultBadge : null,
        subtitle: <String>[
          t.myVaults.itemCount(n: entry.items),
          if (created != null)
            t.myVaults.createdOn(
              date: formatMediumDate(created.toLocal(), locale),
            ),
        ].join(' · '),
        selected: selecting ? selected : null,
        selectable: !entry.isDefault,
        onTap: onTap,
        onLongPress: actions ? () => onMenu(anchor) : null,
      ),
    );
    if (!actions) return row;
    return AppSwipeActions(
      fullSwipe: false,
      actionWidth: 76,
      actions: <AppSwipeAction>[
        AppSwipeAction(
          icon: AppIconName.pencil,
          label: t.common.rename,
          semanticLabel: t.myVaults.renameAria(name: name),
          tone: AppSwipeTone.accent,
          onPressed: onRename,
        ),
        AppSwipeAction(
          icon: AppIconName.trash,
          label: t.vaultList.delete,
          semanticLabel: t.myVaults.deleteAria(name: name),
          tone: AppSwipeTone.destructive,
          onPressed: onDelete,
        ),
      ],
      child: row,
    );
  }
}

/// "You only have the default vault" (board `S5-06`, the web's words).
class _OnlyTheDefault extends StatelessWidget {
  const _OnlyTheDefault({required this.onNewVault});

  final VoidCallback onNewVault;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    return AppSurface(
      padding: EdgeInsets.fromLTRB(22.w, 28.h, 22.w, 24.h),
      child: Column(
        spacing: 6.h,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: const AppIconTile(
              AppTileGlyph(FaGlyphs.vault),
              size: AppTileSize.empty,
            ),
          ),
          Text(
            t.myVaults.emptyTitle,
            textAlign: TextAlign.center,
            style: styles
                .title()
                .resized(18, line: 24, weight: FontWeight.w800, tracking: 0)
                .copyWith(color: colors.foreground),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 280.w),
            child: Text(
              t.myVaults.emptyBody,
              textAlign: TextAlign.center,
              style: styles
                  .secondary()
                  .resized(13, line: 18)
                  .copyWith(color: colors.mutedForeground),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 14.h),
            child: AppButton(
              label: t.myVaults.newVault,
              icon: AppIconName.plus,
              expand: false,
              onPressed: onNewVault,
            ),
          ),
        ],
      ),
    );
  }
}
