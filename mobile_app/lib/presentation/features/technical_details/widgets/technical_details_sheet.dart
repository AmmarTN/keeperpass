import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/bottom_sheet/app_sheet.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';

/// Technical Details (board `Help`, S5-39; X5): the algorithms and storage
/// scopes, for whoever wants them, with the source one tap away. Opened from
/// How it works now, and from Settings › Help in Part 13.
Future<void> showTechnicalDetailsSheet(
  BuildContext context, {
  required VoidCallback onViewSource,
}) => showAppSheet<void>(
  context,
  builder: (BuildContext sheetContext) =>
      TechnicalDetailsSheet(onViewSource: onViewSource),
);

class TechnicalDetailsSheet extends StatelessWidget {
  const TechnicalDetailsSheet({required this.onViewSource, super.key});

  final VoidCallback onViewSource;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final TextStyle mono = styles
        .fileName()
        .resized(14, line: 22)
        .copyWith(color: colors.foreground);
    TextSpan code(String text) => TextSpan(text: text, style: mono);

    final List<(String, InlineSpan)> rows = <(String, InlineSpan)>[
      (
        t.technicalDetails.keyDerivation,
        t.technicalDetails.keyDerivationValue(algorithm: code('Argon2id')),
      ),
      (
        t.technicalDetails.encryption,
        t.technicalDetails.encryptionValue(algorithm: code('AES-256-GCM')),
      ),
      (
        t.technicalDetails.googleDrive,
        t.technicalDetails.googleDriveValue(scope: code('drive.file')),
      ),
      (
        t.technicalDetails.dropbox,
        t.technicalDetails.dropboxValue(folder: code('Apps/keeperpass')),
      ),
      (
        t.technicalDetails.vaultFile,
        t.technicalDetails.vaultFileValue(file: code('vault.json.enc')),
      ),
    ];

    return AppSheet(
      title: t.technicalDetails.title,
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 14.h,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: ColoredBox(
              color: colors.background,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  for (int i = 0; i < rows.length; i++)
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: i == 0
                            ? null
                            : Border(top: BorderSide(color: colors.border)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 2.h,
                          children: <Widget>[
                            Text(
                              rows[i].$1,
                              style: styles
                                  .secondary()
                                  .resized(
                                    13,
                                    line: 18,
                                    weight: FontWeight.w700,
                                  )
                                  .copyWith(color: colors.mutedForeground),
                            ),
                            Text.rich(
                              rows[i].$2,
                              style: styles.body().copyWith(
                                color: colors.foreground,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          AppButton(
            label: t.technicalDetails.viewSource,
            icon: AppIconName.code,
            variant: AppButtonVariant.secondary,
            onPressed: onViewSource,
          ),
          Text(
            t.technicalDetails.license,
            textAlign: TextAlign.center,
            style: styles.secondary().copyWith(color: colors.mutedForeground),
          ),
        ],
      ),
    );
  }
}
