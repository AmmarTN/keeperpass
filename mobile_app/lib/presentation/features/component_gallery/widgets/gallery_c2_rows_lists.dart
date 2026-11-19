import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_inset_group.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_section_label.dart';
import 'package:keeperpass/presentation/common/widgets/brand/app_brand.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_icon_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/cards/app_code_card.dart';
import 'package:keeperpass/presentation/common/widgets/cards/app_report_cards.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_totp_ring.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_strength_meter.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_typed_fields.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_favorites_strip.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_field_row.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_item_row.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_settings_row.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_swipe_actions.dart';
import 'package:keeperpass/presentation/features/component_gallery/widgets/gallery_section.dart';

Widget _letter(String letter) =>
    AppIconTile(AppTileLetter(letter), tone: AppTileTone.white);
Widget _field(int glyph) => AppIconTile(
  AppTileGlyph(glyph),
  size: AppTileSize.field,
  tone: AppTileTone.soft,
);
Widget _settings(AppIconName icon, {AppTileTone tone = AppTileTone.accent}) =>
    AppIconTile(AppTileIcon(icon), size: AppTileSize.settings, tone: tone);

/// Board C2 · Rows, lists and cards.
class GalleryRowsLists extends StatefulWidget {
  const GalleryRowsLists({super.key});

  @override
  State<GalleryRowsLists> createState() => _GalleryRowsListsState();
}

