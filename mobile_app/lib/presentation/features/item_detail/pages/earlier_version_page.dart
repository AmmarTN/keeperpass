import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/utils/items/item_history.dart';
import 'package:keeperpass/core/utils/text/date_formats.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/models/items/history_entry.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_inset_group.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pill.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_section_label.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_banner.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/common/widgets/overlays/app_dialog.dart';
import 'package:keeperpass/presentation/features/item_detail/cubit/item_detail_cubit.dart';
import 'package:keeperpass/presentation/features/item_detail/widgets/item_fields.dart';
import 'package:keeperpass/presentation/features/item_detail/widgets/item_history.dart';
import 'package:keeperpass/presentation/features/vault_list/widgets/vault_rows.dart';

/// Pushes the earlier version at [index] (board `S3-25`: "Pushed from
/// History; back returns to GitHub").
Future<void> openEarlierVersion(
  BuildContext context, {
  required ItemDetailCubit cubit,
  required int index,
}) => Navigator.of(context).push(
  MaterialPageRoute<void>(
    builder: (_) => BlocProvider<ItemDetailCubit>.value(
      value: cubit,
      child: EarlierVersionScreen(index: index),
    ),
  ),
);

/// An earlier version, read-only and shown in full (your answer, Part 8;
/// web history view): its fields, marked where they differ now, then
/// Restore and Delete version — both confirmed.
class EarlierVersionScreen extends StatefulWidget {
  const EarlierVersionScreen({required this.index, super.key});

  final int index;

  @override
  State<EarlierVersionScreen> createState() => _EarlierVersionScreenState();
}

class _EarlierVersionScreenState extends State<EarlierVersionScreen>
    with ToastsOverTabBar<EarlierVersionScreen> {
  /// The version, kept once read: restoring or deleting it changes the
  /// item's history underneath this screen as it closes.
  HistoryEntry? _entry;

  Future<void> _restore(String name, HistoryEntry entry) async {
    final ItemDetailCubit cubit = context.read<ItemDetailCubit>();
    final String date = formatMediumDate(
      entry.updated.toLocal(),
      LocaleSettings.currentLocale.languageCode,
    );
    final bool confirmed = await showAppDialog(
      context,
      icon: AppIconName.undo2,
      title: t.itemDetail.restoreTitle,
      message: t.itemDetail.restoreBody(name: name, date: date),
      confirmLabel: t.itemDetail.restore,
    );
    if (!confirmed || !mounted) return;
    if (await cubit.restore(widget.index) && mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _delete() async {
    final ItemDetailCubit cubit = context.read<ItemDetailCubit>();
    final bool confirmed = await showAppDialog(
      context,
      icon: AppIconName.trash,
      tone: AppDialogTone.solid,
      title: t.itemDetail.deleteVersionTitle,
      message: t.itemDetail.deleteVersionConfirm,
      confirmLabel: t.itemDetail.delete,
    );
    if (!confirmed || !mounted) return;
    if (await cubit.deleteVersion(widget.index) && mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final ItemDetailState state = context.watch<ItemDetailCubit>().state;
    final VaultItem? item = state.item;
    if (item != null && widget.index < item.history.length && _entry == null) {
      _entry = item.history[widget.index];
    }
    final HistoryEntry? entry = _entry;
    final String name = state.row == null ? '' : rowName(state.row!);
    final DateTime now = context.read<ItemDetailCubit>().now();
    final String locale = LocaleSettings.currentLocale.languageCode;
    final EdgeInsets insets = MediaQuery.paddingOf(context);

    return Scaffold(
      backgroundColor: colors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: insets.top),
            child: SizedBox(
              height: 44.h,
              child: Padding(
                padding: EdgeInsets.only(left: 2.w, right: 4.w),
                child: Row(
                  children: <Widget>[
                    AppLinkButton.back(
                      label: name,
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                    Expanded(
                      child: Semantics(
                        header: true,
                        child: Text(
                          t.itemDetail.earlierVersion,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles(
                            context,
                          ).navTitle().copyWith(color: colors.foreground),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (entry != null && item != null)
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(
                  16.w,
                  12.h,
                  16.w,
                  insets.bottom + 24.h,
                ),
                children: <Widget>[
                  AppBanner(
                    tone: AppBannerTone.info,
                    icon: AppIconName.rotateCcwClock,
                    title: versionDate(entry.updated, now, locale),
                    body: state.relativeTime == null
                        ? null
                        : t.itemDetail.readOnly(
                            ago: state.relativeTime!.format(
                              entry.updated,
                              now: now,
                              locale: locale,
                            ),
                          ),
                  ),
                  AppSectionLabel(
                    t.itemDetail.fields,
                    icon: AppIconName.textCursorInput,
                  ),
                  AppInsetGroup(
                    children: <Widget>[
                      if (entry.fields.isEmpty)
                        Padding(
                          padding: EdgeInsets.all(14.r),
                          child: Text(
                            t.itemDetail.noFields,
                            style: AppTextStyles(
                              context,
                            ).body().copyWith(color: colors.mutedForeground),
                          ),
                        ),
                      for (int i = 0; i < entry.fields.length; i++)
                        ItemFieldRow(
                          field: entry.fields[i],
                          revealed: true,
                          readOnly: true,
                          countryNames: state.countryNames,
                          labelTrailing:
                              historyFieldChanged(item.fields, entry.fields, i)
                              ? const _ChangedSince()
                              : null,
                        ),
                    ],
                  ),
                  SizedBox(height: 22.h),
                  AppButton(
                    label: t.itemDetail.restoreThisVersion,
                    icon: AppIconName.undo2,
                    onPressed: () => _restore(name, entry),
                  ),
                  SizedBox(height: 10.h),
                  AppButton(
                    label: t.itemDetail.deleteVersion,
                    icon: AppIconName.trash,
                    variant: AppButtonVariant.destructive,
                    onPressed: _delete,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// "Changed since" (`.pill`, 20 pt, accent).
class _ChangedSince extends StatelessWidget {
  const _ChangedSince();

  @override
  Widget build(BuildContext context) => AppPill(
    label: t.itemDetail.changedSince,
    tone: AppPillTone.accent,
    height: 20,
    horizontalPadding: 8,
    textStyle: (BuildContext context) => AppTextStyles(
      context,
    ).badge().resized(11, line: 14, weight: FontWeight.w700),
  );
}
