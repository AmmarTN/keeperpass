import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/utils/generator/generator.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/services/clipboard_service.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_haptics.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_radius.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_surface.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_strength_meter.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/copied_toast.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_bars.dart';
import 'package:keeperpass/presentation/common/widgets/overlays/app_menu.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_segmented_control.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_stepper_slider.dart';
import 'package:keeperpass/presentation/common/widgets/text/secret_text.dart';
import 'package:keeperpass/presentation/features/generator/cubit/generator_cubit.dart';
import 'package:keeperpass/presentation/features/generator/widgets/generator_controls.dart';

/// The Generator tab (boards `Generator`, `S4-07` … `S4-12`; web
/// `GeneratorPage`). Its options live as long as the tab: they are kept
/// while the vault is open and start over after a lock.
class GeneratorPage extends StatelessWidget {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<GeneratorCubit>(
    create: (_) => getIt<GeneratorCubit>()..start(),
    child: const GeneratorScreen(),
  );
}

/// [GeneratorPage] under a given cubit (tests provide their own).
class GeneratorScreen extends StatelessWidget {
  const GeneratorScreen({super.key});

  /// "Dash ( - )" — the web's separator names.
  static String separatorLabel(String separator) => switch (separator) {
    '_' => t.generator.separatorUnderscore,
    '/' => t.generator.separatorSlash,
    ' ' => t.generator.separatorSpace,
    _ => t.generator.separatorDash,
  };

  /// "English", "Deutsch" — each list named in its own language.
  static String languageLabel(String language) => kGeneratorLanguages
      .firstWhere(
        (({String value, String label}) l) => l.value == language,
        orElse: () => kGeneratorLanguages.first,
      )
      .label;

