import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/enums/auto_lock_delay.dart';
import 'package:keeperpass/core/enums/clipboard_clear_delay.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/cubit/language/language_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/lock/lock_cubit.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_inset_group.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_section_label.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/copied_toast.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_bars.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_settings_row.dart';
import 'package:keeperpass/presentation/features/settings/cubit/settings_cubit.dart';
import 'package:keeperpass/presentation/features/settings/widgets/settings_texts.dart';

/// A choice page under Settings (boards `S5-15` … `S5-17`): back to
/// Settings, a centred title, one list of choices and a line under it.
class SettingsChoicePage extends StatelessWidget {
  const SettingsChoicePage({
    required this.title,
    required this.children,
    this.backLabel,
    super.key,
  });

  final String title;
  final List<Widget> children;

  /// Where back goes; Settings unless opened from elsewhere.
  final String? backLabel;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.colors.background,
    body: SafeArea(
      bottom: false,
      child: Column(
        children: <Widget>[
          AppCompactBar(
            title: title,
            leading: AppLinkButton.back(
              label: backLabel ?? t.settings.title,
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                16.w,
                12.h,
                16.w,
                MediaQuery.paddingOf(context).bottom + 24.h,
              ),
              children: children,
            ),
          ),
        ],
      ),
    ),
  );
}

/// Auto-lock (board `S5-15`): immediately, or after 1, 5 or 10 minutes.
class AutoLockPage extends StatelessWidget {
  const AutoLockPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AutoLockDelay current = context.watch<LockCubit>().state;
    return SettingsChoicePage(
      title: t.settings.autoLockTitle,
      children: <Widget>[
        AppInsetGroup(
          dividerInset: AppDividerInset.text,
          children: <Widget>[
            for (final AutoLockDelay delay in AutoLockDelay.values)
              AppSettingsRow.choice(
                title: autoLockLabel(delay),
                selected: delay == current,
                onTap: () => context.read<LockCubit>().setDelay(delay),
              ),
          ],
        ),
        AppFootnote(t.settings.autoLockNote),
      ],
    );
  }
}

/// Clear Clipboard (board `S5-16`): 30 s, 1 or 2 minutes, or never, with a
/// preview of the toast that counts it down (Part 14).
class ClearClipboardPage extends StatelessWidget {
  const ClearClipboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsCubit cubit = context.read<SettingsCubit>();
    final ClipboardClearDelay current = context
        .watch<SettingsCubit>()
        .state
        .clipboardDelay;
    final Duration? clears = current.duration;
    return SettingsChoicePage(
      title: t.settings.clearClipboardTitle,
      children: <Widget>[
        AppInsetGroup(
          dividerInset: AppDividerInset.text,
          children: <Widget>[
            for (final ClipboardClearDelay delay in ClipboardClearDelay.values)
              AppSettingsRow.choice(
                title: clipboardLabel(delay),
                selected: delay == current,
                onTap: () => cubit.setClipboardDelay(delay),
              ),
          ],
        ),
        AppFootnote(t.settings.clipboardNote),
        AppSectionLabel(t.settings.preview),
        AppToast(
          AppToastData(
            icon: AppIconName.clipboardCheck,
            title: t.generator.copied,
            detail: clears == null
                ? t.settings.previewFrom
                : t.settings.previewClears(time: shortDuration(clears)),
          ),
          // The board's moment: some of the time already gone.
          progress: clears == null
              ? null
              : const AlwaysStoppedAnimation<double>(0.72),
          resting: true,
        ),
      ],
    );
  }
}

/// Language (board `S5-17`): each named in its own language.
class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final LocaleLanguage current = context.watch<LanguageCubit>().state;
    return SettingsChoicePage(
      title: t.settings.languageTitle,
      children: <Widget>[
        AppInsetGroup(
          dividerInset: AppDividerInset.text,
          children: <Widget>[
            for (final LocaleLanguage language in LocaleLanguage.values)
              AppSettingsRow.choice(
                title: languageName(language),
                selected: language == current,
                onTap: () =>
                    context.read<LanguageCubit>().setLanguage(language),
              ),
          ],
        ),
        AppFootnote(t.settings.languageNote),
      ],
    );
  }
}
