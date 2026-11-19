import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/utils/validation/limits.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_radius.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_inset_group.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_surface.dart';
import 'package:keeperpass/presentation/common/widgets/bottom_sheet/app_sheet.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_text_field.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_bars.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_settings_row.dart';
import 'package:keeperpass/presentation/features/item_detail/widgets/item_fields.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_view.dart';
import 'package:keeperpass/presentation/features/vault_list/widgets/vault_rows.dart';

/// What "Save code" hands back when the screen offers the Item choice: the
/// key, and the item it goes into (null: a new Authenticator item).
typedef TypedSetupKey = ({String key, String? itemId});

/// Types a 2FA setup key for the field being edited (board `Scan-QR` "Enter
/// setup key", built early for 2FA fields — your answer, Part 9). The key
/// as typed, or null.
Future<String?> openSetupKey(
  BuildContext context, {
  String initial = '',
}) async => (await _push(context, SetupKeyPage(initial: initial)))?.key;

/// "Enter setup key" from the scanner opened in Codes (board `S6-30`): with
/// the Item choice — "New Authenticator item", then [items] (your answer,
/// Part 15).
Future<TypedSetupKey?> openSetupKeyFor(
  BuildContext context, {
  required List<VaultRow> items,
}) => _push(context, SetupKeyPage(items: items));

Future<TypedSetupKey?> _push(BuildContext context, SetupKeyPage page) =>
    Navigator.of(context, rootNavigator: true).push<TypedSetupKey>(
      MaterialPageRoute<TypedSetupKey>(
        fullscreenDialog: true,
        builder: (_) => page,
      ),
    );

class SetupKeyPage extends StatefulWidget {
  const SetupKeyPage({this.initial = '', this.items, super.key});

  final String initial;

  /// The Item choice's items, A to Z; null when the key is for a field
  /// being edited (no choice).
  final List<VaultRow>? items;

  @override
  State<SetupKeyPage> createState() => _SetupKeyPageState();
}

