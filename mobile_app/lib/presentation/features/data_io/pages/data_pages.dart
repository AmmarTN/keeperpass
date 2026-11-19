import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:keeperpass/core/utils/text/date_formats.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/models/vault/export_record.dart';
import 'package:keeperpass/infrastructure/services/file_service.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/common/cubit/bottom_nav_bar/bottom_nav_cubit.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_inset_group.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_section_label.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_banner.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_text_field.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_settings_row.dart';
import 'package:keeperpass/presentation/features/data_io/cubit/export_cubit.dart';
import 'package:keeperpass/presentation/features/data_io/cubit/import_cubit.dart';
import 'package:keeperpass/presentation/features/settings/pages/choice_pages.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_cubit.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_view.dart';

/// "24 KB" — the picked file's size.
String fileSizeText(int bytes) {
  if (bytes < 1024 * 1024) {
    return t.dataIo.kilobytes(n: (bytes / 1024).round().clamp(1, 1023));
  }
  return t.dataIo.megabytes(
    n: NumberFormat(
      '0.#',
      LocaleSettings.currentLocale.languageCode,
    ).format(bytes / (1024 * 1024)),
  );
}

/// Import with its own cubit, on [file] (already picked).
class ImportPage extends StatelessWidget {
  const ImportPage({required this.file, this.backLabel, super.key});

  final PickedTextFile file;
  final String? backLabel;

  @override
  Widget build(BuildContext context) => BlocProvider<ImportCubit>(
    create: (_) => getIt<ImportCubit>()..load(file),
    child: ImportScreen(backLabel: backLabel),
  );
}

/// The file, what was found in it, and the vault it goes to (boards
/// `S5-32`, `S5-33`). After Import, the Vault tab opens on that vault.
class ImportScreen extends StatelessWidget {
  const ImportScreen({this.backLabel, super.key});

  final String? backLabel;

