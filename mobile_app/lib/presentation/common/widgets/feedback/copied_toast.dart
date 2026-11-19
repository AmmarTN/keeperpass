import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';

/// "30 s", "2 min": the countdown's time.
String shortDuration(Duration duration) => duration.inSeconds < 60
    ? t.settings.seconds(n: duration.inSeconds)
    : t.settings.minutes(n: duration.inMinutes);

/// The copy confirmation (board `Lock-privacy`): "Password copied — From
/// GitHub · Clears in 30 s". It shows for the usual time with no countdown bar
/// (your answer, 2026-11-03: the board kept it up for the whole countdown); the
/// clipboard still clears on time. A copy that stays says only where it came
/// from.
AppToastData copiedToast({
  required String title,
  String? from,
  Duration? clearsIn,
}) {
  final List<String> detail = <String>[
    ?from,
    if (clearsIn != null) t.clipboard.clearsIn(time: shortDuration(clearsIn)),
  ];
  return AppToastData(
    icon: AppIconName.clipboardCheck,
    title: title,
    detail: detail.isEmpty ? null : detail.join(' · '),
  );
}

/// "Clipboard cleared", while KeeperPass is open (your answer, Part 14: the
/// title alone).
AppToastData clipboardClearedToast() =>
    AppToastData(icon: AppIconName.circleCheck, title: t.clipboard.cleared);
