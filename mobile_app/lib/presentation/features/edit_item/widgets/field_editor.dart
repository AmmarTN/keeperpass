import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/enums/audit_type.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/utils/items/field_editing.dart';
import 'package:keeperpass/core/utils/text/country_codes.dart';
import 'package:keeperpass/core/utils/text/date_formats.dart';
import 'package:keeperpass/core/utils/text/field_dates.dart';
import 'package:keeperpass/core/utils/validation/card_number.dart';
import 'package:keeperpass/core/utils/validation/limits.dart';
import 'package:keeperpass/core/utils/validation/password_strength.dart';
import 'package:keeperpass/core/utils/validation/validators.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_shadows.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_icon_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_small_button.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_live_totp.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_totp_ring.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_strength_meter.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_date_picker.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_secret_field.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_text_field.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_typed_fields.dart';
import 'package:keeperpass/presentation/common/widgets/overlays/app_dialog.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_edit_field_row.dart';
import 'package:keeperpass/presentation/common/widgets/text/secret_text.dart';
import 'package:keeperpass/presentation/features/edit_item/cubit/edit_item_cubit.dart';
import 'package:keeperpass/presentation/features/edit_item/pages/setup_key_page.dart';
import 'package:keeperpass/presentation/features/edit_item/widgets/edit_sheets.dart';
import 'package:keeperpass/presentation/features/generator/widgets/generate_sheet.dart';
import 'package:keeperpass/presentation/features/item_detail/widgets/item_fields.dart';
import 'package:keeperpass/presentation/features/scan_qr/pages/scan_page.dart';

/// Placeholders the web keeps as literals (formats, not language).
const String _urlPlaceholder = 'https://';
const String _emailPlaceholder = 'name@example.com';
const Map<FieldType, String> _pemPlaceholders = <FieldType, String>{
  FieldType.certificate: '-----BEGIN CERTIFICATE-----',
  FieldType.sshKey: '-----BEGIN OPENSSH PRIVATE KEY-----',
};

/// A value's placeholder: the boards' for usernames and passwords, the
/// web's for the rest.
String valuePlaceholder(FieldType type) => switch (type) {
  FieldType.username => t.editItem.usernamePlaceholder,
  FieldType.password => t.editItem.passwordPlaceholder,
  FieldType.url => _urlPlaceholder,
  FieldType.email => _emailPlaceholder,
  FieldType.ipHost => t.editItem.ipHostPlaceholder,
  FieldType.recoveryCodes => t.editItem.recoveryCodesPlaceholder,
  FieldType.phone => t.editItem.phoneNumber,
  _ => _pemPlaceholders[type] ?? t.editItem.valuePlaceholder,
};

/// One field in Edit (`.erow`, boards `S3-41` … `S3-49`; web
/// `FieldValueEditor`): its tile (tap for its icon), its name edited in
/// place, the Secret chip, Remove, and the editor its type wants. Problems
/// show once the field is left (board `U3-Edit-fields`).
class FieldEditor extends StatefulWidget {
  const FieldEditor({
    required this.field,
    required this.itemName,
    this.autofocus = false,
    this.highlighted = false,
    this.autoGenerate = false,
    this.findings = const <AuditType>[],
    super.key,
  });

  final EditableField field;

  /// For "… leave GitHub when you save".
  final String itemName;

  /// A field just added: its value is focused (board `S3-40`).
  final bool autofocus;

  /// The 2FA field "Fix it in Edit" came for: drawn focused until the
  /// screen is touched (your answer, Part 10).
  final bool highlighted;

  /// "Change password" on a finding: the Generate sheet is up as the
  /// screen opens (board `Fix-finding`).
  final bool autoGenerate;

  /// The findings the stored field has; a generated password that clears
  /// them says so (board `S4-21`).
  final List<AuditType> findings;

  @override
  State<FieldEditor> createState() => _FieldEditorState();
}

