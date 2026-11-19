import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/utils/items/card_face.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/models/audit/audit_result.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/common/cubit/audit/audit_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/sync/sync_cubit.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_inset_group.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_section_label.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/common/widgets/overlays/app_menu.dart';
import 'package:keeperpass/presentation/features/edit_item/pages/edit_item_page.dart';
import 'package:keeperpass/presentation/features/item_detail/cubit/item_detail_cubit.dart';
import 'package:keeperpass/presentation/features/item_detail/pages/earlier_version_page.dart';
import 'package:keeperpass/presentation/features/item_detail/pages/large_type_page.dart';
import 'package:keeperpass/presentation/features/item_detail/widgets/item_fields.dart';
import 'package:keeperpass/presentation/features/item_detail/widgets/item_finding_card.dart';
import 'package:keeperpass/presentation/features/item_detail/widgets/item_header.dart';
import 'package:keeperpass/presentation/features/item_detail/widgets/item_history.dart';
import 'package:keeperpass/presentation/features/security/widgets/fix_outcome.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_view.dart';
import 'package:keeperpass/presentation/features/vault_list/pages/vault_list_page.dart';
import 'package:keeperpass/presentation/features/vault_list/widgets/vault_rows.dart';
import 'package:keeperpass/presentation/features/vault_list/widgets/vault_sheets.dart';

/// Opens an item over the tab bar — the boards draw every item screen
/// without it. [backLabel] is the title of the screen it came from;
/// [onShowTag] (from the Vault list) makes its tags filter the list. With
/// [returnAfterFix] (from the Security report), saving "Change password"
/// closes the item too and hands back the fix's outcome (your answer, Part
/// 11); otherwise the item shows it.
Future<Future<FixOutcome?>?> openItem(
  BuildContext context, {
  required String itemId,
  required String backLabel,
  ValueChanged<String>? onShowTag,
  bool returnAfterFix = false,
}) => Navigator.of(context, rootNavigator: true).push(
  MaterialPageRoute<Future<FixOutcome?>>(
    builder: (_) => ItemDetailPage(
      itemId: itemId,
      backLabel: backLabel,
      onShowTag: onShowTag,
      returnAfterFix: returnAfterFix,
    ),
  ),
);

/// The item screen with its own cubit.
class ItemDetailPage extends StatelessWidget {
  const ItemDetailPage({
    required this.itemId,
    required this.backLabel,
    this.onShowTag,
    this.returnAfterFix = false,
    super.key,
  });

  final String itemId;
  final String backLabel;
  final ValueChanged<String>? onShowTag;
  final bool returnAfterFix;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemDetailCubit>(
      create: (_) => getIt<ItemDetailCubit>()..open(itemId),
      child: ItemDetailScreen(
        backLabel: backLabel,
        onShowTag: onShowTag,
        returnAfterFix: returnAfterFix,
      ),
    );
  }
}

/// One item (boards `S3-19` … `S3-36`).
class ItemDetailScreen extends StatefulWidget {
  const ItemDetailScreen({
    required this.backLabel,
    this.onShowTag,
    this.returnAfterFix = false,
    super.key,
  });

  final String backLabel;
  final ValueChanged<String>? onShowTag;

  /// Opened from the Security report: a saved fix goes back to it.
  final bool returnAfterFix;

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen>
    with ToastsOverTabBar<ItemDetailScreen> {
  final ScrollController _scroll = ScrollController();
  final ValueNotifier<double> _offset = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    _scroll.addListener(
      () => _offset.value = _scroll.hasClients ? _scroll.offset : 0,
    );
  }

  @override
  void dispose() {
    _scroll.dispose();
    _offset.dispose();
    super.dispose();
  }

  /// Edit; "Fix it in Edit" on a 2FA field passes its position, so Edit
  /// opens on it (your answer, Part 10).
  void _edit({int? field}) => unawaited(
    openEditItem(
      context,
      context.read<ItemDetailCubit>().state.itemId,
      focusField: field,
    ),
  );

  /// "Change password" (board `S4-20`): Edit with the Generate sheet up on
  /// the first password with a finding; once saved, the outcome goes back
  /// to the report, or shows here.
  Future<void> _changePassword() async {
    final String itemId = context.read<ItemDetailCubit>().state.itemId;
    final AuditCubit audit = context.read<AuditCubit>();
    final List<AuditResult> findings = audit.state.findingsFor(itemId);
    if (findings.isEmpty) return;
    final int field = findings
        .map((AuditResult r) => r.fieldIndex)
        .reduce(math.min);
    final EditSaved? saved = await openEditItem(
      context,
      itemId,
      focusField: field,
      generate: true,
    );
    if (saved == null || !mounted) return;
    final Future<FixOutcome?> outcome = watchFix(
      saved,
      sync: context.read<SyncCubit>(),
      audit: audit,
      storage:
          context.read<SessionCubit>().state.account?.provider.storageName ??
          '',
    );
    if (widget.returnAfterFix) {
      Navigator.of(context).pop(outcome);
      return;
    }
    final AppToastHostState toasts = AppToastHost.of(context);
    final FixOutcome? result = await outcome;
    if (result != null && mounted) showFixToast(toasts, result);
  }