  Future<void> _import(BuildContext context) async {
    final VaultListCubit list = context.read<VaultListCubit>();
    final BottomNavCubit nav = context.read<BottomNavCubit>();
    final NavigatorState navigator = Navigator.of(context);
    final String? vaultId = await context.read<ImportCubit>().import();
    if (vaultId == null) return;
    navigator.pop();
    list.setScope(VaultScope.vault, vaultId: vaultId);
    nav.openTabRoot(0, tabCount: 5);
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final ImportCubit cubit = context.read<ImportCubit>();
    final ImportState state = context.watch<ImportCubit>().state;
    final bool failed = state.error != null;
    final int found = state.drafts.length;

    return SettingsChoicePage(
      title: t.dataIo.importTitle,
      backLabel: backLabel,
      children: <Widget>[
        AppSectionLabel(t.dataIo.file),
        AppInsetGroup(
          dividerInset: AppDividerInset.settings,
          children: <Widget>[
            AppSettingsRow(
              leading: AppIconTile(
                AppTileIcon(
                  failed ? AppIconName.fileXCorner : AppIconName.fileText,
                ),
                size: AppTileSize.settings,
                tone: failed ? AppTileTone.destructive : AppTileTone.accent,
              ),
              title: state.fileName,
              monoTitle: true,
              subtitle: state.size == null
                  ? null
                  : t.dataIo.fileMeta(size: fileSizeText(state.size!)),
              trailing: AppLinkButton(
                label: t.dataIo.change,
                horizontalPadding: 4,
                onPressed: cubit.change,
              ),
            ),
          ],
        ),
        if (failed) ...<Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(4.w, 10.h, 4.w, 0),
            child: AppFieldError(
              state.error == ImportError.invalidCsv
                  ? t.dataIo.invalidCsv
                  : t.dataIo.noItems,
            ),
          ),
          AppFootnote(t.dataIo.notCsvNote),
          SizedBox(height: 18.h),
          AppButton(
            label: t.dataIo.chooseAnother,
            icon: AppIconName.fileText,
            variant: AppButtonVariant.secondary,
            onPressed: cubit.change,
          ),
        ] else ...<Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(4.w, 12.h, 4.w, 0),
            child: Semantics(
              liveRegion: true,
              child: Row(
                spacing: 8.w,
                children: <Widget>[
                  AppIcon(
                    AppIconName.circleCheck,
                    size: 18,
                    stroke: 2.25,
                    color: colors.accentStrong,
                  ),
                  Expanded(
                    child: Text(
                      t.dataIo.found(n: found),
                      style: AppTextStyles(context)
                          .button()
                          .resized(15, line: 20)
                          .copyWith(color: colors.accentStrong),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AppSectionLabel(t.dataIo.addTo),
          AppInsetGroup(
            dividerInset: AppDividerInset.settings,
            children: <Widget>[
              for (final ImportVault vault in state.vaults)
                AppSettingsRow.radio(
                  leading: const AppIconTile(
                    AppTileGlyph(FaGlyphs.vault),
                    size: AppTileSize.settings,
                  ),
                  title: vault.label,
                  subtitle: t.vaultList.itemCount(n: vault.items),
                  selected: vault.id == state.vaultId,
                  onTap: () => cubit.setVault(vault.id),
                ),
            ],
          ),
          AppFootnote(t.dataIo.importNote),
          SizedBox(height: 18.h),
          AppButton(
            label: t.dataIo.importButton(n: found),
            icon: AppIconName.download,
            onPressed: state.canImport ? () => _import(context) : null,
          ),
        ],
      ],
    );
  }
}

/// Export with its own cubit.
class ExportPage extends StatelessWidget {
  const ExportPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<ExportCubit>(
    create: (_) => getIt<ExportCubit>(),
    child: const ExportScreen(),
  );
}

/// Which vault to write, the warning, and the share sheet (board `S5-34`).
/// Back to Settings once the sheet closes, as the web's dialog.
class ExportScreen extends StatelessWidget {
  const ExportScreen({super.key});

  Future<void> _export(BuildContext context) async {
    final NavigatorState navigator = Navigator.of(context);
    final ExportCubit cubit = context.read<ExportCubit>();
    final int before = cubit.state.sources.length;
    await cubit.export();
    if (before > 0 && navigator.mounted) navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final ExportCubit cubit = context.read<ExportCubit>();
    final ExportState state = context.watch<ExportCubit>().state;
    return SettingsChoicePage(
      title: t.dataIo.exportTitle,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: Text(
            t.dataIo.exportIntro,
            style: AppTextStyles(
              context,
            ).body().copyWith(color: colors.mutedForeground),
          ),
        ),
        AppSectionLabel(t.dataIo.sourceVault),
        AppInsetGroup(
          dividerInset: AppDividerInset.settings,
          children: <Widget>[
            for (final ExportSource source in state.sources)
              AppSettingsRow.radio(
                leading: AppIconTile(
                  source.vaultId == null
                      ? const AppTileIcon(AppIconName.layers)
                      : const AppTileGlyph(FaGlyphs.vault),
                  size: AppTileSize.settings,
                ),
                title: source.label,
                subtitle: t.vaultList.itemCount(n: source.items),
                selected: source.vaultId == state.vaultId,
                onTap: () => cubit.choose(source.vaultId),
              ),
          ],
        ),
        SizedBox(height: 14.h),
        AppBanner(
          tone: AppBannerTone.warning,
          icon: AppIconName.triangleAlert,
          title: t.dataIo.notEncryptedTitle,
          body: t.dataIo.notEncryptedBody,
        ),
        SizedBox(height: 16.h),
        AppButton(
          label: t.dataIo.exportButton(n: state.source?.items ?? 0),
          icon: AppIconName.share,
          busy: state.exporting,
          onPressed: state.canExport ? () => _export(context) : null,
        ),
        AppFootnote(t.dataIo.exportNote),
      ],
    );
  }
}

/// The exports remembered in the vault, newest first (board `S5-35`).
class RecentExportsPage extends StatelessWidget {
  const RecentExportsPage({required this.exports, super.key});

  final List<ExportRecord> exports;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final String locale = LocaleSettings.currentLocale.languageCode;
    return SettingsChoicePage(
      title: t.dataIo.recentTitle,
      children: <Widget>[
        if (exports.isEmpty)
          // The web's empty list: one quiet line in a box.
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: colors.border),
            ),
            child: Text(
              t.dataIo.recentEmpty,
              textAlign: TextAlign.center,
              style: AppTextStyles(
                context,
              ).body().copyWith(color: colors.mutedForeground),
            ),
          )
        else
          AppInsetGroup(
            dividerInset: AppDividerInset.settings,
            children: <Widget>[
              for (final ExportRecord record in exports)
                AppSettingsRow(
                  leading: const AppIconTile(
                    AppTileIcon(AppIconName.fileText),
                    size: AppTileSize.settings,
                  ),
                  title: t.dataIo.recentRow(
                    scope: record.scope,
                    n: record.itemCount,
                  ),
                  subtitle: formatDateTime(record.at.toLocal(), locale),
                ),
            ],
          ),
        AppFootnote(t.dataIo.recentNote),
      ],
    );
  }
}