class _FieldEditorState extends State<FieldEditor> {
  late final TextEditingController _name = TextEditingController(
    text: widget.field.name,
  );
  late final SecretTextEditingController _value = SecretTextEditingController(
    text: _editableText(widget.field),
    masked: _masks(widget.field, revealed: false),
    tinted: widget.field.secret,
  );
  final FocusNode _valueFocus = FocusNode();
  bool _left = false;
  bool _revealed = false;

  /// Bumped to rebuild the secret field revealed (after Generate).
  int _revealKey = 0;

  /// The value is the one "Use this password" put there (until typed in).
  bool _generated = false;

  EditableField get _field => widget.field;
  EditItemCubit get _cubit => context.read<EditItemCubit>();

  /// Only a multi-line secret is masked by the controller; a one-line one
  /// is obscured by its secret field.
  static bool _masks(EditableField field, {required bool revealed}) =>
      field.secret && !revealed && kLongTextTypes.contains(field.type);

  /// The phone's number without its dial code.
  static String _editableText(EditableField field) {
    if (field.type != FieldType.phone) return field.value;
    final Country? country = countryFromNumber(field.value);
    if (country == null || !field.value.startsWith(country.dial)) {
      return field.value;
    }
    return field.value.substring(country.dial.length).trim();
  }

