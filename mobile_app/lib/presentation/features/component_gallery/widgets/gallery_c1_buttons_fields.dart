import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_inset_group.dart';
import 'package:keeperpass/presentation/common/widgets/brand/app_brand.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_icon_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_provider_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_small_button.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_strength_meter.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_date_picker.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_search_field.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_secret_field.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_text_field.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_typed_fields.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_edit_field_row.dart';
import 'package:keeperpass/presentation/common/widgets/text/secret_text.dart';
import 'package:keeperpass/presentation/features/component_gallery/widgets/gallery_section.dart';

/// Board C1 · Buttons and fields.
class GalleryButtonsFields extends StatefulWidget {
  const GalleryButtonsFields({super.key});

  @override
  State<GalleryButtonsFields> createState() => _GalleryButtonsFieldsState();
}

class _GalleryButtonsFieldsState extends State<GalleryButtonsFields> {
  final TextEditingController _empty = TextEditingController();
  final TextEditingController _github = TextEditingController(text: 'GitHub');
  final TextEditingController _email = TextEditingController(
    text: 'jane.doe92@icloud',
  );
  final TextEditingController _readOnly = TextEditingController(
    text: 'janedoe-dev',
  );
  final SecretTextEditingController _secret = SecretTextEditingController(
    text: 'eggplant-twenty-oboe-decree-daringly',
  );
  final SecretTextEditingController _newSecret = SecretTextEditingController(
    text: 'eggplant-twenty-oboe-decree-daringly',
  );
  final SecretTextEditingController _signIn = SecretTextEditingController(
    text: 'eggplant-twenty-oboe-decree-daringly',
  );
  final SecretTextEditingController _password = SecretTextEditingController(
    text: 'Tq7#vR2m!xW9pL4@kZ8s',
  );
  final TextEditingController _search = TextEditingController();
  final TextEditingController _query = TextEditingController(text: 'work git');
  final TextEditingController _phone = TextEditingController(
    text: '503-555-0142',
  );
  final TextEditingController _website = TextEditingController(
    text: 'github.com',
  );
  final TextEditingController _codes = TextEditingController();
  DateTime _birthday = DateTime(1992, 4, 12);
  DateTime _expires = DateTime(2029, 8);
  bool _passwordSecret = true;
  bool _websiteSecret = false;