class _GalleryRowsListsState extends State<GalleryRowsLists> {
  bool _faceId = true;
  bool _hideInSwitcher = false;
  int _autoLock = 10;
  String _vault = 'My Vault';
  bool _revealed = false;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return GallerySection(
      title: 'C2 · Rows, lists and cards',
      children: <Widget>[
        GallerySpecimen(
          'Item rows — star, finding marker, tag, copy',
          child: AppInsetGroup(
            dividerInset: AppDividerInset.item,
            children: <Widget>[
              AppItemRow(
                tile: _letter('G'),
                name: 'GitHub',
                subtitle: 'janedoe-dev · Work',
                favorite: true,
                firstTag: 'work',
                moreTags: 1,
                copyLabel: 'Copy password for GitHub',
                onCopy: galleryNoop,
                onTap: galleryNoop,
              ),
              AppItemRow(
                tile: _letter('N'),
                name: 'Netflix',
                subtitle: 'jane.doe92@example.com · My Vault',
                findingLabel: 'Weak and reused password',
                firstTag: 'entertainment',
                copyLabel: 'Copy password for Netflix',
                onCopy: galleryNoop,
                onTap: galleryNoop,
              ),
              AppItemRow(
                tile: const AppIconTile(AppTileGlyph(FaGlyphs.wifi)),
                name: 'Home Wi-Fi',
                subtitle: 'Doe-Home-5G · My Vault',
                favorite: true,
                copyLabel: 'Copy password for Home Wi-Fi',
                onCopy: galleryNoop,
                onTap: galleryNoop,
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Selection — selected and not selected',
          child: AppInsetGroup(
            dividerInset: AppDividerInset.item,
            children: <Widget>[
              AppItemRow(
                tile: _letter('G'),
                name: 'GitHub',
                subtitle: 'janedoe-dev · Work',
                favorite: true,
                firstTag: 'work',
                moreTags: 1,
                selected: true,
                onTap: galleryNoop,
              ),
              AppItemRow(
                tile: _letter('S'),
                name: 'Slack',
                subtitle: 'jane.dev · Work',
                firstTag: 'work',
                moreTags: 1,
                selected: false,
                onTap: galleryNoop,
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Swipe — Password, Username, More (swipe the row left)',
          child: AppInsetGroup(
            children: <Widget>[
              AppSwipeActions(
                actions: <AppSwipeAction>[
                  AppSwipeAction(
                    icon: AppIconName.copy,
                    label: 'Password',
                    semanticLabel: 'Copy password',
                    onPressed: galleryNoop,
                  ),
                  AppSwipeAction(
                    icon: AppIconName.userRound,
                    label: 'Username',
                    semanticLabel: 'Copy username',
                    onPressed: galleryNoop,
                  ),
                  AppSwipeAction(
                    icon: AppIconName.ellipsis,
                    label: 'More',
                    semanticLabel: 'More actions',
                    onPressed: galleryNoop,
                  ),
                ],
                child: ColoredBox(
                  color: colors.card,
                  child: AppItemRow(
                    tile: _letter('G'),
                    name: 'GitHub',
                    subtitle: 'janedoe-dev · Work',
                    favorite: true,
                    firstTag: 'work',
                    moreTags: 1,
                    onTap: galleryNoop,
                  ),
                ),
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Favorites strip',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const AppSectionLabel(
                'Favorites',
                icon: AppIconName.star,
                margin: EdgeInsets.zero,
              ),
              Transform.translate(
                offset: Offset(-16.w, 0),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: AppFavoritesStrip(
                    children: <Widget>[
                      AppFavoriteCard(
                        tile: _letter('G'),
                        name: 'GitHub',
                        subtitle: 'janedoe-dev',
                        copyLabel: 'Copy password for GitHub',
                        onCopy: galleryNoop,
                      ),
                      AppFavoriteCard(
                        tile: const AppIconTile(AppTileGlyph(FaGlyphs.wifi)),
                        name: 'Home Wi-Fi',
                        subtitle: 'Doe-Home-5G',
                        copyLabel: 'Copy password for Home Wi-Fi',
                        onCopy: galleryNoop,
                      ),
                      AppFavoriteCard(
                        tile: _letter('P'),
                        name: 'PayPal',
                        subtitle: 'jane.doe92@example.com',
                        copyLabel: 'Copy password for PayPal',
                        onCopy: galleryNoop,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Field rows — tap copy for the “Copied” label',
          child: AppInsetGroup(
            children: <Widget>[
              AppFieldRow(
                tile: _field(FaGlyphs.user),
                label: 'Username',
                value: const AppFieldText('janedoe-dev'),
                copyLabel: 'Copy username',
                onCopy: galleryNoop,
              ),
              AppFieldRow(
                tile: _field(FaGlyphs.lock),
                label: 'Password',
                alignTop: _revealed,
                value: _revealed
                    ? const AppFieldSecret('Tq7#vR2m!xW9pL4@kZ8s')
                    : const AppFieldHidden(
                        length: 20,
                        semanticLabel: 'Password, hidden',
                      ),
                below: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const AppStrengthMeter.small(AppStrength.veryStrong),
                    if (_revealed) AppLargeTypeButton(onPressed: galleryNoop),
                  ],
                ),
                actions: <Widget>[
                  AppIconButton(
                    icon: _revealed ? AppIconName.eyeOff : AppIconName.eye,
                    semanticLabel: _revealed
                        ? 'Hide password'
                        : 'Reveal password',
                    variant: AppIconButtonVariant.field,
                    color: _revealed ? colors.foreground : null,
                    onPressed: () => setState(() => _revealed = !_revealed),
                  ),
                ],
                copyLabel: 'Copy password',
                onCopy: galleryNoop,
              ),
              AppFieldRow(
                tile: _field(FaGlyphs.web),
                label: 'Website',
                value: const AppFieldText('github.com'),
                actions: <Widget>[
                  AppIconButton(
                    icon: AppIconName.externalLink,
                    semanticLabel: 'Open github.com',
                    variant: AppIconButtonVariant.field,
                    onPressed: galleryNoop,
                  ),
                ],
                copyLabel: 'Copy website',
                onCopy: galleryNoop,
              ),
              AppFieldRow(
                tile: _field(FaGlyphs.totp),
                label: 'Authenticator Code',
                value: const AppTotpCode(code: '482 913', secondsLeft: 24),
                copyLabel: 'Copy code',
                onCopy: galleryNoop,
              ),
            ],
          ),
        ),
        GallerySpecimen(
          '2FA states — last five seconds, invalid key',
          child: AppInsetGroup(
            children: <Widget>[
              AppFieldRow(
                tile: _field(FaGlyphs.totp),
                label: 'Authenticator Code',
                value: const AppTotpCode(code: '482 913', secondsLeft: 4),
                copyLabel: 'Copy code',
                onCopy: galleryNoop,
              ),
              AppFieldRow(
                tile: _field(FaGlyphs.totp),
                label: 'Authenticator Code',
                alignTop: true,
                value: const AppFieldText('Invalid code', bold: true),
                below: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'The setup key isn’t valid, so no code can be made.',
                      style: TextStyle(color: colors.mutedForeground),
                    ),
                    AppLinkButton(
                      label: 'Fix it in Edit',
                      fontSize: 14,
                      horizontalPadding: 0,
                      onPressed: galleryNoop,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'More types — email, phone, date, empty',
          child: AppInsetGroup(
            children: <Widget>[
              AppFieldRow(
                tile: _field(FaGlyphs.email),
                label: 'Email',
                value: const AppFieldText('jane.doe92@icloud.com'),
                copyLabel: 'Copy email',
                onCopy: galleryNoop,
              ),
              AppFieldRow(
                tile: _field(FaGlyphs.phone),
                label: 'Trusted Phone',
                value: AppFieldText(
                  '+1 503-555-0142',
                  leading: AppFlagFrame(
                    child: ColoredBox(color: colors.secondary),
                  ),
                ),
                actions: <Widget>[
                  AppIconButton(
                    icon: AppIconName.phone,
                    semanticLabel: 'Call',
                    variant: AppIconButtonVariant.field,
                    onPressed: galleryNoop,
                  ),
                  AppIconButton(
                    icon: AppIconName.messageCircle,
                    semanticLabel: 'Message',
                    variant: AppIconButtonVariant.field,
                    onPressed: galleryNoop,
                  ),
                ],
                copyLabel: 'Copy phone',
                onCopy: galleryNoop,
              ),
              AppFieldRow(
                tile: _field(FaGlyphs.date),
                label: 'Birthday',
                value: const AppFieldText('Apr 12, 1992'),
                copyLabel: 'Copy date',
                onCopy: galleryNoop,
              ),
              AppFieldRow(
                tile: _field(FaGlyphs.email),
                label: 'Recovery Email',
                value: const AppFieldText.empty(),
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Settings rows — value, switch, two lines, app icon, destructive',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const AppSectionLabel(
                'Security',
                icon: AppIconName.shieldCheck,
                margin: EdgeInsets.zero,
              ),
              AppInsetGroup(
                dividerInset: AppDividerInset.settings,
                children: <Widget>[
                  AppSettingsRow(
                    title: 'Auto-lock',
                    leading: _settings(AppIconName.timer),
                    value: 'After $_autoLock minutes',
                    chevron: true,
                    onTap: galleryNoop,
                  ),
                  AppSettingsRow.toggle(
                    title: 'Unlock with Face ID',
                    leading: _settings(AppIconName.scanFace),
                    value: _faceId,
                    onChanged: (bool v) => setState(() => _faceId = v),
                  ),
                  AppSettingsRow.toggle(
                    title: 'Hide in app switcher',
                    subtitle: 'Shows a cover instead of your vault',
                    leading: _settings(AppIconName.eyeOff),
                    value: _hideInSwitcher,
                    onChanged: (bool v) => setState(() => _hideInSwitcher = v),
                  ),
                  AppSettingsRow(
                    title: 'About KeeperPass',
                    leading: const AppAppIcon(size: 30),
                    value: '1.0.0',
                    chevron: true,
                    onTap: galleryNoop,
                  ),
                  AppSettingsRow(
                    title: 'Archive vault and sign out',
                    leading: _settings(
                      AppIconName.archive,
                      tone: AppTileTone.destructive,
                    ),
                    chevron: true,
                    onTap: galleryNoop,
                  ),
                ],
              ),
              const AppFootnote(
                'Locking wipes the decrypted vault from this phone’s memory.',
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Choices — checks, external link, radios',
          child: Column(
            spacing: 12.h,
            children: <Widget>[
              AppInsetGroup(
                dividerInset: AppDividerInset.text,
                children: <Widget>[
                  for (final int minutes in <int>[1, 5, 10])
                    AppSettingsRow.choice(
                      title: 'After $minutes minute${minutes == 1 ? '' : 's'}',
                      selected: _autoLock == minutes,
                      onTap: () => setState(() => _autoLock = minutes),
                    ),
                ],
              ),
              AppInsetGroup(
                dividerInset: AppDividerInset.settings,
                children: <Widget>[
                  AppSettingsRow(
                    title: 'Terms of Service',
                    leading: _settings(AppIconName.scale),
                    externalLink: true,
                    onTap: galleryNoop,
                  ),
                  AppSettingsRow.radio(
                    title: 'My Vault',
                    subtitle: '19 items',
                    selected: _vault == 'My Vault',
                    onTap: () => setState(() => _vault = 'My Vault'),
                  ),
                  AppSettingsRow.radio(
                    title: 'Work',
                    subtitle: '4 items',
                    selected: _vault == 'Work',
                    onTap: () => setState(() => _vault = 'Work'),
                  ),
                ],
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Code cards — tap to copy; invalid key',
          child: Column(
            spacing: 12.h,
            children: <Widget>[
              AppCodeCard(
                tile: _letter('G'),
                name: 'GitHub',
                subtitle: 'janedoe-dev · Work',
                code: '482 913',
                secondsLeft: 24,
                copyLabel: 'Copy code for GitHub',
                onCopy: galleryNoop,
              ),
              AppCodeCard.invalid(
                tile: const AppIconTile(AppTileGlyph(FaGlyphs.totp)),
                name: 'Cloudflare',
                subtitle: 'My Vault',
                onFix: galleryNoop,
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Finding card',
          child: AppFindingCard(
            icon: AppIconName.repeat2,
            title: 'Reused Passwords',
            count: 2,
            infoLabel: 'About Reused Passwords',
            onInfo: galleryNoop,
            onShowAll: galleryNoop,
            rows: <Widget>[
              AppFindingRow(
                tile: _letter('N'),
                name: 'Netflix',
                detail: 'Same as Instagram and Facebook',
                onTap: galleryNoop,
              ),
              AppFindingRow(
                tile: _letter('I'),
                name: 'Instagram',
                detail: 'Same as Netflix and Facebook',
                onTap: galleryNoop,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
