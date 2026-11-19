import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/utils/crypto/totp.dart';
import 'package:keeperpass/core/utils/items/field_display.dart';
import 'package:keeperpass/core/utils/text/country_codes.dart';
import 'package:keeperpass/core/utils/validation/card_number.dart';
import 'package:keeperpass/core/utils/validation/password_strength.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/services/clipboard_service.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_haptics.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_radius.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_surface.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_live_totp.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_totp_ring.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_strength_meter.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/copied_toast.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_field_row.dart';
import 'package:keeperpass/presentation/common/widgets/text/secret_text.dart';
import 'package:keeperpass/presentation/features/item_detail/cubit/item_detail_cubit.dart';
import 'package:keeperpass/presentation/features/vault_list/widgets/vault_rows.dart';

/// A field's name; an unnamed one still needs one (web `common.unnamed`).
String fieldLabel(Field field) =>
    field.name.isEmpty ? t.itemDetail.unnamedField : field.name;

/// The glyph for a field: a picked icon wins, then its type's (web
/// `ItemField`).
int fieldGlyph(Field field) {
  final String? picked = field.iconGlyph;
  final int? codePoint = picked == null
      ? null
      : int.tryParse(picked, radix: 16);
  return codePoint ?? FaGlyphs.byName[field.type.icon] ?? FaGlyphs.note;
}

/// Whether a 2FA field can make a code (web `Totp`: "Invalid code").
bool totpIsValid(String secret) {
  try {
    generateTotp(secret);
    return true;
  } catch (_) {
    return false;
  }
}

/// Copies through the screen's cubit and says what went where (web
/// `ClipboardService`: "{field} copied", "From {item}"). [value] copies one
/// recovery code instead of the field.
Future<void> copyItemField(
  BuildContext context,
  Field field, {
  String? value,
}) async {
  final ItemDetailCubit cubit = context.read<ItemDetailCubit>();
  final AppToastHostState toasts = AppToastHost.of(context);
  final String item = cubit.state.row == null ? '' : rowName(cubit.state.row!);
  final Copied? copied = await cubit.copy(field, value: value);
  if (copied == null) return;
  toasts.show(
    copiedToast(
      title: t.vaultList.fieldCopied(field: fieldLabel(field)),
      from: t.vaultList.copiedFrom(item: item),
      clearsIn: copied.clearsIn,
    ),
  );
}

TextStyle _monoStyle(BuildContext context) => AppTextStyles(context)
    .secret()
    .resized(15, line: 22, tracking: 0.02)
    .copyWith(color: context.colors.foreground);

/// `.fml`: a multi-line value in Space Mono.
TextStyle _multilineStyle(BuildContext context) => AppTextStyles(context)
    .secret()
    .resized(13, line: 20, tracking: 0.01)
    .copyWith(color: context.colors.foreground);

/// One field (`.frow`, boards `S3-19` … `S3-36`): its tile and name, the
/// value as the type wants it, and its actions — reveal, open, call or
/// message, copy.
class ItemFieldRow extends StatelessWidget {
  const ItemFieldRow({
    required this.field,
    required this.revealed,
    this.readOnly = false,
    this.onToggleReveal,
    this.onLargeType,
    this.onEdit,
    this.countryNames = const <String, dynamic>{},
    this.labelTrailing,
    super.key,
  });

  final Field field;

  /// The secret is shown (always, for an earlier version).
  final bool revealed;

  /// An earlier version: shown in full, copy only (board `S3-25`).
  final bool readOnly;
  final VoidCallback? onToggleReveal;
  final VoidCallback? onLargeType;

  /// "Fix it in Edit" under an invalid 2FA key.
  final VoidCallback? onEdit;
  final Map<String, dynamic> countryNames;

  /// "Changed since" on an earlier version.
  final Widget? labelTrailing;

