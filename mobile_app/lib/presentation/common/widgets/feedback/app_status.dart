import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_shadows.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_spinner.dart';

/// Where the vault's saving stands.
enum AppSaveState {
  /// "Encrypting your vault…", "Saving to Google Drive…".
  working,

  /// "Saved to Google Drive".
  saved,

  /// "1 change not saved".
  notSaved,
}

/// The saving pill under the top bar (board C6 "Saving"): a spinner while
/// working, the cloud check once saved.
class AppSavingPill extends StatelessWidget {
  const AppSavingPill({required this.state, required this.label, super.key});

  final AppSaveState state;
  final String label;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return Semantics(
      liveRegion: true,
      child: Container(
        height: 32.h,
        padding: EdgeInsets.only(left: 12.w, right: 14.w),
        decoration: ShapeDecoration(
          color: colors.card,
          shape: const StadiumBorder(),
          shadows: <BoxShadow>[
            ...context.shadows.shadowFloat,
            BoxShadow(color: colors.hairline, spreadRadius: 1.r),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8.w,
          children: <Widget>[
            _StatusIcon(state, spinner: 14, icon: 16),
            Text(
              label,
              style: AppTextStyles(context)
                  .secondary()
                  .resized(13, line: 18, weight: FontWeight.w700)
                  .copyWith(color: colors.foreground),
            ),
          ],
        ),
      ),
    );
  }
}

/// The list's status line (`.stl`): "23 items · Saved to Google Drive".
class AppStatusLine extends StatelessWidget {
  const AppStatusLine({required this.state, required this.label, super.key});

  final AppSaveState state;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: state != AppSaveState.saved,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 6.w,
        children: <Widget>[
          _StatusIcon(state, spinner: 14, icon: 15),
          Flexible(
            child: Text(
              label,
              style: AppTextStyles(
                context,
              ).secondary().copyWith(color: context.colors.mutedForeground),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusIcon extends StatelessWidget {
  const _StatusIcon(this.state, {required this.spinner, required this.icon});

  final AppSaveState state;
  final double spinner;
  final double icon;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return switch (state) {
      AppSaveState.working => AppSpinner(size: spinner),
      AppSaveState.saved => AppIcon(
        AppIconName.cloudCheck,
        size: icon,
        stroke: 2,
        color: colors.accentStrong,
      ),
      AppSaveState.notSaved => AppIcon(
        AppIconName.cloudOff,
        size: icon,
        stroke: 2,
        color: colors.destructiveStrong,
      ),
    };
  }
}

/// A step's state in [AppStagedProgress].
enum AppStepState { done, running, waiting, failed }

/// One step of a staged progress.
@immutable
class AppProgressStep {
  const AppProgressStep({
    required this.label,
    required this.state,
    this.progress,
    this.detail,
  });

  /// "Saving to Google Drive…".
  final String label;
  final AppStepState state;

  /// A real percentage while running (0–1).
  final double? progress;

  /// "Nothing was changed."
  final String? detail;
}

/// Staged progress (board C6): done, running with a real percentage,
/// waiting, failed — always words alongside.
class AppStagedProgress extends StatelessWidget {
  const AppStagedProgress({required this.steps, super.key});

  final List<AppProgressStep> steps;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 14.h,
      children: <Widget>[
        for (final AppProgressStep step in steps)
          Semantics(
            liveRegion:
                step.state == AppStepState.running ||
                step.state == AppStepState.failed,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12.w,
              children: <Widget>[
                switch (step.state) {
                  AppStepState.done => AppIcon(
                    AppIconName.circleCheck,
                    size: 22,
                    stroke: 2,
                    color: colors.accentStrong,
                  ),
                  AppStepState.running => const AppSpinner(size: 22),
                  AppStepState.waiting => Opacity(
                    opacity: 0.6,
                    child: AppIcon(
                      AppIconName.circle,
                      size: 22,
                      color: colors.mutedForeground,
                    ),
                  ),
                  AppStepState.failed => AppIcon(
                    AppIconName.circleX,
                    size: 22,
                    stroke: 2,
                    color: colors.destructiveStrong,
                  ),
                },
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 2.h,
                    children: <Widget>[
                      Text(
                        step.label,
                        style: styles
                            .body()
                            .resized(
                              15,
                              line: 22,
                              weight:
                                  step.state == AppStepState.running ||
                                      step.state == AppStepState.failed
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                            )
                            .copyWith(
                              color:
                                  step.state == AppStepState.done ||
                                      step.state == AppStepState.waiting
                                  ? colors.mutedForeground
                                  : colors.foreground,
                            ),
                      ),
                      if (step.progress != null)
                        Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: SizedBox(
                              height: 6.r,
                              child: ColoredBox(
                                color: colors.primary15,
                                child: FractionallySizedBox(
                                  alignment: AlignmentDirectional.centerStart,
                                  widthFactor: step.progress!.clamp(0, 1),
                                  child: DecoratedBox(
                                    decoration: ShapeDecoration(
                                      color: colors.primary,
                                      shape: const StadiumBorder(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (step.detail != null)
                        Text(
                          step.detail!,
                          style: styles.secondary().copyWith(
                            color: colors.mutedForeground,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
