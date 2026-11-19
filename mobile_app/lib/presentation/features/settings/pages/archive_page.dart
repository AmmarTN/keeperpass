import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/constants/vault_file_names.dart';
import 'package:keeperpass/infrastructure/extensions/failures.dart';
import 'package:keeperpass/infrastructure/models/general/cubitStatus.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/utils/param_spans.dart';
import 'package:keeperpass/presentation/common/utils/provider_ui.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_explainers.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_banner.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_text_field.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_bars.dart';

/// What must be typed before Archive does anything (web
/// `DELETE_CONFIRMATION`; the board's word). Not translated, as the web's.
const String kArchiveConfirmation = 'ARCHIVE';

/// "Archive vault and sign out" (board `S5-36`; web
/// `DangerZoneSection.deleteAccount`): what happens, in order, and the word
/// to type. The rename and the sign-out are the session's; Welcome then
/// shows the renamed file. A failed rename keeps this screen with the
/// reason, and nothing is signed out.
class ArchivePage extends StatefulWidget {
  const ArchivePage({required this.now, super.key});

  /// For the name the file will get.
  final DateTime Function() now;

  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  final TextEditingController _confirmation = TextEditingController();
  late final String _renamed = VaultFileNames.removed(widget.now());

  @override
  void initState() {
    super.initState();
    _confirmation.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _confirmation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final SessionCubit session = context.read<SessionCubit>();
    final SessionState state = context.watch<SessionCubit>().state;
    final ProviderId? provider = state.account?.provider;
    final String storage = provider?.storageName ?? '';
    final bool archiving =
        state.status.action == CubitAction.archiveVault &&
        state.status.statusType == CubitStatusType.loading;
    final Failure? failure =
        state.status.action == CubitAction.archiveVault &&
            state.status.statusType == CubitStatusType.failure
        ? state.failure
        : null;
    final bool confirmed = _confirmation.text == kArchiveConfirmation;
    final TextStyle mono = styles
        .fileName()
        .resized(13, line: 21)
        .copyWith(color: colors.foreground);

    return PopScope<void>(
      canPop: !archiving,
      child: Scaffold(
        backgroundColor: colors.background,
        body: Column(
          children: <Widget>[
            SafeArea(
              bottom: false,
              child: AppCompactBar(
                title: t.archive.title,
                leading: AppLinkButton.bar(
                  label: t.common.cancel,
                  onPressed: archiving
                      ? null
                      : () => Navigator.of(context).maybePop(),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(
                  16.w,
                  18.h,
                  16.w,
                  40.h + MediaQuery.paddingOf(context).bottom,
                ),
                children: <Widget>[
                  Column(
                    spacing: 10.h,
                    children: <Widget>[
                      const AppIconTile(
                        AppTileIcon(AppIconName.archive),
                        size: AppTileSize.header,
                        tone: AppTileTone.destructive,
                      ),
                      Text(
                        t.archive.headline,
                        textAlign: TextAlign.center,
                        style: styles.appBarTitle().copyWith(
                          color: colors.foreground,
                        ),
                      ),
                      Text(
                        t.archive.body(storage: storage),
                        textAlign: TextAlign.center,
                        style: styles.body().copyWith(
                          color: colors.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18.h),
                  AppNumberedList(
                    items: <Widget>[
                      Text.rich(
                        TextSpan(
                          children: spansWithParams(
                            (List<String> m) => t.archive.step1(
                              oldName: m[0],
                              newName: m[1],
                              folder: provider?.folderLabel ?? '',
                            ),
                            <InlineSpan>[
                              TextSpan(text: VaultFileNames.vault, style: mono),
                              TextSpan(
                                text: breakableFileName(_renamed),
                                style: mono,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(t.archive.step2(storage: storage)),
                      Text(t.archive.step3(storage: storage)),
                    ],
                  ),
                  SizedBox(height: 18.h),
                  Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        TextSpan(text: '${t.archive.typePrefix} '),
                        TextSpan(
                          text: kArchiveConfirmation,
                          style: styles
                              .fileName()
                              .resized(14, line: 20, weight: FontWeight.w700)
                              .copyWith(color: colors.foreground),
                        ),
                        TextSpan(text: ' ${t.archive.typeSuffix}'),
                      ],
                    ),
                    style: styles.formLabel().copyWith(
                      color: colors.foreground,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  AppTextField(
                    controller: _confirmation,
                    semanticLabel: t.archive.confirmation,
                    mono: true,
                    enabled: !archiving,
                    autocorrect: false,
                    enableSuggestions: false,
                    textCapitalization: TextCapitalization.characters,
                    textInputAction: TextInputAction.done,
                  ),
                  if (failure != null) ...<Widget>[
                    SizedBox(height: 16.h),
                    AppBanner(
                      tone: AppBannerTone.error,
                      icon: AppIconName.triangleAlert,
                      title: failure.getMessage(),
                    ),
                  ],
                  SizedBox(height: 16.h),
                  AppButton(
                    label: t.archive.button,
                    icon: AppIconName.archive,
                    variant: AppButtonVariant.destructive,
                    busy: archiving,
                    onPressed: confirmed
                        ? () => unawaited(session.archiveVault())
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
