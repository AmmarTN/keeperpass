import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/utils/text/fold.dart';
import 'package:keeperpass/core/utils/validation/limits.dart';
import 'package:keeperpass/core/utils/validation/validators.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_haptics.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/bottom_sheet/app_sheet.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_text_field.dart';

/// "Rename Vault" (board `S5-04`, web `VaultsPage` rename): the name,
/// trimmed; a name another of your vaults has is caught as it is typed.
/// Resolves to the new name.
Future<String?> showRenameVaultSheet(
  BuildContext context, {
  required String current,
  required Set<String> taken,
}) => showAppSheet<String>(
  context,
  builder: (_) => _RenameVaultSheet(current: current, taken: taken),
);

class _RenameVaultSheet extends StatefulWidget {
  const _RenameVaultSheet({required this.current, required this.taken});

  final String current;

  /// Your vaults' names.
  final Set<String> taken;

  @override
  State<_RenameVaultSheet> createState() => _RenameVaultSheetState();
}

class _RenameVaultSheetState extends State<_RenameVaultSheet> {
  late final TextEditingController _name = TextEditingController(
    text: widget.current,
  );

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  String get _trimmed => jsTrim(_name.text);

  bool get _duplicate =>
      _trimmed.isNotEmpty &&
      _trimmed != widget.current &&
      widget.taken.contains(_trimmed);

  bool get _canRename =>
      _trimmed.isNotEmpty && checkSingleLine(_name.text).isEmpty && !_duplicate;

  void _rename() {
    if (!_canRename) return;
    AppHaptics.selection();
    Navigator.of(context).pop(_trimmed);
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return AppSheet(
      title: t.myVaults.renameTitle,
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 14.h,
        children: <Widget>[
          Text(
            t.myVaults.renameBody,
            style: AppTextStyles(
              context,
            ).body().copyWith(color: colors.mutedForeground),
          ),
          AppTextField(
            controller: _name,
            label: t.vaultList.vaultName,
            autofocus: true,
            textInputAction: TextInputAction.done,
            inputFormatters: <TextInputFormatter>[
              LengthLimitingTextInputFormatter(InputLimits.vaultName),
            ],
            errorText: _duplicate
                ? t.myVaults.duplicateRename(name: _trimmed)
                : null,
            onChanged: (_) => setState(() {}),
            onSubmitted: (_) => _rename(),
          ),
          AppButton(
            label: t.common.rename,
            onPressed: _canRename ? _rename : null,
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }
}
