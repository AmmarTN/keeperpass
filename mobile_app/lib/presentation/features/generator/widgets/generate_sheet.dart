import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/utils/generator/generator.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_radius.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_surface.dart';
import 'package:keeperpass/presentation/common/widgets/bottom_sheet/app_sheet.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_strength_meter.dart';
import 'package:keeperpass/presentation/common/widgets/overlays/app_menu.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_segmented_control.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_stepper_slider.dart';
import 'package:keeperpass/presentation/common/widgets/text/secret_text.dart';
import 'package:keeperpass/presentation/features/generator/cubit/generator_cubit.dart';
import 'package:keeperpass/presentation/features/generator/widgets/generator_controls.dart';

/// "Generate a password" from a password field (boards `S3-52`, `S3-53`;
/// web `GeneratePasswordDialog`): the Generator tab's controls in compact
/// form. Nothing reaches the field until "Use this password"; resolves to
/// the password, or null when closed.
Future<String?> showGenerateSheet(
  BuildContext context, {
  GeneratorCubit? cubit,
}) => showAppSheet<String>(
  context,
  builder: (_) => BlocProvider<GeneratorCubit>(
    create: (_) => (cubit ?? getIt<GeneratorCubit>())..start(),
    child: const _GenerateSheet(),
  ),
);

class _GenerateSheet extends StatelessWidget {
  const _GenerateSheet();

  @override
  Widget build(BuildContext context) {
    final GeneratorCubit cubit = context.read<GeneratorCubit>();
    final GeneratorState state = context.watch<GeneratorCubit>().state;
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final bool words = state.mode == GeneratorMode.passphrase;

    return AppSheet(
      title: t.generator.title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 14.h,
        children: <Widget>[
          Transform.translate(
            offset: Offset(0, -6.h),
            child: Text(
              t.generator.notFilledIn,
              style: styles.secondary().copyWith(color: colors.mutedForeground),
            ),
          ),
          _Result(state: state, onRegenerate: cubit.regenerate),
          AppSegmentedControl<GeneratorMode>(
            semanticLabel: t.generator.mode,
            segments: <AppSegment<GeneratorMode>>[
              AppSegment<GeneratorMode>(
                GeneratorMode.passphrase,
                t.generator.passphrase,
              ),
              AppSegment<GeneratorMode>(
                GeneratorMode.randomString,
                t.generator.randomString,
              ),
            ],
            selected: state.mode,
            onChanged: cubit.setMode,
          ),
          if (words) ...<Widget>[
            AppStepperSlider(
              label: t.generator.words,
              value: state.wordCount,
              min: kMinWordCount,
              max: kMaxWordCount,
              onChanged: cubit.setWordCount,
              decreaseLabel: t.generator.fewerWords,
              increaseLabel: t.generator.moreWords,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 8.h,
              children: <Widget>[
                Text(
                  t.generator.wordSeparator,
                  style: styles
                      .bodyStrong()
                      .resized(15, line: 20, weight: FontWeight.w700)
                      .copyWith(color: colors.foreground),
                ),
                AppSegmentedControl<String>(
                  semanticLabel: t.generator.wordSeparator,
                  fontSize: 13,
                  segments: <AppSegment<String>>[
                    AppSegment<String>('-', t.generator.dash),
                    AppSegment<String>('_', t.generator.underscore),
                    AppSegment<String>('/', t.generator.slash),
                    AppSegment<String>(' ', t.generator.space),
                  ],
                  selected: state.separator,
                  onChanged: cubit.setSeparator,
                ),
              ],
            ),
            _LanguageRow(
              language: state.language,
              onChanged: cubit.setLanguage,
            ),
          ] else ...<Widget>[
            AppStepperSlider(
              label: t.generator.length,
              value: state.length,
              min: kMinLength,
              max: kMaxLength,
              onChanged: cubit.setLength,
              decreaseLabel: t.generator.shorter,
              increaseLabel: t.generator.longer,
            ),
            GeneratorCharsets(state: state, cubit: cubit),
            if (state.charsetEmpty)
              Text(
                t.generator.pickOne,
                style: styles.secondary().copyWith(
                  color: colors.destructiveStrong,
                ),
              ),
          ],
          Padding(
            padding: EdgeInsets.only(top: 4.h, bottom: 4.h),
            child: AppButton(
              label: t.generator.use,
              icon: AppIconName.check,
              onPressed: state.value.isEmpty
                  ? null
                  : () => Navigator.of(context).pop(state.value),
            ),
          ),
        ],
      ),
    );
  }
}

/// The suggestion in Space Mono — digits tinted, separators receding — with
/// its strength, its size and Regenerate.
class _Result extends StatelessWidget {
  const _Result({required this.state, required this.onRegenerate});

  final GeneratorState state;
  final VoidCallback onRegenerate;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final bool words = state.mode == GeneratorMode.passphrase;
    return AppSurface(
      radius: AppRadius.xxl,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 18.h, 8.w, 6.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 10.h,
          children: <Widget>[
            Semantics(
              liveRegion: true,
              label: t.generator.generated,
              value: state.value,
              excludeSemantics: true,
              child: Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: SecretText(
                  state.value.isEmpty ? ' ' : state.value,
                  style: styles
                      .generated()
                      .resized(21, line: 30, weight: FontWeight.w700)
                      .copyWith(color: colors.foreground),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: colors.border)),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Row(
                  spacing: 8.w,
                  children: <Widget>[
                    if (state.value.isNotEmpty)
                      AppStrengthMeter.small(AppStrength.values[state.score]),
                    Expanded(
                      child: Text(
                        '· ${words ? t.generator.wordCount(n: state.wordCount) : t.generator.charCount(count: state.length)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: styles
                            .secondary()
                            .resized(12, line: 16)
                            .copyWith(color: colors.mutedForeground),
                      ),
                    ),
                    AppPressable(
                      onTap: onRegenerate,
                      semanticLabel: t.generator.regenerate,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: SizedBox.square(
                        dimension: AppPressable.minTarget(context),
                        child: Center(
                          child: AppIcon(
                            AppIconName.rotateCw,
                            size: AppIconSizes.md,
                            color: colors.mutedForeground,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// "Language · English ⌄" (`.trow`).
class _LanguageRow extends StatelessWidget {
  const _LanguageRow({required this.language, required this.onChanged});

  final String language;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final String label = kGeneratorLanguages
        .firstWhere(
          (({String value, String label}) l) => l.value == language,
          orElse: () => kGeneratorLanguages.first,
        )
        .label;
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 44.h),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              t.generator.language,
              style: AppTextStyles(context)
                  .bodyStrong()
                  .resized(15, line: 20, weight: FontWeight.w700)
                  .copyWith(color: context.colors.foreground),
            ),
          ),
          Builder(
            builder: (BuildContext anchor) => AppLinkButton(
              label: label,
              icon: AppIconName.chevronDown,
              iconAfter: true,
              horizontalPadding: 0,
              onPressed: () async {
                final String? picked = await showAppMenu<String>(
                  anchor,
                  selected: language,
                  items: <AppMenuItem<String>>[
                    for (final ({String value, String label}) l
                        in kGeneratorLanguages)
                      AppMenuItem<String>(value: l.value, label: l.label),
                  ],
                );
                if (picked != null) onChanged(picked);
              },
            ),
          ),
        ],
      ),
    );
  }
}
