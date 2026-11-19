import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/constants/vault_file_names.dart';
import 'package:keeperpass/infrastructure/services/clipboard_service.dart';
import 'package:keeperpass/infrastructure/services/link_service.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_haptics.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/utils/provider_ui.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_backdrop.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_provider_button.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_explainers.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_vault_file_card.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/features/welcome/widgets/welcome_hero.dart';

/// What happened to the vault, shown over Welcome once the phone has signed
/// out (boards `S5-37` archived, `S5-29` moved, `S5-30` copied while the
/// old file kept its name). Pops with the provider to sign in to when the
/// person picks "Continue with Dropbox".
class FarewellPage extends StatelessWidget {
  const FarewellPage({
    required this.farewell,
    required this.links,
    required this.clipboard,
    super.key,
  });

  final SessionFarewell farewell;
  final LinkService links;
  final ClipboardService clipboard;

  Future<void> _copy(BuildContext context, String fileName) async {
    final AppToastHostState toasts = AppToastHost.of(context);
    await clipboard.copy(fileName);
    unawaited(AppHaptics.copy());
    toasts.show(
      AppToastData(
        icon: AppIconName.clipboardCheck,
        title: t.moveVault.fileNameCopied,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);

    final (
      Widget card,
      String title,
      String body,
      String? path,
      String fileName,
      bool glow,
    ) = switch (farewell) {
      ArchivedFarewell(
        :final ProviderId provider,
        :final String? renamedFile,
      ) =>
        (
          AppVaultFileCard(
            fileName: renamedFile ?? VaultFileNames.vault,
            meta: t.archive.doneMeta,
            icon: AppIconName.archive,
            tone: AppVaultFileTone.muted,
            badge: AppVaultFileBadge.lock,
            cipherPreview: kCipherPreview,
            dim: true,
            width: 300,
          ),
          t.archive.doneTitle,
          t.archive.doneBody(
            folder: provider.folderLabel,
            storage: provider.storageName,
          ),
          renamedFile == null
              ? null
              : '${provider.storageName} › ${provider.folderPath}/$renamedFile',
          renamedFile ?? VaultFileNames.vault,
          true,
        ),
      MovedFarewell(
        :final ProviderId from,
        :final ProviderId to,
        :final String? renamedFile,
      ) =>
        (
          AppVaultFileCard(
            fileName: VaultFileNames.vault,
            meta: t.moveVault.savedTo(storage: to.storageName),
            cipherPreview: kCipherPreview,
            width: 300,
          ),
          renamedFile == null
              ? t.moveVault.partlyTitle(storage: to.storageName)
              : t.moveVault.doneTitle(storage: to.storageName),
          renamedFile == null
              ? t.moveVault.partlyBody(from: from.storageName)
              : t.moveVault.doneBody(
                  provider: to.displayName,
                  from: from.storageName,
                ),
          renamedFile == null
              ? '${from.storageName} › ${from.folderPath}/${VaultFileNames.vault}'
              : '${from.folderPath}/$renamedFile',
          renamedFile ?? VaultFileNames.vault,
          renamedFile != null,
        ),
    };

    final List<Widget> actions = switch (farewell) {
      ArchivedFarewell() => <Widget>[
        AppButton(
          label: t.common.done,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      MovedFarewell(:final ProviderId to, renamedFile: final String _) =>
        <Widget>[
          AppProviderButton(
            provider: to.logo,
            label: to.continueLabel,
            onCard: true,
            onPressed: () => Navigator.of(context).pop(to),
          ),
          AppButton(
            label: t.common.done,
            variant: AppButtonVariant.secondary,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      MovedFarewell(:final ProviderId from) => <Widget>[
        AppButton(
          label: t.moveVault.open(storage: from.storageName),
          icon: AppIconName.externalLink,
          variant: AppButtonVariant.secondary,
          onPressed: () => unawaited(links.open(from.folderLink)),
        ),
        AppButton(
          label: t.common.done,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    };

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: <Widget>[
          if (glow)
            const Positioned.fill(
              child: AppBackdrop(glowLeft: -74, glowTop: -70),
            ),
          SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Semantics(
                        liveRegion: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: 16.h,
                          children: <Widget>[
                            Center(child: card),
                            Text(
                              title,
                              textAlign: TextAlign.center,
                              style: styles.appBarTitle().copyWith(
                                color: colors.foreground,
                              ),
                            ),
                            Text(
                              body,
                              textAlign: TextAlign.center,
                              style: styles.body().copyWith(
                                color: colors.mutedForeground,
                              ),
                            ),
                            if (path != null)
                              AppMonoCard(
                                text: path,
                                copyLabel: t.moveVault.copyFileName,
                                onCopy: () => _copy(context, fileName),
                              ),
                            if (farewell is ArchivedFarewell)
                              Text(
                                t.archive.signedOut,
                                textAlign: TextAlign.center,
                                style: styles.secondary().copyWith(
                                  color: colors.mutedForeground,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 10.h,
                    children: actions,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
