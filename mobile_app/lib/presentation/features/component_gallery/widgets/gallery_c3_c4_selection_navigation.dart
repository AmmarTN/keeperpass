import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/enums/theme_preference.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_inset_group.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_icon_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_bars.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_tab_bar.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_settings_row.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_checks.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_filter_chip.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_scope_switcher.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_segmented_control.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_stepper_slider.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_switch.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_tag_chip.dart';
import 'package:keeperpass/presentation/features/component_gallery/widgets/gallery_section.dart';

/// Board C3 · Selection controls.
class GallerySelection extends StatefulWidget {
  const GallerySelection({super.key});

  @override
  State<GallerySelection> createState() => _GallerySelectionState();
}

class _GallerySelectionState extends State<GallerySelection> {
  bool _devFilter = true;
  bool _reusedFilter = true;
  String _mode = 'Passphrase';
  String _separator = 'Dash';
  ThemePreference _theme = ThemePreference.auto;
  bool _switch = true;
  bool _secret = true;
  bool _lower = true;
  bool _symbols = false;
  bool _written = true;
  bool _replace = false;
  bool _keep = true;
  int _words = 4;

  @override
  Widget build(BuildContext context) {
    return GallerySection(
      title: 'C3 · Selection controls',
      children: <Widget>[
        GallerySpecimen(
          'Tags — list pill (+N), detail chip, removable',
          child: GalleryWrap(
            children: <Widget>[
              const AppTagChip('work', style: AppTagChipStyle.list),
              const AppMoreCount(1),
              const AppTagChip('work'),
              const AppTagChip('dev'),
              const AppTagChip('travel'),
              AppTagChip(
                'work',
                style: AppTagChipStyle.editable,
                onRemove: galleryNoop,
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Filter chips — off, on, finding filter, manage',
          child: GalleryWrap(
            children: <Widget>[
              AppFilterChip.tag(
                tag: 'work',
                count: 7,
                selected: false,
                onPressed: galleryNoop,
              ),
              AppFilterChip.tag(
                tag: 'dev',
                count: 4,
                selected: _devFilter,
                onPressed: () => setState(() => _devFilter = !_devFilter),
              ),
              AppFilterChip(
                label: 'Reused passwords',
                selected: _reusedFilter,
                clearable: true,
                leading: const AppIcon(
                  AppIconName.repeat2,
                  size: AppIconSizes.xs,
                  stroke: 2.25,
                ),
                onPressed: () => setState(() => _reusedFilter = !_reusedFilter),
              ),
              AppFilterChip(
                label: 'Manage tags',
                selected: false,
                leading: const AppIcon(
                  AppIconName.settings2,
                  size: AppIconSizes.xs,
                  stroke: 2,
                ),
                onPressed: galleryNoop,
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Scope switcher',
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: AppScopeSwitcher(
              title: 'All Vaults',
              onPressed: galleryNoop,
            ),
          ),
        ),
        GallerySpecimen(
          'Segmented — two to four options',
          child: Column(
            spacing: 12.h,
            children: <Widget>[
              AppSegmentedControl<String>(
                semanticLabel: 'Mode',
                segments: const <AppSegment<String>>[
                  AppSegment<String>('Passphrase', 'Passphrase'),
                  AppSegment<String>('Random', 'Random string'),
                ],
                selected: _mode,
                onChanged: (String v) => setState(() => _mode = v),
              ),
              AppSegmentedControl<String>(
                semanticLabel: 'Word separator',
                fontSize: 13,
                segments: const <AppSegment<String>>[
                  AppSegment<String>('Dash', 'Dash'),
                  AppSegment<String>('Underscore', 'Underscore'),
                  AppSegment<String>('Slash', 'Slash'),
                  AppSegment<String>('Space', 'Space'),
                ],
                selected: _separator,
                onChanged: (String v) => setState(() => _separator = v),
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Inline segmented — Theme',
          child: AppInsetGroup(
            dividerInset: AppDividerInset.settings,
            children: <Widget>[
              AppSettingsRow(
                title: 'Theme',
                leading: const AppIconTile(
                  AppTileIcon(AppIconName.contrast),
                  size: AppTileSize.settings,
                ),
                trailing: AppSegmentedControl<ThemePreference>(
                  inline: true,
                  semanticLabel: 'Theme',
                  segments: const <AppSegment<ThemePreference>>[
                    AppSegment<ThemePreference>(ThemePreference.auto, 'Auto'),
                    AppSegment<ThemePreference>(ThemePreference.light, 'Light'),
                    AppSegment<ThemePreference>(ThemePreference.dark, 'Dark'),
                  ],
                  selected: _theme,
                  onChanged: (ThemePreference v) => setState(() => _theme = v),
                ),
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Switch and toggle chip',
          child: GalleryWrap(
            children: <Widget>[
              AppSwitch(
                value: _switch,
                onChanged: (bool v) => setState(() => _switch = v),
              ),
              AppSwitch(
                value: !_switch,
                onChanged: (bool v) => setState(() => _switch = !v),
              ),
              const AppSwitch(value: true, onChanged: null),
              AppToggleChip(
                value: _secret,
                fieldName: 'Password',
                onChanged: (bool v) => setState(() => _secret = v),
              ),
              AppToggleChip(
                value: !_secret,
                fieldName: 'Website',
                onChanged: (bool v) => setState(() => _secret = !v),
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Checkboxes — tiles and acknowledgements',
          child: Column(
            spacing: 8.h,
            children: <Widget>[
              Row(
                spacing: 8.w,
                children: <Widget>[
                  Expanded(
                    child: AppCheckTile(
                      label: 'a–z',
                      semanticLabel: 'Lowercase letters',
                      checked: _lower,
                      onChanged: (bool v) => setState(() => _lower = v),
                    ),
                  ),
                  Expanded(
                    child: AppCheckTile(
                      label: '?()/%…',
                      semanticLabel: 'Symbols',
                      checked: _symbols,
                      onChanged: (bool v) => setState(() => _symbols = v),
                    ),
                  ),
                ],
              ),
              AppCheckRow(
                label: 'I’ve written my secret down',
                checked: _written,
                onChanged: (bool v) => setState(() => _written = v),
              ),
              AppCheckRow(
                label: 'Replace it — the existing vault is kept as a backup',
                checked: _replace,
                onChanged: (bool v) => setState(() => _replace = v),
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Radio rows',
          child: AppInsetGroup(
            dividerInset: AppDividerInset.text,
            children: <Widget>[
              AppSettingsRow.radio(
                title: 'Keep my current secret',
                selected: _keep,
                onTap: () => setState(() => _keep = true),
              ),
              AppSettingsRow.radio(
                title: 'Choose a new secret',
                subtitle: 'Only the moved vault uses it',
                selected: !_keep,
                onTap: () => setState(() => _keep = false),
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Slider with stepper — drag for the halo',
          child: AppStepperSlider(
            label: 'Words',
            value: _words,
            min: 3,
            max: 12,
            decreaseLabel: 'Fewer words',
            increaseLabel: 'More words',
            onChanged: (int v) => setState(() => _words = v),
          ),
        ),
      ],
    );
  }
}

/// Board C4 · Navigation and bars.
class GalleryNavigation extends StatefulWidget {
  const GalleryNavigation({super.key});

  @override
  State<GalleryNavigation> createState() => _GalleryNavigationState();
}

class _GalleryNavigationState extends State<GalleryNavigation> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return GallerySection(
      title: 'C4 · Navigation and bars',
      children: <Widget>[
        GallerySpecimen(
          'Tab bar — five tabs, a badge on Security',
          child: MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            child: AppTabBar(
              selectedIndex: _tab,
              onSelected: (int i) => setState(() => _tab = i),
              tabs: const <AppTab>[
                AppTab(icon: AppIconName.layers, label: 'Vault'),
                AppTab(icon: AppIconName.timer, label: 'Codes'),
                AppTab(icon: AppIconName.wandSparkles, label: 'Generator'),
                AppTab(
                  icon: AppIconName.shieldCheck,
                  label: 'Security',
                  badgeCount: 4,
                  semanticLabel: 'Security, 4 items flagged',
                ),
                AppTab(icon: AppIconName.settings, label: 'Settings'),
              ],
            ),
          ),
        ),
        GallerySpecimen(
          'Large title — scroll it: the title moves into the bar',
          child: SizedBox(
            height: 320.h,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: colors.hairline),
                ),
                child: AppLargeTitleScrollView(
                  title: 'Tags',
                  subtitle:
                      'Labels that cut across vaults, for finding things fast',
                  leading: AppLinkButton.back(
                    label: 'All Vaults',
                    onPressed: galleryNoop,
                  ),
                  actions: <Widget>[
                    AppLinkButton.bar(label: 'Select', onPressed: galleryNoop),
                    AppIconButton(
                      icon: AppIconName.plus,
                      semanticLabel: 'Add tag',
                      onPressed: galleryNoop,
                    ),
                  ],
                  slivers: <Widget>[
                    SliverPadding(
                      padding: EdgeInsets.all(16.r),
                      sliver: SliverList.separated(
                        itemCount: 12,
                        separatorBuilder: (_, _) => SizedBox(height: 8.h),
                        itemBuilder: (_, int i) => AppTagChip('tag ${i + 1}'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        GallerySpecimen(
          'Compact bars — pushed, modal, edit (Save waits), item',
          child: Column(
            spacing: 8.h,
            children: <Widget>[
              AppCompactBar(
                title: 'Auto-lock',
                leading: AppLinkButton.back(
                  label: 'Settings',
                  onPressed: galleryNoop,
                ),
              ),
              AppCompactBar(
                title: 'Change Secret',
                leading: AppLinkButton.bar(
                  label: 'Cancel',
                  onPressed: galleryNoop,
                ),
                trailing: AppLinkButton.bar(
                  label: 'Save',
                  weight: FontWeight.w800,
                  onPressed: galleryNoop,
                ),
              ),
              AppCompactBar(
                title: 'Edit Item',
                slotWidth: 96,
                leading: AppLinkButton.bar(
                  label: 'Cancel',
                  weight: FontWeight.w400,
                  onPressed: galleryNoop,
                ),
                trailing: const AppLinkButton.bar(
                  label: 'Save',
                  weight: FontWeight.w800,
                  onPressed: null,
                ),
              ),
              Row(
                children: <Widget>[
                  AppLinkButton.back(
                    label: 'All Vaults',
                    onPressed: galleryNoop,
                  ),
                  const Spacer(),
                  AppIconButton(
                    icon: AppIconName.star,
                    semanticLabel: 'Remove from favorites',
                    color: colors.accentStrong,
                    onPressed: galleryNoop,
                  ),
                  AppLinkButton.bar(
                    label: 'Edit',
                    horizontalPadding: 6,
                    onPressed: galleryNoop,
                  ),
                  AppIconButton(
                    icon: AppIconName.ellipsis,
                    semanticLabel: 'More options',
                    onPressed: galleryNoop,
                  ),
                ],
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Selection — the bar and the counted actions',
          child: MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            child: Column(
              children: <Widget>[
                AppCompactBar(
                  title: '3 selected',
                  slotWidth: 100,
                  leading: AppLinkButton.bar(
                    label: 'Cancel',
                    weight: FontWeight.w400,
                    onPressed: galleryNoop,
                  ),
                  trailing: AppLinkButton.bar(
                    label: 'Select All',
                    weight: FontWeight.w400,
                    onPressed: galleryNoop,
                  ),
                ),
                AppSelectionToolbar(
                  actions: <AppButton>[
                    AppButton(
                      label: 'Move 3 items',
                      icon: AppIconName.folderInput,
                      size: AppButtonSize.medium,
                      variant: AppButtonVariant.secondary,
                      onPressed: galleryNoop,
                    ),
                    AppButton(
                      label: 'Delete 3 items',
                      icon: AppIconName.trash,
                      size: AppButtonSize.medium,
                      variant: AppButtonVariant.destructive,
                      onPressed: galleryNoop,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const GallerySpecimen('Steps', child: AppStepBar(current: 2, total: 3)),
      ],
    );
  }
}