  @override
  void initState() {
    super.initState();
    _valueFocus.addListener(() {
      if (!_valueFocus.hasFocus && mounted) setState(() => _left = true);
    });
    if (widget.autofocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _valueFocus.requestFocus();
      });
    }
    if (widget.autoGenerate && _field.type == FieldType.password) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) unawaited(_generate());
      });
    }
  }

  @override
  void didUpdateWidget(covariant FieldEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    // A value set from elsewhere (Generate, a setup key, a country).
    final String text = _editableText(_field);
    if (text != _value.text && _field.value != oldWidget.field.value) {
      _value.text = text;
    }
    _value
      ..tinted = _field.secret
      ..masked = _masks(_field, revealed: _revealed);
  }

  @override
  void dispose() {
    _name.dispose();
    _value.dispose();
    _valueFocus.dispose();
    super.dispose();
  }

  void _setValue(String value) => _cubit.setFieldValue(_field.key, value);

  void _toggleReveal() {
    setState(() => _revealed = !_revealed);
    _value.masked = _masks(_field, revealed: _revealed);
  }

  Future<void> _generate() async {
    final String? password = await showGenerateSheet(context);
    if (password == null || !mounted) return;
    _value.text = password;
    _setValue(password);
    // What landed is shown (web `onGenerated`).
    setState(() {
      _revealed = true;
      _revealKey++;
      _generated = true;
    });
  }

  /// Typing over a generated password: the line about it goes.
  void _typed(String value) {
    if (_generated) setState(() => _generated = false);
    _setValue(value);
  }

  /// "No longer weak or reused" (board `S4-21`; your answer, Part 11: only
  /// what the phone can tell before Save).
  Widget? _clearedLine(BuildContext context) {
    if (!_generated || widget.findings.isEmpty) return null;
    final ({bool weak, bool reused}) cleared = _cubit.clears(
      _field.key,
      _field.value,
      widget.findings,
    );
    final String? text = switch ((cleared.weak, cleared.reused)) {
      (true, true) => t.report.noLongerWeakOrReused,
      (true, false) => t.report.noLongerWeak,
      (false, true) => t.report.noLongerReused,
      (false, false) => null,
    };
    if (text == null) return null;
    final Color accent = context.colors.accentStrong;
    return Semantics(
      liveRegion: true,
      child: Row(
        spacing: 6.w,
        children: <Widget>[
          AppIcon(
            AppIconName.circleCheck,
            size: 15,
            stroke: 2.25,
            color: accent,
          ),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles(context)
                  .secondary()
                  .resized(13, line: 18, weight: FontWeight.w700)
                  .copyWith(color: accent),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _remove() async {
    final bool confirmed = await showAppDialog(
      context,
      icon: AppIconName.trash,
      tone: AppDialogTone.tint,
      smallTitle: true,
      title: t.editItem.removeFieldTitle,
      message: t.editItem.removeFieldBody(
        field: fieldLabel(_field.toField()),
        item: widget.itemName,
      ),
      confirmLabel: t.editItem.remove,
    );
    if (confirmed && mounted) _cubit.removeField(_field.key);
  }

  Future<void> _changeIcon() async {
    final IconChoice? choice = await showIconPicker(
      context,
      catalog: _cubit.iconCatalog(),
      current: _field.iconGlyph,
      defaultTile: AppIconTile(
        AppTileGlyph(typeGlyph(_field.type)),
        size: AppTileSize.small,
      ),
    );
    if (choice != null && mounted) {
      _cubit.setFieldIcon(_field.key, choice.glyph);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return AppEditFieldRow(
      name: fieldLabel(_field.toField()),
      glyph: fieldGlyph(_field.toField()),
      secret: _field.secret,
      onSecretChanged: (bool secret) =>
          _cubit.setFieldSecret(_field.key, secret),
      onRemove: _remove,
      onChangeIcon: _changeIcon,
      reorderable: false,
      nameField: Semantics(
        textField: true,
        label: t.editItem.fieldNamePlaceholder,
        child: TextField(
          controller: _name,
          onChanged: (String name) => _cubit.setFieldName(_field.key, name),
          maxLines: 1,
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(InputLimits.fieldName),
          ],
          style: AppTextStyles(context)
              .formLabel()
              .resized(14, line: 20, weight: FontWeight.w700)
              .copyWith(color: colors.accentStrong),
          cursorColor: colors.accentStrong,
          decoration: InputDecoration.collapsed(
            hintText: t.editItem.fieldNamePlaceholder,
            hintStyle: AppTextStyles(context)
                .formLabel()
                .resized(14, line: 20, weight: FontWeight.w700)
                .copyWith(color: colors.mutedForeground),
          ),
        ),
      ),
      editor: _editor(context),
    );
  }

  Widget _editor(BuildContext context) {
    final FieldType type = _field.type;
    final String label = fieldLabel(_field.toField());
    final List<TextInputFormatter> limit = <TextInputFormatter>[
      LengthLimitingTextInputFormatter(fieldValueLimit(type)),
    ];

    if (type == FieldType.totp) {
      return _TotpEditor(field: _field, highlighted: widget.highlighted);
    }

    if (type == FieldType.date || type == FieldType.month) {
      final bool month = type == FieldType.month;
      final String locale = LocaleSettings.currentLocale.languageCode;
      final DateTime? date = parseFieldDate(_field.value);
      final ({int year, int month})? monthValue = parseFieldMonth(_field.value);
      final String shown = month
          ? (monthValue == null
                ? _field.value
                : formatFieldMonth(monthValue.year, monthValue.month, locale))
          : (date == null ? _field.value : formatMediumDate(date, locale));
      return AppDateField(
        semanticLabel: label,
        valueText: shown,
        placeholder: month ? t.common.chooseMonth : t.common.chooseDate,
        mode: month ? AppDatePickerMode.month : AppDatePickerMode.date,
        onPick: () async {
          final DateTime now = DateTime.now();
          final DateTime picked = await showAppDatePicker(
            context,
            title: label,
            mode: month ? AppDatePickerMode.month : AppDatePickerMode.date,
            initial:
                date ??
                (monthValue == null
                    ? DateTime(now.year, now.month, now.day)
                    : DateTime(monthValue.year, monthValue.month)),
          );
          _setValue(
            month
                ? fieldMonthValue(picked.year, picked.month)
                : fieldDateValue(picked),
          );
        },
      );
    }

    if (type == FieldType.phone) {
      final Country? country = countryFromNumber(_field.value);
      return AppPhoneField(
        controller: _value,
        focusNode: _valueFocus,
        dialCode: country?.dial ?? '+',
        countryName: country?.name ?? t.common.countryCode,
        flag: country == null
            ? FaGlyph(
                FaGlyphs.byName['web'] ?? FaGlyphs.note,
                size: 16,
                color: context.colors.mutedForeground,
              )
            : Text(country.flag, style: TextStyle(fontSize: 18.r, height: 1)),
        semanticLabel: t.editItem.phoneNumber,
        placeholder: t.editItem.phoneNumber,
        onPickCountry: () async {
          final Country? picked = await showCountryPicker(
            context,
            names: _cubit.countryNames(),
          );
          if (picked == null) return;
          // Only the dial code at the front changes (web `onCountryPicked`).
          final String national = _value.text.trim();
          _setValue(
            national.isEmpty ? picked.dial : '${picked.dial} $national',
          );
        },
        onChanged: (String national) {
          final String? dial = country?.dial;
          _setValue(dial == null ? national : '$dial $national'.trim());
        },
      );
    }

    final bool secret = _field.secret;
    final bool empty = _field.value.isEmpty;

    if (kLongTextTypes.contains(type)) {
      return AppMultilineField(
        controller: _value,
        focusNode: _valueFocus,
        autofocus: widget.autofocus,
        semanticLabel: label,
        placeholder: valuePlaceholder(type),
        mono: secret,
        secret: secret,
        inputFormatters: limit,
        onChanged: _setValue,
        actions: <Widget>[
          if (secret)
            AppIconButton(
              icon: _revealed ? AppIconName.eyeOff : AppIconName.eye,
              semanticLabel: _revealed
                  ? t.itemDetail.hideValue
                  : t.itemDetail.revealValue,
              variant: AppIconButtonVariant.field,
              onPressed: _toggleReveal,
            ),
        ],
      );
    }

    final String? error = _left ? _problem(type, _field.value) : null;
    final TextInputType? keyboard = switch (type) {
      FieldType.email => TextInputType.emailAddress,
      FieldType.url => TextInputType.url,
      FieldType.pin || FieldType.credit => TextInputType.number,
      _ => null,
    };

    if (secret) {
      final bool password = type == FieldType.password;
      final Widget? cleared = password ? _clearedLine(context) : null;
      final Widget field = AppSecretField(
        key: ValueKey<int>(_revealKey),
        controller: _value,
        focusNode: _valueFocus,
        autofocus: widget.autofocus,
        surface: AppFieldSurface.card,
        placeholder: valuePlaceholder(type),
        keyboardType: keyboard,
        errorText: error,
        initiallyRevealed: _revealed,
        smallMeter: true,
        strength: password && !empty
            ? AppStrength.values[estimatePasswordStrength(_field.value).score]
            : null,
        onChanged: _typed,
        extraActions: <Widget>[
          if (password)
            empty
                ? _GeneratePill(onTap: _generate)
                : AppIconButton(
                    icon: AppIconName.wandSparkles,
                    semanticLabel: t.editItem.generatePassword,
                    variant: AppIconButtonVariant.field,
                    color: context.colors.accentStrong,
                    onPressed: _generate,
                  ),
        ],
      );
      if (cleared == null) return field;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8.h,
        children: <Widget>[field, cleared],
      );
    }

    return AppTextField(
      controller: _value,
      focusNode: _valueFocus,
      autofocus: widget.autofocus,
      semanticLabel: label,
      placeholder: valuePlaceholder(type),
      surface: AppFieldSurface.card,
      mono: type == FieldType.credit,
      keyboardType: keyboard,
      autocorrect: type != FieldType.email && type != FieldType.url,
      errorText: error,
      inputFormatters: limit,
      onChanged: _setValue,
    );
  }

  /// What is wrong, in the web's words, once the field is left: an email
  /// that does not look like one, a card number that fails its checksum.
  static String? _problem(FieldType type, String value) {
    if (value.isEmpty) return null;
    if (type == FieldType.email && checkEmail(value) != null) {
      return t.editItem.notEmail;
    }
    if (type == FieldType.credit) {
      final CardNumberInfo card = inspectCardNumber(value);
      if (card.complete && !card.valid) return t.itemDetail.checksumFail;
    }
    return null;
  }
}

/// "Generate" in an empty password (`.gen`, board `S3-38`).
class _GeneratePill extends StatelessWidget {
  const _GeneratePill({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return Padding(
      padding: EdgeInsets.only(right: 5.w),
      child: AppPressable(
        onTap: onTap,
        semanticLabel: t.editItem.generatePassword,
        shape: const StadiumBorder(),
        child: Container(
          height: 34.h,
          padding: EdgeInsets.only(left: 10.w, right: 12.w),
          decoration: ShapeDecoration(
            color: colors.primary15,
            shape: const StadiumBorder(),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 6.w,
            children: <Widget>[
              AppIcon(
                AppIconName.wandSparkles,
                size: 15,
                stroke: 2,
                color: colors.accentStrong,
              ),
              Text(
                t.editItem.generate,
                style: AppTextStyles(context)
                    .badge()
                    .resized(13, line: 18, weight: FontWeight.w700)
                    .copyWith(color: colors.accentStrong),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A 2FA field in Edit (board `S3-41`): the code it makes now, never the
/// key, then Scan QR code and Enter setup key.
class _TotpEditor extends StatelessWidget {
  const _TotpEditor({required this.field, this.highlighted = false});

  final EditableField field;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final EditItemCubit cubit = context.read<EditItemCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8.h,
      children: <Widget>[
        if (field.value.isNotEmpty)
          Semantics(
            container: true,
            label: t.editItem.currentCode,
            child: Container(
              height: 48.h,
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              // Focused as a field is (`.fld:focus`): the card with the
              // accent ring.
              decoration: BoxDecoration(
                color: highlighted ? colors.card : colors.secondary,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: highlighted ? context.shadows.focus : null,
              ),
              child: AppLiveTotp(
                secret: field.value,
                builder:
                    (BuildContext context, String? code, int secondsLeft) =>
                        RepaintBoundary(
                          child: Row(
                            spacing: 10.w,
                            children: code == null
                                ? <Widget>[
                                    Text(
                                      t.totp.invalidCode,
                                      style: styles.body().copyWith(
                                        color: colors.mutedForeground,
                                      ),
                                    ),
                                  ]
                                : <Widget>[
                                    Text(
                                      splitTotpCode(code),
                                      style: styles
                                          .code()
                                          .resized(
                                            18,
                                            line: 22,
                                            weight: FontWeight.w700,
                                            tracking: 0.04,
                                          )
                                          .copyWith(color: colors.foreground),
                                    ),
                                    AppTotpRing(
                                      secondsLeft: secondsLeft,
                                      size: 18,
                                    ),
                                  ],
                          ),
                        ),
              ),
            ),
          ),
        Row(
          spacing: 8.w,
          children: <Widget>[
            Expanded(
              child: AppSmallButton(
                label: t.editItem.scanQr,
                icon: AppIconName.scanQrCode,
                variant: AppSmallButtonVariant.outlined,
                onPressed: () async {
                  final String? key = await scanCodeForField(context);
                  if (key != null) cubit.setFieldValue(field.key, key);
                },
              ),
            ),
            Expanded(
              child: AppSmallButton(
                label: t.editItem.enterSetupKey,
                icon: AppIconName.keyboard,
                variant: AppSmallButtonVariant.outlined,
                onPressed: () async {
                  final String? key = await openSetupKey(context);
                  if (key != null) cubit.setFieldValue(field.key, key);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