  @override
  Widget build(BuildContext context) {
    final ItemDetailCubit cubit = context.read<ItemDetailCubit>();
    final String locale = LocaleSettings.currentLocale.languageCode;
    final String label = fieldLabel(field);
    final String value = field.value;
    final bool empty = value.isEmpty;
    final bool secret = field.isSecret;
    final bool hidden = secret && !revealed;
    final FieldType type = field.type;
    // An earlier version shows a 2FA field's key as stored, like the web's
    // history view; everywhere else the key never appears.
    final bool totp = type == FieldType.totp && !empty && !readOnly;
    final bool validTotp = totp && totpIsValid(value);
    final bool codes = type == FieldType.recoveryCodes && !empty;

    final Widget tile = AppIconTile(
      AppTileGlyph(fieldGlyph(field)),
      size: AppTileSize.field,
      tone: AppTileTone.soft,
    );

    final Widget shown;
    final List<Widget> below = <Widget>[];
    bool alignTop = false;

    if (empty) {
      shown = const AppFieldText.empty();
    } else if (totp) {
      if (validTotp) {
        shown = AppLiveTotp(
          secret: value,
          now: cubit.now,
          builder: (BuildContext context, String? code, int secondsLeft) =>
              RepaintBoundary(
                child: AppTotpCode(
                  code: splitTotpCode(code ?? ''),
                  secondsLeft: secondsLeft,
                ),
              ),
        );
      } else {
        // The setup key never appears in view mode (board `S3-23`).
        alignTop = true;
        shown = _InvalidCode(onEdit: onEdit);
      }
    } else if (codes && !hidden) {
      alignTop = true;
      shown = _RecoveryCodes(field: field);
    } else if (value.contains('\n')) {
      alignTop = true;
      final String display = fieldDisplayValue(
        field,
        hidden: hidden,
        locale: locale,
      );
      shown = hidden
          ? Semantics(
              label: t.itemDetail.hiddenLines(
                field: label,
                n: value.split('\n').length,
              ),
              excludeSemantics: true,
              child: Text(display, style: _multilineStyle(context)),
            )
          : secret
          ? SecretText(display, style: _multilineStyle(context))
          : AppFieldText(display);
    } else if (hidden) {
      shown = Semantics(
        label: t.itemDetail.hiddenValue(field: label),
        excludeSemantics: true,
        child: Text(
          fieldDisplayValue(field, hidden: true, locale: locale),
          style: _monoStyle(context),
        ),
      );
    } else if (secret) {
      shown = AppFieldSecret(
        fieldDisplayValue(field, hidden: false, locale: locale),
      );
    } else if (fieldIsMonospace(field)) {
      shown = Text(
        fieldDisplayValue(field, hidden: false, locale: locale),
        style: _monoStyle(context),
      );
    } else {
      final Country? country = switch (type) {
        FieldType.phone => countryFromNumber(value),
        FieldType.text => countryNamed(value, locale, countryNames),
        _ => null,
      };
      shown = AppFieldText(
        fieldDisplayValue(field, hidden: false, locale: locale),
        leading: country == null ? null : _Flag(country),
      );
    }

    // An earlier version shows its values and nothing about them (board
    // `S3-25`).
    if (!empty && !readOnly && type == FieldType.password) {
      below.add(
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: AppStrengthMeter.small(
            AppStrength.values[estimatePasswordStrength(value).score],
          ),
        ),
      );
    }
    if (!empty && !readOnly && type == FieldType.credit) {
      final CardNumberInfo card = inspectCardNumber(value);
      if (card.brand != null) below.add(_CardBrand(card.brand!.label));
      if (card.complete && !card.valid) {
        below.add(
          Text(
            t.itemDetail.checksumFail,
            style: AppTextStyles(context)
                .secondary()
                .resized(12, line: 16)
                .copyWith(color: context.colors.destructiveStrong),
          ),
        );
      }
    }
    if (revealed && onLargeType != null && canShowLargeType(field)) {
      alignTop = true;
      below.add(AppLargeTypeButton(onPressed: onLargeType!));
    }

    final List<Widget> actions = <Widget>[
      if (secret && !empty && !readOnly && onToggleReveal != null)
        FieldAction(
          icon: revealed ? AppIconName.eyeOff : AppIconName.eye,
          label: revealed ? t.itemDetail.hideValue : t.itemDetail.revealValue,
          active: revealed,
          onTap: onToggleReveal!,
        ),
      if (type == FieldType.url && !empty && !readOnly)
        FieldAction(
          icon: AppIconName.externalLink,
          label: t.itemDetail.openSite(site: websiteHost(value)),
          onTap: () => cubit.openWebsite(value),
        ),
      if (type == FieldType.phone && !empty && !readOnly) ...<Widget>[
        FieldAction(
          icon: AppIconName.phone,
          label: t.itemDetail.call,
          onTap: () => cubit.call(value),
        ),
        FieldAction(
          icon: AppIconName.messageCircle,
          label: t.itemDetail.message,
          onTap: () => cubit.message(value),
        ),
      ],
    ];