class _SetupKeyPageState extends State<SetupKeyPage>
    with ToastsOverTabBar<SetupKeyPage> {
  late final TextEditingController _key = TextEditingController(
    text: widget.initial,
  );

  /// The item chosen; null: a new Authenticator item (chosen first).
  String? _itemId;

  @override
  void dispose() {
    _key.dispose();
    super.dispose();
  }

  /// A key that makes a code ("Spaces and capitals don't matter.").
  bool get _valid => _key.text.trim().isNotEmpty && totpIsValid(_key.text);

  void _save() {
    if (_valid) {
      Navigator.of(context).pop((key: _key.text.trim(), itemId: _itemId));
    }
  }

  Future<void> _chooseItem(List<VaultRow> items) async {
    final ({String? itemId})? choice = await showAppSheet<({String? itemId})>(
      context,
      builder: (_) => _ItemChoice(items: items, selected: _itemId),
    );
    if (choice != null && mounted) setState(() => _itemId = choice.itemId);
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final List<VaultRow>? items = widget.items;
    final VaultRow? chosen = items
        ?.where((VaultRow r) => r.id == _itemId)
        .firstOrNull;
    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AppCompactBar(
              title: t.editItem.setupKeyTitle,
              leading: AppLinkButton.bar(
                label: t.common.cancel,
                onPressed: () => Navigator.of(context).maybePop(),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 24.h),
                children: <Widget>[
                  Text(
                    t.editItem.setupKeyBody,
                    style: styles
                        .body()
                        .resized(15, line: 22)
                        .copyWith(color: colors.mutedForeground),
                  ),
                  SizedBox(height: 16.h),
                  AppTextField(
                    controller: _key,
                    label: t.editItem.setupKey,
                    mono: true,
                    autofocus: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    textCapitalization: TextCapitalization.characters,
                    textInputAction: TextInputAction.done,
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(InputLimits.fieldValue),
                    ],
                    onChanged: (_) => setState(() {}),
                    onSubmitted: (_) => _save(),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    t.editItem.setupKeyHint,
                    style: styles.secondary().copyWith(
                      color: colors.mutedForeground,
                    ),
                  ),
                  if (items != null) ...<Widget>[
                    SizedBox(height: 14.h),
                    AppFieldLabel(t.scan.item),
                    SizedBox(height: 8.h),
                    _ItemField(
                      value: chosen == null
                          ? t.scan.newAuthenticator
                          : rowName(chosen),
                      onTap: () => _chooseItem(items),
                    ),
                  ],
                  // Folded on the board ("almost every site uses 6 digits,
                  // 30 seconds and SHA-1"); the only settings KeeperPass
                  // makes, so plain information (your answer, Part 15).
                  Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: 44.h),
                      child: Row(
                        spacing: 6.w,
                        children: <Widget>[
                          AppIcon(
                            AppIconName.settings2,
                            size: 16,
                            stroke: 2,
                            color: colors.mutedForeground,
                          ),
                          Expanded(
                            child: Text(
                              t.scan.codeSettings,
                              style: styles
                                  .button()
                                  .resized(14, line: 20)
                                  .copyWith(color: colors.mutedForeground),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  AppButton(
                    label: t.editItem.saveCode,
                    onPressed: _valid ? _save : null,
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

/// The Item value (`.mval` at full width): the choice and a chevron.
class _ItemField extends StatelessWidget {
  const _ItemField({required this.value, required this.onTap});

  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final ShapeBorder shape = AppRadius.shape(
      context,
      12,
      side: BorderSide(color: colors.hairline),
    );
    return AppPressable(
      onTap: onTap,
      semanticLabel: '${t.scan.item}, $value',
      shape: shape,
      child: Container(
        height: 48.h,
        padding: EdgeInsets.fromLTRB(14.w, 0, 12.w, 0),
        decoration: ShapeDecoration(color: colors.background, shape: shape),
        child: Row(
          spacing: 6.w,
          children: <Widget>[
            Expanded(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles(context)
                    .bodyStrong()
                    .resized(15, line: 20)
                    .copyWith(color: colors.foreground),
              ),
            ),
            AppIcon(
              AppIconName.chevronDown,
              size: 16,
              stroke: 2.25,
              color: colors.mutedForeground,
            ),
          ],
        ),
      ),
    );
  }
}

/// The Item choice: "New Authenticator item", then every item A to Z.
/// Pops the choice (its id null for a new item).
class _ItemChoice extends StatelessWidget {
  const _ItemChoice({required this.items, required this.selected});

  final List<VaultRow> items;
  final String? selected;

  /// Up to this many rows are drawn at once; more scroll in a fixed height.
  static const int _shownAtOnce = 7;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    Widget row(BuildContext context, int index) {
      if (index == 0) {
        return AppSettingsRow.radio(
          title: t.scan.newAuthenticator,
          leading: const AppIconTile(
            AppTileGlyph(FaGlyphs.totp),
            size: AppTileSize.settings,
          ),
          selected: selected == null,
          onTap: () => Navigator.of(context).pop((itemId: null)),
        );
      }
      final VaultRow item = items[index - 1];
      return AppSettingsRow.radio(
        title: rowName(item),
        subtitle: item.summary,
        leading: VaultItemTile(item, size: AppTileSize.settings),
        selected: selected == item.id,
        onTap: () => Navigator.of(context).pop((itemId: item.id)),
      );
    }

    final int count = items.length + 1;
    return AppSheet(
      title: t.scan.item,
      child: count <= _shownAtOnce
          ? AppInsetGroup(
              dividerInset: AppDividerInset.settings,
              children: <Widget>[
                for (int i = 0; i < count; i++) row(context, i),
              ],
            )
          : SizedBox(
              height: 420.h,
              child: AppSurface(
                clip: true,
                color: colors.card,
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: count,
                  separatorBuilder: (_, _) => Padding(
                    padding: EdgeInsets.only(left: AppDividerInset.settings.w),
                    child: SizedBox(
                      height: 1,
                      child: ColoredBox(color: colors.border),
                    ),
                  ),
                  itemBuilder: row,
                ),
              ),
            ),
    );
  }
}
