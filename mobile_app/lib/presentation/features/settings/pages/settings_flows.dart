import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/constants/app_links.dart';
import 'package:keeperpass/infrastructure/services/file_service.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/features/change_secret/pages/change_secret_page.dart';
import 'package:keeperpass/presentation/features/data_io/cubit/import_cubit.dart';
import 'package:keeperpass/presentation/features/data_io/pages/data_pages.dart';
import 'package:keeperpass/presentation/features/move_vault/pages/move_vault_page.dart';
import 'package:keeperpass/presentation/features/settings/cubit/settings_cubit.dart';
import 'package:keeperpass/presentation/features/settings/pages/archive_page.dart';
import 'package:keeperpass/presentation/features/settings/pages/choice_pages.dart';
import 'package:keeperpass/presentation/features/settings/pages/help_pages.dart';
import 'package:keeperpass/presentation/features/settings/pages/storage_page.dart';
import 'package:keeperpass/presentation/features/technical_details/widgets/technical_details_sheet.dart';

// Where each Settings row leads. Pages under Settings are pushed inside its
// tab, with the tab bar (boards `S5-15` … `S5-17`, `S5-24`, `S5-32` …
// `S5-35`, `S5-38` … `S5-41`); the flows that change the vault's file or the
// session — Change secret, Move vault, Archive — cover everything, with
// Cancel (boards `S5-18`, `S5-25`, `S5-36`).

/// Pushes [page] inside the tab, with the Settings cubit it reads.
Future<T?> _push<T>(BuildContext context, Widget page) {
  final SettingsCubit settings = context.read<SettingsCubit>();
  return Navigator.of(context).push<T>(
    MaterialPageRoute<T>(
      builder: (_) =>
          BlocProvider<SettingsCubit>.value(value: settings, child: page),
    ),
  );
}

/// Pushes [page] over the tab bar, as a full-screen flow.
Future<T?> _cover<T>(BuildContext context, Widget page) => Navigator.of(
  context,
  rootNavigator: true,
).push<T>(MaterialPageRoute<T>(fullscreenDialog: true, builder: (_) => page));

void openAutoLock(BuildContext context) =>
    unawaited(_push<void>(context, const AutoLockPage()));

void openClearClipboard(BuildContext context) =>
    unawaited(_push<void>(context, const ClearClipboardPage()));

void openLanguage(BuildContext context) =>
    unawaited(_push<void>(context, const LanguagePage()));

/// Change secret; back on Settings with a quiet "Secret changed" toast
/// (board `Change-secret`).
Future<void> openChangeSecret(BuildContext context) async {
  final AppToastHostState toasts = AppToastHost.of(context);
  final bool? changed = await _cover<bool>(context, const ChangeSecretPage());
  if (changed ?? false) {
    toasts.show(
      AppToastData(icon: AppIconName.circleCheck, title: t.changeSecret.toast),
    );
  }
}

void openStorage(BuildContext context) => unawaited(
  _push<void>(
    context,
    Builder(
      builder: (BuildContext page) => StoragePage(
        onMove: (ProviderId destination) =>
            unawaited(openMoveVault(page, destination)),
      ),
    ),
  ),
);

/// Move vault to [destination]; a move that worked ends on Welcome.
Future<void> openMoveVault(BuildContext context, ProviderId destination) =>
    _cover<void>(context, MoveVaultPage(destination: destination));

/// Set while Import's system picker is on its way or up: a second tap opens
/// no second picker.
bool _picking = false;

/// Import CSV: the system picker first, then the Import screen on the
/// chosen file (nothing chosen, nothing opens). [backLabel] when it opens
/// from somewhere other than Settings.
Future<void> startImport(BuildContext context, {String? backLabel}) async {
  if (_picking) return;
  _picking = true;
  final NavigatorState navigator = Navigator.of(context);
  final PickedTextFile? file = await getIt<FileService>()
      .pickText(kImportExtensions)
      .whenComplete(() => _picking = false);
  if (file == null || !navigator.mounted) return;
  await navigator.push<void>(
    MaterialPageRoute<void>(
      builder: (_) => ImportPage(file: file, backLabel: backLabel),
    ),
  );
}

void openExport(BuildContext context) =>
    unawaited(_push<void>(context, const ExportPage()));

void openRecentExports(BuildContext context) => unawaited(
  _push<void>(
    context,
    RecentExportsPage(exports: context.read<SettingsCubit>().state.exports),
  ),
);

void openHowItWorks(BuildContext context) {
  final SettingsCubit settings = context.read<SettingsCubit>();
  unawaited(
    _push<void>(
      context,
      Builder(
        builder: (BuildContext page) => HowItWorksPage(
          onTechnicalDetails: () => unawaited(
            showTechnicalDetailsSheet(
              page,
              onViewSource: () =>
                  unawaited(settings.openLink(AppLinks.sourceCode)),
            ),
          ),
        ),
      ),
    ),
  );
}

void openQuestions(BuildContext context) =>
    unawaited(_push<void>(context, const QuestionsPage()));

void openAbout(BuildContext context) =>
    unawaited(_push<void>(context, const AboutPage()));

/// Archive vault and sign out; a rename that worked ends on Welcome.
Future<void> openArchive(BuildContext context) =>
    _cover<void>(context, ArchivePage(now: context.read<SettingsCubit>().now));
