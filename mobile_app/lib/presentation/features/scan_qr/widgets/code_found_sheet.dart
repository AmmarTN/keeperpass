import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/utils/crypto/otpauth.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/models/general/cubitStatus.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_inset_group.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_section_label.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_surface.dart';
import 'package:keeperpass/presentation/common/widgets/bottom_sheet/app_sheet.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_live_totp.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_totp_ring.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_banner.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_settings_row.dart';
import 'package:keeperpass/presentation/features/scan_qr/cubit/scan_cubit.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_view.dart';
import 'package:keeperpass/presentation/features/vault_list/widgets/vault_rows.dart';

/// "Code Found" (board `S6-29`): the code's live value right away, then
/// where it goes — the items named like its site, or a new Authenticator
/// item — and "Save code". From Edit ([forField]) the code is for the field
/// being edited, so there is no choice. Pops the [ScanOutcome], or null
/// when closed.
class CodeFoundSheet extends StatelessWidget {
  const CodeFoundSheet({required this.forField, super.key});

  final bool forField;

  Future<void> _save(BuildContext context, OtpauthCode code) async {
    final NavigatorState navigator = Navigator.of(context);
    if (forField) {
      navigator.pop(FieldKey(code.secret));
      return;
    }
    final CodeAdded? added = await context.read<ScanCubit>().save();
    if (added != null && navigator.mounted) navigator.pop(added);
  }

  @override
  Widget build(BuildContext context) {
    final ScanCubit cubit = context.read<ScanCubit>();
    final ScanState state = context.watch<ScanCubit>().state;
    final OtpauthCode? code = state.found;
    if (code == null) return const SizedBox.shrink();
    final String? failure =
        state.status.action == CubitAction.saveCode &&
            state.status.statusType == CubitStatusType.failure
        ? state.status.errorMsg
        : null;
    final String newName = newItemName(code);

    return AppSheet(
      title: t.scan.codeFound,
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _FoundCard(
              code: code,
              target: forField ? null : state.target,
              now: cubit.now,
            ),
            if (!forField) ...<Widget>[
              // 14 pt gap, the wrapper's -10 and the label's own 18.
              AppSectionLabel(
                t.scan.saveTo,
                margin: EdgeInsets.only(top: 22.h, bottom: 6.h),
              ),
              AppInsetGroup(
                dividerInset: AppDividerInset.settings,
                children: <Widget>[
                  for (final VaultRow row in state.matches)
                    AppSettingsRow.radio(
                      title: rowName(row),
                      subtitle: row.summary == null
                          ? t.scan.existingItem
                          : t.scan.existingItemWith(summary: row.summary!),
                      leading: VaultItemTile(row, size: AppTileSize.settings),
                      selected: state.targetId == row.id,
                      onTap: () => cubit.choose(row.id),
                    ),
                  AppSettingsRow.radio(
                    title: t.scan.newAuthenticator,
                    subtitle: t.scan.named(name: newName),
                    leading: const AppIconTile(
                      AppTileGlyph(FaGlyphs.totp),
                      size: AppTileSize.settings,
                    ),
                    selected: state.targetId == null,
                    onTap: () => cubit.choose(null),
                  ),
                ],
              ),
            ],
            if (failure != null)
              Padding(
                padding: EdgeInsets.only(top: 14.h),
                child: AppBanner(
                  tone: AppBannerTone.error,
                  icon: AppIconName.circleAlert,
                  title: failure,
                ),
              ),
            SizedBox(height: 14.h),
            AppButton(
              label: t.editItem.saveCode,
              icon: AppIconName.check,
              busy: state.saving,
              onPressed: () => unawaited(_save(context, code)),
            ),
          ],
        ),
      ),
    );
  }
}

/// The code's card (`.card`): the item it goes to (else the Authenticator
/// tile), the site and account, and the live code with its ring.
class _FoundCard extends StatelessWidget {
  const _FoundCard({
    required this.code,
    required this.target,
    required this.now,
  });

  final OtpauthCode code;
  final VaultRow? target;
  final DateTime Function() now;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final VaultRow? row = target;
    final String name = newItemName(code);
    // The account under the site; not twice when it is the name.
    final String? account = code.issuer == null ? null : code.account;

    return AppSurface(
      padding: EdgeInsets.all(14.r),
      child: Row(
        spacing: 12.w,
        children: <Widget>[
          if (row != null)
            VaultItemTile(row)
          else
            const AppIconTile(AppTileGlyph(FaGlyphs.totp)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 1.h,
              children: <Widget>[
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: styles.rowTitle().copyWith(color: colors.foreground),
                ),
                if (account != null)
                  Text(
                    account,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: styles.secondary().copyWith(
                      color: colors.mutedForeground,
                    ),
                  ),
              ],
            ),
          ),
          RepaintBoundary(
            child: AppLiveTotp(
              secret: code.secret,
              now: now,
              builder: (BuildContext context, String? value, int secondsLeft) =>
                  Row(
                    spacing: 8.w,
                    children: <Widget>[
                      Text(
                        value == null ? '' : splitTotpCode(value),
                        style: styles
                            .code()
                            .resized(20, line: 26, weight: FontWeight.w700)
                            .copyWith(color: colors.foreground),
                      ),
                      AppTotpRing(secondsLeft: secondsLeft, size: 22),
                    ],
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
