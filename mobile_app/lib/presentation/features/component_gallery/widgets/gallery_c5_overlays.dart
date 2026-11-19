import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_inset_group.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pill.dart';
import 'package:keeperpass/presentation/common/widgets/bottom_sheet/app_sheet.dart';
import 'package:keeperpass/presentation/common/widgets/bottom_sheet/app_sheet_parts.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_totp_ring.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_text_field.dart';
import 'package:keeperpass/presentation/common/widgets/overlays/app_dialog.dart';
import 'package:keeperpass/presentation/common/widgets/overlays/app_menu.dart';
import 'package:keeperpass/presentation/features/component_gallery/widgets/gallery_section.dart';

/// Board C5 · Sheets, menus and dialogs — tap to open each.
class GalleryOverlays extends StatefulWidget {
  const GalleryOverlays({super.key});

  @override
  State<GalleryOverlays> createState() => _GalleryOverlaysState();
}

class _GalleryOverlaysState extends State<GalleryOverlays> {
  String _sort = 'Newest first';
  String _language = 'English';
  final TextEditingController _vaultName = TextEditingController(text: 'Work');

  @override
  void dispose() {
    _vaultName.dispose();
    super.dispose();
  }

  void _vaultsSheet() {
    showAppSheet<void>(
      context,
      builder: (BuildContext context) {
        final AppColors colors = context.colors;
        return AppSheet(
          title: 'Vaults',
          child: SingleChildScrollView(
            child: Column(
              spacing: 12.h,
              children: <Widget>[
                AppInsetGroup.sheet(
                  children: <Widget>[
                    AppSheetRow(
                      label: 'All Vaults',
                      leading: const AppIcon(AppIconName.layers, size: 20),
                      count: 23,
                      selected: true,
                      onTap: galleryNoop,
                    ),
                    AppSheetRow(
                      label: 'Favorites',
                      leading: const AppIcon(AppIconName.star, size: 20),
                      count: 3,
                      selected: false,
                      onTap: galleryNoop,
                    ),
                    AppSheetRow(
                      label: 'Recently Used',
                      leading: const AppIcon(
                        AppIconName.rotateCcwClock,
                        size: 20,
                      ),
                      count: 6,
                      selected: false,
                      onTap: galleryNoop,
                    ),
                  ],
                ),
                AppInsetGroup.sheet(
                  children: <Widget>[
                    AppSheetRow(
                      label: 'My Vault',
                      leading: FaGlyph(
                        FaGlyphs.vault,
                        size: 17,
                        color: colors.mutedForeground,
                      ),
                      count: 19,
                      selected: false,
                      onTap: galleryNoop,
                    ),
                    AppSheetRow(
                      label: 'Work',
                      leading: FaGlyph(
                        FaGlyphs.vault,
                        size: 17,
                        color: colors.mutedForeground,
                      ),
                      count: 4,
                      selected: false,
                      onTap: galleryNoop,
                    ),
                  ],
                ),
                AppInsetGroup.sheet(
                  children: <Widget>[
                    AppSheetRow(
                      label: 'Manage vaults',
                      leading: const AppIcon(AppIconName.settings2, size: 20),
                      chevron: true,
                      onTap: galleryNoop,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _keyboardSheet() {
    showAppSheet<void>(
      context,
      builder: (BuildContext context) => AppSheet(
        title: 'New Vault',
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 14.h,
          children: <Widget>[
            Text(
              'A vault is a separate group of items. Unlike an item, there is nothing else to choose up front.',
              style: AppTextStyles(
                context,
              ).body().copyWith(color: context.colors.mutedForeground),
            ),
            AppTextField(
              label: 'Vault name',
              surface: AppFieldSurface.card,
              autofocus: true,
              controller: _vaultName,
              errorText: 'A vault with this name already exists.',
            ),
            const AppButton(label: 'Create vault', onPressed: null),
          ],
        ),
      ),
    );
  }

  void _quickSheet() {
    showAppSheet<void>(
      context,
      builder: (BuildContext context) {
        final AppColors colors = context.colors;
        return AppSheet(
          showClose: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 14.h,
            children: <Widget>[
              AppQuickHeader(
                tile: const AppIconTile(
                  AppTileLetter('G'),
                  tone: AppTileTone.white,
                ),
                name: 'GitHub',
                subtitle: 'janedoe-dev · Work',
                trailing: AppPill.vault(
                  'Favorite',
                  tone: AppPillTone.accent,
                  leading: FaGlyph(
                    FaGlyphs.favourite,
                    size: 11,
                    weight: FaWeight.solid,
                    color: colors.accentStrong,
                  ),
                ),
              ),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 8.h,
                crossAxisSpacing: 8.w,
                childAspectRatio: 2.6,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  AppFieldChip(
                    glyph: FaGlyphs.user,
                    label: 'Username',
                    value: const Text('janedoe-dev'),
                    onTap: galleryNoop,
                  ),
                  AppFieldChip(
                    glyph: FaGlyphs.lock,
                    label: 'Password',
                    value: const Text('••••••••••••'),
                    onTap: galleryNoop,
                  ),
                  AppFieldChip(
                    glyph: FaGlyphs.totp,
                    label: 'Authenticator Code',
                    value: Row(
                      spacing: 8.w,
                      children: <Widget>[
                        Text(
                          '482 913',
                          style: AppTextStyles(context).fileName().resized(
                            15,
                            line: 20,
                            weight: FontWeight.w700,
                          ),
                        ),
                        const AppTotpRing(secondsLeft: 20, size: 16),
                      ],
                    ),
                    onTap: galleryNoop,
                  ),
                  AppFieldChip(
                    glyph: FaGlyphs.web,
                    label: 'Website',
                    value: const Text('github.com'),
                    onTap: galleryNoop,
                  ),
                ],
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.background,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    children: <Widget>[
                      AppQuickActionRow(
                        icon: AppIconName.externalLink,
                        label: 'Open website',
                        onTap: galleryNoop,
                      ),
                      AppQuickActionRow(
                        icon: AppIconName.star,
                        label: 'Remove from favorites',
                        onTap: galleryNoop,
                      ),
                      AppQuickActionRow(
                        icon: AppIconName.folderInput,
                        label: 'Move to vault…',
                        onTap: galleryNoop,
                      ),
                      AppQuickActionRow(
                        icon: AppIconName.circleCheck,
                        label: 'Select',
                        onTap: galleryNoop,
                      ),
                      AppQuickActionRow(
                        icon: AppIconName.trash,
                        label: 'Delete',
                        destructive: true,
                        onTap: galleryNoop,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GallerySection(
      title: 'C5 · Sheets, menus and dialogs',
      children: <Widget>[
        GallerySpecimen(
          'Sheets — grab bar, title, close; keyboard; quick sheet',
          child: Column(
            spacing: 8.h,
            children: <Widget>[
              AppButton(
                label: 'Vaults sheet',
                variant: AppButtonVariant.secondary,
                size: AppButtonSize.medium,
                onPressed: _vaultsSheet,
              ),
              AppButton(
                label: 'Keyboard sheet',
                variant: AppButtonVariant.secondary,
                size: AppButtonSize.medium,
                onPressed: _keyboardSheet,
              ),
              AppButton(
                label: 'Quick sheet',
                variant: AppButtonVariant.secondary,
                size: AppButtonSize.medium,
                onPressed: _quickSheet,
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Dialogs — accent, tint, solid',
          child: Column(
            spacing: 8.h,
            children: <Widget>[
              AppButton(
                label: 'Dialog · accent',
                variant: AppButtonVariant.secondary,
                size: AppButtonSize.medium,
                onPressed: () => showAppDialog(
                  context,
                  icon: AppIconName.undo2,
                  title: 'Restore this version?',
                  message: 'GitHub goes back to how it was on Oct 21, 2026.',
                  confirmLabel: 'Restore',
                ),
              ),
              AppButton(
                label: 'Dialog · tint',
                variant: AppButtonVariant.secondary,
                size: AppButtonSize.medium,
                onPressed: () => showAppDialog(
                  context,
                  icon: AppIconName.trash,
                  title: 'Are you sure you want to remove this field?',
                  smallTitle: true,
                  message:
                      '“Website” and its value leave GitHub when you save.',
                  confirmLabel: 'Remove',
                  tone: AppDialogTone.tint,
                ),
              ),
              AppButton(
                label: 'Dialog · solid',
                variant: AppButtonVariant.secondary,
                size: AppButtonSize.medium,
                onPressed: () => showAppDialog(
                  context,
                  icon: AppIconName.trash,
                  title: 'Delete Item',
                  message:
                      'Are you sure you want to delete ‘GitHub’? This cannot be undone.',
                  confirmLabel: 'Delete item',
                  tone: AppDialogTone.solid,
                ),
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Menus — sort, more, language',
          child: Column(
            spacing: 8.h,
            children: <Widget>[
              Builder(
                builder: (BuildContext anchor) => AppButton(
                  label: 'Sort: $_sort',
                  variant: AppButtonVariant.secondary,
                  size: AppButtonSize.medium,
                  onPressed: () async {
                    final String? value = await showAppMenu<String>(
                      anchor,
                      heading: 'Sort by last update',
                      selected: _sort,
                      items: const <AppMenuItem<String>>[
                        AppMenuItem<String>(
                          value: 'Newest first',
                          label: 'Newest first',
                        ),
                        AppMenuItem<String>(
                          value: 'Oldest first',
                          label: 'Oldest first',
                        ),
                        AppMenuItem<String>(value: 'A to Z', label: 'A to Z'),
                      ],
                    );
                    if (value != null) setState(() => _sort = value);
                  },
                ),
              ),
              Builder(
                builder: (BuildContext anchor) => AppButton(
                  label: 'More options',
                  variant: AppButtonVariant.secondary,
                  size: AppButtonSize.medium,
                  onPressed: () => showAppMenu<String>(
                    anchor,
                    width: 236,
                    items: const <AppMenuItem<String>>[
                      AppMenuItem<String>(
                        value: 'move',
                        label: 'Move to vault…',
                        icon: AppIconName.folderInput,
                      ),
                      AppMenuItem<String>(
                        value: 'delete',
                        label: 'Delete item',
                        icon: AppIconName.trash,
                        destructive: true,
                      ),
                    ],
                  ),
                ),
              ),
              Builder(
                builder: (BuildContext anchor) => AppButton(
                  label: 'Language: $_language',
                  variant: AppButtonVariant.secondary,
                  size: AppButtonSize.medium,
                  onPressed: () async {
                    final String? value = await showAppMenu<String>(
                      anchor,
                      selected: _language,
                      items: const <AppMenuItem<String>>[
                        AppMenuItem<String>(value: 'English', label: 'English'),
                        AppMenuItem<String>(value: 'Deutsch', label: 'Deutsch'),
                        AppMenuItem<String>(value: 'Español', label: 'Español'),
                        AppMenuItem<String>(
                          value: 'Français',
                          label: 'Français',
                        ),
                        AppMenuItem<String>(
                          value: 'Português',
                          label: 'Português',
                        ),
                      ],
                    );
                    if (value != null) setState(() => _language = value);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