    final bool canCopy = !empty && (!totp || validTotp);
    return AppFieldRow(
      tile: tile,
      label: label,
      value: shown,
      below: below.isEmpty
          ? null
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2.h,
              children: below,
            ),
      actions: actions,
      alignTop: alignTop,
      labelTrailing: labelTrailing,
      copyLabel: switch (type) {
        FieldType.totp when !readOnly => t.vaultList.copyCode,
        FieldType.recoveryCodes => t.itemDetail.copyAllCodes,
        _ => t.itemDetail.copyField(field: label),
      },
      onCopy: !canCopy
          ? null
          : readOnly
          // What is shown is what copies.
          ? () => copyItemField(context, field, value: fieldCopyValue(field))
          : () => copyItemField(context, field),
    );
  }
}

/// An action beside a field's value (`.fact`): 44 pt, its icon at 20.
class FieldAction extends StatelessWidget {
  const FieldAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
    super.key,
  });

  final AppIconName icon;
  final String label;
  final VoidCallback onTap;

  /// Foreground instead of muted (the reveal button while shown).
  final bool active;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return AppPressable(
      onTap: onTap,
      semanticLabel: label,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: SizedBox.square(
        dimension: AppPressable.minTarget(context),
        child: Center(
          child: AppIcon(
            icon,
            size: AppIconSizes.md,
            color: active ? colors.foreground : colors.mutedForeground,
          ),
        ),
      ),
    );
  }
}

/// A flag before a phone number or a country (boards `S3-32`, `S3-35`).
class _Flag extends StatelessWidget {
  const _Flag(this.country);

  final Country country;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: Text(
      country.flag,
      textScaler: TextScaler.noScaling,
      style: TextStyle(fontSize: 16.r, height: 1),
    ),
  );
}

/// "Visa" under a card number, with its glyph (board `S3-29`).
class _CardBrand extends StatelessWidget {
  const _CardBrand(this.brand);

  final String brand;

  @override
  Widget build(BuildContext context) {
    final Color muted = context.colors.mutedForeground;
    return Row(
      spacing: 6.w,
      children: <Widget>[
        FaGlyph(FaGlyphs.credit, size: 12, color: muted),
        Text(
          brand,
          style: AppTextStyles(
            context,
          ).secondary().resized(12, line: 16).copyWith(color: muted),
        ),
      ],
    );
  }
}

/// "Invalid code" with what it means and the way to fix it (board `S3-23`).
class _InvalidCode extends StatelessWidget {
  const _InvalidCode({required this.onEdit});

  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2.h,
      children: <Widget>[
        AppFieldText(t.totp.invalidCode, bold: true),
        Text(
          t.totp.invalidKey,
          style: AppTextStyles(
            context,
          ).secondary().copyWith(color: colors.mutedForeground),
        ),
        if (onEdit != null)
          AppLinkButton(
            label: t.totp.fixInEdit,
            onPressed: onEdit,
            fontSize: 14,
            horizontalPadding: 0,
          ),
      ],
    );
  }
}

/// Revealed recovery codes, one per line, each with its own copy button
/// (board `S3-34`).
class _RecoveryCodes extends StatelessWidget {
  const _RecoveryCodes({required this.field});

  final Field field;