  Future<void> _more(BuildContext anchor, VaultRow row) async {
    final ItemDetailCubit cubit = context.read<ItemDetailCubit>();
    final _MenuAction? action = await showAppMenu<_MenuAction>(
      anchor,
      width: 236,
      items: <AppMenuItem<_MenuAction>>[
        AppMenuItem<_MenuAction>(
          value: _MenuAction.move,
          label: t.vaultList.moveToVault,
          icon: AppIconName.folderInput,
        ),
        AppMenuItem<_MenuAction>(
          value: _MenuAction.delete,
          label: t.vaultList.deleteItemAction,
          icon: AppIconName.trash,
          destructive: true,
        ),
      ],
    );
    if (!mounted || action == null) return;
    switch (action) {
      case _MenuAction.move:
        await showMoveSheet(context, cubit, <VaultRow>[row]);
      case _MenuAction.delete:
        if (!await confirmDeleteItem(context, row)) return;
        // Its history goes with it; back to the list, which shows the save.
        if (await cubit.delete() && mounted) Navigator.of(context).pop();
    }
  }

  void _showTag(String tag) {
    Navigator.of(context).pop();
    widget.onShowTag!(tag);
  }

  @override
  Widget build(BuildContext context) {
    final ItemDetailState state = context.watch<ItemDetailCubit>().state;
    final VaultRow? row = state.row;
    return Scaffold(
      backgroundColor: context.colors.background,
      body: state.gone
          ? _GoneView(backLabel: widget.backLabel, offset: _offset)
          : row == null
          ? const SizedBox.shrink()
          : _content(context, state, row),
    );
  }

  Widget _content(BuildContext context, ItemDetailState state, VaultRow row) {
    final ItemDetailCubit cubit = context.read<ItemDetailCubit>();
    final VaultItem item = row.item;
    final DateTime now = cubit.now();
    final String locale = LocaleSettings.currentLocale.languageCode;
    final EdgeInsets insets = MediaQuery.paddingOf(context);
    final bool codeFirst =
        item.fields.isNotEmpty && item.fields.first.type == FieldType.totp;
    final int firstRow = codeFirst ? 1 : 0;

    return Stack(
      children: <Widget>[
        CustomScrollView(
          controller: _scroll,
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                16.w,
                insets.top + kItemBarHeight.h,
                16.w,
                insets.bottom + 40.h,
              ),
              sliver: SliverList.list(
                children: <Widget>[
                  ItemHeader(
                    row: row,
                    updated: state.relativeTime == null
                        ? null
                        : t.itemDetail.updatedAgo(
                            ago: state.relativeTime!.format(
                              item.updated,
                              now: now,
                              locale: locale,
                            ),
                          ),
                    onTag: widget.onShowTag == null ? null : _showTag,
                  ),
                  if (row.findings.isNotEmpty) ...<Widget>[
                    SizedBox(height: 20.h),
                    ItemFindingCard(
                      findings: row.findings,
                      onChangePassword: _changePassword,
                    ),
                  ],
                  AppSectionLabel(
                    t.itemDetail.fields,
                    icon: AppIconName.textCursorInput,
                  ),
                  if (codeFirst)
                    ItemCodeCard(
                      field: item.fields.first,
                      onEdit: () => _edit(field: 0),
                    ),
                  if (codeFirst && item.fields.length > 1)
                    SizedBox(height: 12.h),
                  if (item.fields.length > firstRow)
                    AppInsetGroup(
                      children: <Widget>[
                        for (int i = firstRow; i < item.fields.length; i++)
                          ItemFieldRow(
                            field: item.fields[i],
                            revealed: state.revealed.contains(i),
                            onToggleReveal: () => cubit.toggleReveal(i),
                            onLargeType: () => openLargeType(
                              context,
                              field: item.fields[i],
                              itemName: rowName(row),
                            ),
                            onEdit: () => _edit(field: i),
                            countryNames: state.countryNames,
                          ),
                      ],
                    ),
                  if (item.fields.isEmpty)
                    AppInsetGroup(
                      children: <Widget>[_NoFields(t.itemDetail.noFields)],
                    ),
                  if (item.history.isNotEmpty)
                    ItemHistorySection(
                      item: item,
                      now: now,
                      relativeTime: state.relativeTime,
                      onOpen: (int index) => openEarlierVersion(
                        context,
                        cubit: cubit,
                        index: index,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: ItemBar(
            offset: _offset,
            nameTop: itemNameTop(cardFaceOf(item) != null),
            backLabel: widget.backLabel,
            name: rowName(row),
            favourite: row.favourite,
            onFavourite: () => unawaited(cubit.toggleFavourite()),
            onEdit: _edit,
            onMore: (BuildContext anchor) => _more(anchor, row),
          ),
        ),
      ],
    );
  }
}

enum _MenuAction { move, delete }

class _NoFields extends StatelessWidget {
  const _NoFields(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.all(14.r),
    child: Text(
      text,
      style: AppTextStyles(
        context,
      ).body().copyWith(color: context.colors.mutedForeground),
    ),
  );
}

/// The item vanished — deleted on another device, or gone after a reload
/// (board `S3-28`).
class _GoneView extends StatelessWidget {
  const _GoneView({required this.backLabel, required this.offset});

  final String backLabel;
  final ValueNotifier<double> offset;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ItemBar(offset: offset, nameTop: 0, backLabel: backLabel, name: null),
        VaultEmptyLayout(
          icon: const AppTileIcon(AppIconName.fileXCorner),
          title: t.itemDetail.notFound,
          message: t.itemDetail.notFoundHint,
          topMargin: 150,
          actions: <Widget>[
            Center(
              child: AppButton(
                label: t.itemDetail.backToVault,
                variant: AppButtonVariant.secondary,
                expand: false,
                horizontalPadding: 20,
                onPressed: () => unawaited(Navigator.of(context).maybePop()),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