  @override
  Widget build(BuildContext context) {
    final GeneratorCubit cubit = context.read<GeneratorCubit>();
    final GeneratorState state = context.watch<GeneratorCubit>().state;
    final bool words = state.mode == GeneratorMode.passphrase;
    final double bottom = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: context.colors.background,
      body: AppLargeTitleScrollView(
        title: t.generator.pageTitle,
        subtitle: t.generator.subtitle,
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, bottom + 24.h),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 14.h,
                children: <Widget>[
                  _ResultCard(state: state),
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
                  AppSurface(
                    radius: AppRadius.xxl,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        16.w,
                        16.h,
                        16.w,
                        words ? 4.h : 16.h,
                      ),
                      child: words
                          ? _PassphraseOptions(state: state, cubit: cubit)
                          : _RandomStringOptions(state: state, cubit: cubit),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The result (`.gres`): the value large in Space Mono — digits tinted,
/// separators and symbols receding — its strength and size, then
/// Regenerate and Copy. Every new value gives a short bounce.
class _ResultCard extends StatefulWidget {
  const _ResultCard({required this.state});

  final GeneratorState state;

  @override
  State<_ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<_ResultCard> {
  bool _copied = false;
  Timer? _reset;

  @override
  void dispose() {
    _reset?.cancel();
    super.dispose();
  }

  Future<void> _copy() async {
    final AppToastHostState toasts = AppToastHost.of(context);
    final Copied? copied = await context.read<GeneratorCubit>().copy();
    if (copied == null || !mounted) return;
    unawaited(AppHaptics.copy());
    toasts.show(
      copiedToast(
        title: t.generator.copied,
        from: t.generator.fromGenerator,
        clearsIn: copied.clearsIn,
      ),
    );
    _reset?.cancel();
    setState(() => _copied = true);
    _reset = Timer(AppMotion.copiedHold, () {
      if (mounted) setState(() => _copied = false);
    });
  }

  void _regenerate() {
    unawaited(AppHaptics.regenerate());
    unawaited(context.read<GeneratorCubit>().regenerate());
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final GeneratorState state = widget.state;
    final bool nothing = state.value.isEmpty;
    final bool words = state.mode == GeneratorMode.passphrase;

    // Nothing to make: the card says so and both buttons rest (board
    // `S4-11`). While a word list loads the value is empty too, but there
    // is something to generate.
    final bool resting = nothing && state.charsetEmpty && !words;

    final Widget value = resting
        ? Text(
            t.generator.nothingToGenerate,
            textAlign: TextAlign.center,
            style: styles
                .body()
                .resized(16, line: 22, weight: FontWeight.w600)
                .copyWith(color: colors.mutedForeground),
          )
        : SecretText(
            nothing ? ' ' : state.value,
            style: styles
                .generated()
                .resized(24, line: 34, weight: FontWeight.w700)
                .copyWith(color: colors.foreground),
            textAlign: TextAlign.center,
          );

    final Duration swap = AppMotion.reduceMotion(context)
        ? Duration.zero
        : AppMotion.base;

    return AppSurface(
      radius: AppRadius.xxl,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 22.h, 16.w, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 14.h,
          children: <Widget>[
            // As the web: no live announcement — the value is read when
            // reached (your answer, Part 10).
            Semantics(
              label: t.generator.generated,
              value: resting ? t.generator.nothingToGenerate : state.value,
              excludeSemantics: true,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: 68.h),
                child: Center(
                  child: _Bounce(value: state.value, child: value),
                ),
              ),
            ),
            // One caption line high even when empty, so the card keeps its
            // height (board `Generator` 01).
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: 16.h),
              child: Row(
                spacing: 8.w,
                children: <Widget>[
                  AppStrengthMeter.small(
                    nothing ? null : AppStrength.values[state.score],
                    spaced: false,
                  ),
                  if (!nothing)
                    Flexible(
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
                ],
              ),
            ),
            Row(
              spacing: 10.w,
              children: <Widget>[
                Expanded(
                  child: AppButton(
                    label: t.generator.regenerate,
                    icon: AppIconName.rotateCw,
                    size: AppButtonSize.medium,
                    variant: AppButtonVariant.secondary,
                    onPressed: resting ? null : _regenerate,
                  ),
                ),
                Expanded(
                  // Copy confirms on the button for 1 s (board `S4-10`).
                  child: AnimatedSwitcher(
                    duration: swap,
                    child: AppButton(
                      key: ValueKey<bool>(_copied),
                      label: _copied ? t.common.copied : t.common.copy,
                      semanticLabel: _copied ? null : t.generator.copyPassword,
                      icon: _copied ? AppIconName.check : AppIconName.copy,
                      size: AppButtonSize.medium,
                      variant: _copied
                          ? AppButtonVariant.tinted
                          : AppButtonVariant.primary,
                      onPressed: nothing ? null : _copy,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A new value scales 0.97 → 1.02 → 1 in 300 ms (board `Motion`,
/// Regenerate); with Reduce Motion it crossfades in 150 ms instead.
class _Bounce extends StatefulWidget {
  const _Bounce({required this.value, required this.child});

  final String value;
  final Widget child;

  @override
  State<_Bounce> createState() => _BounceState();
}

class _BounceState extends State<_Bounce> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppMotion.slow,
    value: 1,
  );
  late final Animation<double> _scale = TweenSequence<double>(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: AppMotion.regenerateBounce[0],
          end: AppMotion.regenerateBounce[1],
        ),
        weight: 1,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: AppMotion.regenerateBounce[1],
          end: AppMotion.regenerateBounce[2],
        ),
        weight: 1,
      ),
    ],
  ).animate(CurvedAnimation(parent: _controller, curve: AppMotion.easeOut));

  @override
  void didUpdateWidget(covariant _Bounce oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value &&
        widget.value.isNotEmpty &&
        !AppMotion.reduceMotion(context)) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (AppMotion.reduceMotion(context)) {
      return AnimatedSwitcher(
        duration: AppMotion.fast,
        child: KeyedSubtree(
          key: ValueKey<String>(widget.value),
          child: widget.child,
        ),
      );
    }
    return ScaleTransition(scale: _scale, child: widget.child);
  }
}

/// Words, then Word separator and Language as menu rows (`.orow`).
class _PassphraseOptions extends StatelessWidget {
  const _PassphraseOptions({required this.state, required this.cubit});

  final GeneratorState state;
  final GeneratorCubit cubit;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      AppStepperSlider(
        label: t.generator.words,
        value: state.wordCount,
        min: kMinWordCount,
        max: kMaxWordCount,
        onChanged: cubit.setWordCount,
        decreaseLabel: t.generator.fewerWords,
        increaseLabel: t.generator.moreWords,
      ),
      SizedBox(height: 12.h),
      _MenuRow<String>(
        label: t.generator.wordSeparator,
        value: state.separator,
        valueLabel: GeneratorScreen.separatorLabel,
        options: kGeneratorSeparators,
        onChanged: cubit.setSeparator,
      ),
      _MenuRow<String>(
        label: t.generator.language,
        value: state.language,
        valueLabel: GeneratorScreen.languageLabel,
        options: <String>[
          for (final ({String value, String label}) l in kGeneratorLanguages)
            l.value,
        ],
        onChanged: cubit.setLanguage,
      ),
    ],
  );
}

/// Length, the four character tiles, and "Pick at least one kind of
/// character." when none is on.
class _RandomStringOptions extends StatelessWidget {
  const _RandomStringOptions({required this.state, required this.cubit});

  final GeneratorState state;
  final GeneratorCubit cubit;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AppStepperSlider(
          label: t.generator.length,
          value: state.length,
          min: kMinLength,
          max: kMaxLength,
          onChanged: cubit.setLength,
          decreaseLabel: t.generator.shorter,
          increaseLabel: t.generator.longer,
        ),
        SizedBox(height: 12.h),
        Divider(height: 1, thickness: 1, color: colors.border),
        SizedBox(height: 12.h),
        GeneratorCharsets(state: state, cubit: cubit),
        if (state.charsetEmpty)
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Semantics(
              liveRegion: true,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6.w,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 1.h),
                    child: AppIcon(
                      AppIconName.circleAlert,
                      size: 16,
                      stroke: 2,
                      color: colors.destructiveStrong,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      t.generator.pickOne,
                      style: AppTextStyles(context)
                          .secondary()
                          .resized(13, line: 18, weight: FontWeight.w600)
                          .copyWith(color: colors.destructiveStrong),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

/// "Word separator · Dash ( - ) ⌄" (`.orow` + `.mval`): the value opens a
/// menu of the choices, the current one checked.
class _MenuRow<T> extends StatelessWidget {
  const _MenuRow({
    required this.label,
    required this.value,
    required this.valueLabel,
    required this.options,
    required this.onChanged,
  });

  final String label;
  final T value;
  final String Function(T value) valueLabel;
  final List<T> options;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 52.h),
        child: Row(
          spacing: 12.w,
          children: <Widget>[
            Expanded(
              child: Text(
                label,
                style: styles
                    .bodyStrong()
                    .resized(15, line: 20, weight: FontWeight.w700)
                    .copyWith(color: colors.foreground),
              ),
            ),
            Builder(
              builder: (BuildContext anchor) => AppPressable(
                semanticLabel: '$label: ${valueLabel(value)}',
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                onTap: () async {
                  final T? picked = await showAppMenu<T>(
                    anchor,
                    selected: value,
                    items: <AppMenuItem<T>>[
                      for (final T option in options)
                        AppMenuItem<T>(
                          value: option,
                          label: valueLabel(option),
                        ),
                    ],
                  );
                  if (picked != null && picked != value) onChanged(picked);
                },
                child: Container(
                  height: 36.h,
                  padding: EdgeInsets.fromLTRB(12.w, 0, 10.w, 0),
                  decoration: BoxDecoration(
                    color: colors.secondary,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 6.w,
                    children: <Widget>[
                      Text(
                        valueLabel(value),
                        style: styles
                            .body()
                            .resized(15, line: 20, weight: FontWeight.w600)
                            .copyWith(color: colors.foreground),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