  @override
  void dispose() {
    for (final TextEditingController c in <TextEditingController>[
      _empty,
      _github,
      _email,
      _readOnly,
      _secret,
      _newSecret,
      _signIn,
      _password,
      _search,
      _query,
      _phone,
      _website,
      _codes,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GallerySection(
      title: 'C1 · Buttons and fields',
      children: <Widget>[
        GallerySpecimen(
          'Primary — default, disabled, busy',
          child: Column(
            spacing: 10.h,
            children: <Widget>[
              AppButton(label: 'Unlock', onPressed: galleryNoop),
              const AppButton(label: 'Unlock', onPressed: null),
              AppButton(
                label: 'Unlocking…',
                onPressed: galleryNoop,
                busy: true,
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Secondary',
          child: Column(
            spacing: 10.h,
            children: <Widget>[
              AppButton(
                label: 'Generate a secret',
                icon: AppIconName.wandSparkles,
                variant: AppButtonVariant.secondary,
                onPressed: galleryNoop,
              ),
              const AppButton(
                label: 'Generate a secret',
                icon: AppIconName.wandSparkles,
                variant: AppButtonVariant.secondary,
                onPressed: null,
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Destructive — tint, solid',
          child: Column(
            spacing: 10.h,
            children: <Widget>[
              AppButton(
                label: 'Start a new vault',
                variant: AppButtonVariant.destructive,
                onPressed: galleryNoop,
              ),
              AppButton(
                label: 'Archive and sign out',
                icon: AppIconName.archive,
                variant: AppButtonVariant.destructive,
                onPressed: galleryNoop,
              ),
              AppButton(
                label: 'Delete item',
                variant: AppButtonVariant.destructiveSolid,
                onPressed: galleryNoop,
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Provider — resting, busy, disabled',
          child: Column(
            spacing: 10.h,
            children: <Widget>[
              AppProviderButton(
                provider: AppProvider.google,
                label: 'Continue with Google',
                onPressed: galleryNoop,
              ),
              AppProviderButton(
                provider: AppProvider.dropbox,
                label: 'Continue with Dropbox',
                onPressed: galleryNoop,
              ),
              AppProviderButton(
                provider: AppProvider.google,
                label: 'Connecting to Google…',
                onPressed: galleryNoop,
                busy: true,
              ),
              const AppProviderButton(
                provider: AppProvider.dropbox,
                label: 'Continue with Dropbox',
                onPressed: null,
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Ghost and link',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppButton(
                label: 'Use another account',
                variant: AppButtonVariant.ghost,
                size: AppButtonSize.medium,
                onPressed: galleryNoop,
              ),
              AppLinkButton(
                label: 'Generate a secret',
                icon: AppIconName.wandSparkles,
                fontSize: 14,
                onPressed: galleryNoop,
              ),
              AppLinkButton.bar(
                label: 'Cancel',
                onPressed: galleryNoop,
                horizontalPadding: 0,
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Small — banner actions, Generate, Fill, Copied',
          child: GalleryWrap(
            children: <Widget>[
              AppSmallButton(
                label: 'Retry',
                icon: AppIconName.rotateCw,
                variant: AppSmallButtonVariant.outlined,
                onPressed: galleryNoop,
              ),
              AppSmallButton(label: 'Dismiss', onPressed: galleryNoop),
              AppPillButton.generate(label: 'Generate', onPressed: galleryNoop),
              AppPillButton(label: 'Fill', solid: true, onPressed: galleryNoop),
              AppPillButton(
                label: 'Copied',
                icon: AppIconName.check,
                onPressed: galleryNoop,
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Icon buttons — header, field, copy (tap it), close',
          child: GalleryWrap(
            children: <Widget>[
              AppIconButton(
                icon: AppIconName.lockKeyhole,
                semanticLabel: 'Lock',
                onPressed: galleryNoop,
              ),
              AppIconButton(
                icon: AppIconName.eye,
                semanticLabel: 'Reveal',
                variant: AppIconButtonVariant.field,
                onPressed: galleryNoop,
              ),
              AppCopyButton(semanticLabel: 'Copy', onCopy: galleryNoop),
              AppCloseButton(onPressed: galleryNoop),
              AppCopyButton(
                semanticLabel: 'Copy',
                onCopy: galleryNoop,
                variant: AppCopyButtonVariant.card,
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Text — placeholder, value, error, read-only',
          child: Column(
            spacing: 12.h,
            children: <Widget>[
              AppTextField(controller: _empty, placeholder: 'e.g. GitHub'),
              AppTextField(controller: _github),
              AppTextField(
                controller: _email,
                errorText: 'That does not look like an email address.',
              ),
              AppTextField(controller: _readOnly, readOnly: true, dimmed: true),
            ],
          ),
        ),
        GallerySpecimen(
          'Secret — masked; revealed with Generate and the meter',
          child: Column(
            spacing: 14.h,
            children: <Widget>[
              AppSecretField(
                controller: _secret,
                label: 'Secret',
                placeholder: 'Your secret',
              ),
              AppSecretField(
                controller: _newSecret,
                label: 'New secret',
                labelTrailing: AppLinkButton(
                  label: 'Generate',
                  icon: AppIconName.wandSparkles,
                  fontSize: 14,
                  onPressed: galleryNoop,
                ),
                initiallyRevealed: true,
                strength: AppStrength.veryStrong,
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Search, and the large secret field',
          child: Column(
            spacing: 12.h,
            children: <Widget>[
              AppSearchField(
                controller: _search,
                placeholder: 'Search 23 items',
              ),
              AppSearchField(
                controller: _query,
                placeholder: 'Search 23 items',
              ),
              AppSecretField(
                controller: _signIn,
                label: 'Secret',
                placeholder: 'Enter your secret',
                large: true,
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Typed editors — phone, date, month, multi-line (tap the dates)',
          child: Column(
            spacing: 12.h,
            children: <Widget>[
              AppPhoneField(
                controller: _phone,
                dialCode: '+1',
                countryName: 'United States',
                flag: ColoredBox(color: context.colors.secondary),
                onPickCountry: galleryNoop,
                semanticLabel: 'Phone number',
              ),
              AppDateField(
                semanticLabel: 'Birthday',
                valueText: MaterialLocalizations.of(
                  context,
                ).formatMediumDate(_birthday),
                onPick: () async {
                  final DateTime picked = await showAppDatePicker(
                    context,
                    title: 'Birthday',
                    initial: _birthday,
                  );
                  setState(() => _birthday = picked);
                },
              ),
              AppDateField(
                semanticLabel: 'Expires On',
                valueText:
                    '${_expires.month.toString().padLeft(2, '0')}/${_expires.year}',
                mode: AppDatePickerMode.month,
                onPick: () async {
                  final DateTime picked = await showAppDatePicker(
                    context,
                    title: 'Expires On',
                    initial: _expires,
                    mode: AppDatePickerMode.month,
                  );
                  setState(() => _expires = picked);
                },
              ),
              AppMultilineField(
                controller: _codes,
                semanticLabel: 'Recovery Codes',
                placeholder: 'One per line — any format works',
                mono: true,
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Edit row — tile, name, Secret, Remove, grip',
          child: AppInsetGroup(
            children: <Widget>[
              AppEditFieldRow(
                name: 'Password',
                glyph: FaGlyphs.lock,
                secret: _passwordSecret,
                onSecretChanged: (bool v) =>
                    setState(() => _passwordSecret = v),
                onRemove: galleryNoop,
                onChangeIcon: galleryNoop,
                editor: AppSecretField(
                  controller: _password,
                  surface: AppFieldSurface.card,
                  strength: AppStrength.veryStrong,
                  smallMeter: true,
                  extraActions: <Widget>[
                    AppIconButton(
                      icon: AppIconName.wandSparkles,
                      semanticLabel: 'Generate a password',
                      variant: AppIconButtonVariant.field,
                      color: context.colors.accentStrong,
                      onPressed: galleryNoop,
                    ),
                  ],
                ),
              ),
              AppEditFieldRow(
                name: 'Website',
                glyph: FaGlyphs.web,
                secret: _websiteSecret,
                onSecretChanged: (bool v) => setState(() => _websiteSecret = v),
                onRemove: galleryNoop,
                onChangeIcon: galleryNoop,
                editor: AppTextField(
                  controller: _website,
                  surface: AppFieldSurface.card,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
