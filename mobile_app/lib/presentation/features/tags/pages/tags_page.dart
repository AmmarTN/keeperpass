import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/utils/items/tag_changes.dart';
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
import 'package:keeperpass/presentation/common/widgets/selection/app_tag_chip.dart';
import 'package:keeperpass/presentation/features/tags/cubit/tags_cubit.dart';
import 'package:keeperpass/presentation/features/tags/widgets/tag_sheets.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_cubit.dart';

/// "Manage tags" at the end of the chip strip: Tags, inside the Vault tab.
Future<void> openTags(BuildContext context, {required String backLabel}) =>
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => TagsPage(backLabel: backLabel)),
    );

/// Tags with its own cubit.
class TagsPage extends StatelessWidget {
  const TagsPage({required this.backLabel, super.key});

  final String backLabel;

  @override
  Widget build(BuildContext context) => BlocProvider<TagsCubit>(
    create: (_) => getIt<TagsCubit>(),
    child: TagsScreen(backLabel: backLabel),
  );
}

/// Every tag (boards `Tags`, `S5-07` … `S5-12`): tap one to see its items
/// in the Vault tab; swipe, long-press or select for rename and delete.
class TagsScreen extends StatelessWidget {
  const TagsScreen({required this.backLabel, super.key});

  /// The Vault list's title ("All Vaults").
  final String backLabel;

  Set<String> _names(TagsState state) => <String>{
    for (final TagInfo tag in state.tags) tag.name,
  };

  Future<void> _add(BuildContext context) async {
    final TagsCubit cubit = context.read<TagsCubit>();
    final String? name = await showAddTagSheet(
      context,
      taken: _names(cubit.state),
    );
    if (name != null) await cubit.add(name);
  }

  Future<void> _rename(BuildContext context, TagInfo tag) async {
    final TagsCubit cubit = context.read<TagsCubit>();
    final String? name = await showRenameTagSheet(
      context,
      tag: tag,
      taken: _names(cubit.state),
    );
    if (name != null) await cubit.rename(tag.name, name);
  }

  /// One tag (board `S5-11`): how many items lose it; the items stay.
  Future<void> _delete(BuildContext context, TagInfo tag) async {
    final TagsCubit cubit = context.read<TagsCubit>();
    final bool confirmed = await showAppDialog(
      context,
      icon: AppIconName.trash,
      tone: AppDialogTone.solid,
      title: t.tags.deleteTitle(name: tag.name),
      message: t.tags.deleteBody(n: tag.count),
      confirmLabel: t.tags.deleteAction,
    );
    if (confirmed) await cubit.delete(<String>[tag.name]);
  }

  Future<void> _deleteSelected(BuildContext context) async {
    final TagsCubit cubit = context.read<TagsCubit>();
    final int n = cubit.state.selected.length;
    final bool confirmed = await showAppDialog(
      context,
      icon: AppIconName.trash,
      tone: AppDialogTone.solid,
      title: t.tags.deleteSelectedTitle(n: n),
      message: t.tags.deleteSelectedBody,
      confirmLabel: t.tags.deleteTags(n: n),
    );
    if (confirmed) await cubit.delete(cubit.state.selected.toList());
  }