  @override
  Widget build(BuildContext context) {
    final List<String> lines = recoveryCodeLines(field.value);
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Column(
        children: <Widget>[
          for (int i = 0; i < lines.length; i++)
            Row(
              spacing: 8.w,
              children: <Widget>[
                Expanded(
                  child: SecretText(
                    lines[i],
                    style: AppTextStyles(context)
                        .secret()
                        .resized(14, line: 20)
                        .copyWith(color: context.colors.foreground),
                  ),
                ),
                _LineCopyButton(
                  label: t.itemDetail.copyCodeNumber(n: '${i + 1}'),
                  onCopy: () => copyItemField(context, field, value: lines[i]),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

/// A 36 pt copy button that shows its check for 1 s.
class _LineCopyButton extends StatefulWidget {
  const _LineCopyButton({required this.label, required this.onCopy});

  final String label;
  final VoidCallback onCopy;

  @override
  State<_LineCopyButton> createState() => _LineCopyButtonState();
}

class _LineCopyButtonState extends State<_LineCopyButton> {
  bool _copied = false;
  Timer? _reset;

  @override
  void dispose() {
    _reset?.cancel();
    super.dispose();
  }

  void _copy() {
    widget.onCopy();
    _reset?.cancel();
    setState(() => _copied = true);
    _reset = Timer(AppMotion.copiedHold, () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return AppPressable(
      onTap: _copy,
      haptic: AppHaptics.copy,
      semanticLabel: _copied ? t.common.copied : widget.label,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: SizedBox.square(
        dimension: 36.r,
        child: Center(
          child: AppIcon(
            _copied ? AppIconName.check : AppIconName.copy,
            size: AppIconSizes.md,
            color: _copied ? colors.accentStrong : colors.mutedForeground,
          ),
        ),
      ),
    );
  }
}

/// An Authenticator item's code first, as a card (board `S3-36`): the code
/// at 30 pt with its ring; the whole card copies.
class ItemCodeCard extends StatefulWidget {
  const ItemCodeCard({required this.field, this.onEdit, super.key});

  final Field field;
  final VoidCallback? onEdit;

  @override
  State<ItemCodeCard> createState() => _ItemCodeCardState();
}

class _ItemCodeCardState extends State<ItemCodeCard> {
  bool _copied = false;
  Timer? _reset;

  @override
  void dispose() {
    _reset?.cancel();
    super.dispose();
  }

  void _copy() {
    unawaited(copyItemField(context, widget.field));
    _reset?.cancel();
    setState(() => _copied = true);
    _reset = Timer(AppMotion.copiedHold, () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final ItemDetailCubit cubit = context.read<ItemDetailCubit>();
    final bool valid =
        widget.field.value.isNotEmpty && totpIsValid(widget.field.value);
    final TextStyle labelStyle = styles.fieldLabel();

    final Widget label = _copied
        ? Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 4.w,
            children: <Widget>[
              AppIcon(
                AppIconName.check,
                size: 13,
                stroke: 2.5,
                color: colors.accentStrong,
              ),
              Text(
                t.common.copied,
                style: labelStyle.copyWith(color: colors.accentStrong),
              ),
            ],
          )
        : Text(
            fieldLabel(widget.field),
            style: labelStyle.copyWith(color: colors.mutedForeground),
          );

    final Widget body = valid
        ? AppLiveTotp(
            secret: widget.field.value,
            now: cubit.now,
            builder: (BuildContext context, String? code, int secondsLeft) {
              final bool warning = secondsLeft <= kTotpWarningSeconds;
              final Color color = warning
                  ? colors.warningStrong
                  : colors.foreground;
              return RepaintBoundary(
                child: Row(
                  spacing: 12.w,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        splitTotpCode(code ?? ''),
                        style: styles
                            .codeLg()
                            .resized(
                              30,
                              line: 36,
                              weight: FontWeight.w700,
                              tracking: 0.05,
                            )
                            .copyWith(color: color),
                      ),
                    ),
                    AppTotpRing(secondsLeft: secondsLeft, size: 28),
                    if (warning)
                      ExcludeSemantics(
                        child: Text(
                          t.totp.secondsShort(count: secondsLeft),
                          style: styles
                              .badge()
                              .resized(12, line: 16, weight: FontWeight.w800)
                              .copyWith(color: colors.warningStrong),
                        ),
                      ),
                  ],
                ),
              );
            },
          )
        : _InvalidCode(onEdit: widget.onEdit);

    final Widget card = AppSurface(
      radius: AppRadius.xxl,
      ring: true,
      child: Padding(
        padding: EdgeInsets.fromLTRB(18.w, 18.h, 12.w, 18.h),
        child: Row(
          spacing: 16.w,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.h,
                children: <Widget>[
                  Semantics(liveRegion: _copied, child: label),
                  body,
                  if (valid)
                    Text(
                      t.itemDetail.codeCardHint,
                      style: styles.secondary().copyWith(
                        color: colors.mutedForeground,
                      ),
                    ),
                ],
              ),
            ),
            if (valid)
              SizedBox.square(
                dimension: AppPressable.minTarget(context),
                child: Center(
                  child: AppIcon(
                    _copied ? AppIconName.check : AppIconName.copy,
                    size: AppIconSizes.md,
                    color: _copied
                        ? colors.accentStrong
                        : colors.mutedForeground,
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    if (!valid) return card;
    // "The code card copies on tap" (board `U3-Item-types`).
    return AppPressable(
      onTap: _copy,
      haptic: AppHaptics.copy,
      semanticLabel: _copied ? t.common.copied : t.vaultList.copyCode,
      shape: AppRadius.shape(context, AppRadius.xxl),
      child: card,
    );
  }
}