  /// Long press: the swipe's two actions in a menu, as My Vaults.
  Future<void> _menu(BuildContext anchor, TagInfo tag) async {
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
        await _rename(anchor, tag);
      case _Action.delete:
        await _delete(anchor, tag);
    }
  }

  /// A tag opens the Vault tab filtered by it (board `Tags` 01).
  void _open(BuildContext context, TagInfo tag) {
    context.read<VaultListCubit>().showTag(tag.name);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final TagsCubit cubit = context.read<TagsCubit>();
    final TagsState state = context.watch<TagsCubit>().state;
    final bool selecting = state.selecting;
    final int n = state.selected.length;
    final double bottom = MediaQuery.paddingOf(context).bottom;

    return BlocListener<TagsCubit, TagsState>(
      listenWhen: (TagsState a, TagsState b) => a.selecting != b.selecting,
      // Selection swaps the tab bar for its counted action (board `S5-08`).
      listener: (BuildContext context, TagsState state) =>
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
                      label: t.tags.deleteTags(n: n),
                      icon: AppIconName.trash,
                      variant: AppButtonVariant.destructive,
                      size: AppButtonSize.medium,
                      onPressed: n == 0 ? null : () => _deleteSelected(context),
                    ),
                  ],
                )
              : null,
          body: AppLargeTitleScrollView(
            title: t.tags.title,
            subtitle: selecting ? t.tags.selected(n: n) : t.tags.subtitle,
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
                    if (state.tags.isNotEmpty)
                      AppLinkButton.bar(
                        label: t.vaultList.select,
                        onPressed: cubit.startSelecting,
                      ),
                    AppIconButton(
                      icon: AppIconName.plus,
                      semanticLabel: t.tags.addTag,
                      onPressed: () => _add(context),
                    ),
                  ],
            slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
                sliver: SliverToBoxAdapter(
                  child: state.tags.isEmpty
                      ? _NoTagsYet(onAdd: () => _add(context))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            AppInsetGroup(
                              dividerInset: AppDividerInset.item,
                              children: <Widget>[
                                for (final TagInfo tag in state.tags)
                                  _TagRow(
                                    tag: tag,
                                    selecting: selecting,
                                    selected: state.selected.contains(tag.name),
                                    onTap: () => selecting
                                        ? cubit.toggle(tag.name)
                                        : _open(context, tag),
                                    onRename: () => _rename(context, tag),
                                    onDelete: () => _delete(context, tag),
                                    onMenu: (BuildContext anchor) =>
                                        _menu(anchor, tag),
                                  ),
                              ],
                            ),
                            if (!selecting) AppFootnote(t.tags.footer),
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

class _TagRow extends StatelessWidget {
  const _TagRow({
    required this.tag,
    required this.selecting,
    required this.selected,
    required this.onTap,
    required this.onRename,
    required this.onDelete,
    required this.onMenu,
  });

  final TagInfo tag;
  final bool selecting;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onRename;
  final VoidCallback onDelete;
  final ValueChanged<BuildContext> onMenu;

  @override
  Widget build(BuildContext context) {
    final String locale = LocaleSettings.currentLocale.languageCode;
    final DateTime? created = tag.created;
    final Widget row = Builder(
      builder: (BuildContext anchor) => AppManageRow(
        // The tag's colour on a neutral tile (board `S5-07`).
        tile: AppIconTile(
          AppTileChild(AppTagGlyph(tag.name, size: 16)),
          tone: AppTileTone.muted,
        ),
        title: tag.name,
        subtitle: created == null
            ? null
            : t.tags.since(date: formatMediumDate(created.toLocal(), locale)),
        count: tag.count,
        countLabel: t.tags.itemCount(n: tag.count),
        selected: selecting ? selected : null,
        onTap: onTap,
        onLongPress: selecting ? null : () => onMenu(anchor),
      ),
    );
    if (selecting) return row;
    return AppSwipeActions(
      fullSwipe: false,
      actionWidth: 76,
      actions: <AppSwipeAction>[
        AppSwipeAction(
          icon: AppIconName.pencil,
          label: t.common.rename,
          semanticLabel: t.tags.renameAria(name: tag.name),
          tone: AppSwipeTone.accent,
          onPressed: onRename,
        ),
        AppSwipeAction(
          icon: AppIconName.trash,
          label: t.vaultList.delete,
          semanticLabel: t.tags.deleteAria(name: tag.name),
          tone: AppSwipeTone.destructive,
          onPressed: onDelete,
        ),
      ],
      child: row,
    );
  }
}

/// "No tags yet" (board `S5-12`, the web's words).
class _NoTagsYet extends StatelessWidget {
  const _NoTagsYet({required this.onAdd});

  final VoidCallback onAdd;

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
              AppTileGlyph(FaGlyphs.tag),
              size: AppTileSize.empty,
            ),
          ),
          Text(
            t.tags.emptyTitle,
            textAlign: TextAlign.center,
            style: styles
                .title()
                .resized(18, line: 24, weight: FontWeight.w800, tracking: 0)
                .copyWith(color: colors.foreground),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 280.w),
            child: Text(
              t.tags.emptyBody,
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
              label: t.tags.addTag,
              icon: AppIconName.plus,
              expand: false,
              onPressed: onAdd,
            ),
          ),
        ],
      ),
    );
  }
}
