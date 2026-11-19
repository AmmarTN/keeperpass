import 'package:keeperpass/core/enums/auto_lock_delay.dart';
import 'package:keeperpass/core/enums/clipboard_clear_delay.dart';
import 'package:keeperpass/core/utils/generator/generator.dart';
import 'package:keeperpass/core/utils/text/date_formats.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/cubit/language/language_cubit.dart';

/// "After 10 minutes" — the Auto-lock row's value and choice.
String autoLockLabel(AutoLockDelay delay) => switch (delay) {
  AutoLockDelay.immediately => t.settings.autoLockImmediately,
  AutoLockDelay.oneMinute => t.settings.after1Minute,
  AutoLockDelay.fiveMinutes => t.settings.after5Minutes,
  AutoLockDelay.tenMinutes => t.settings.after10Minutes,
};

/// The row's value: "Immediately" is short there.
String autoLockValue(AutoLockDelay delay) => delay == AutoLockDelay.immediately
    ? t.settings.autoLockImmediatelyShort
    : autoLockLabel(delay);

/// "After 30 seconds" — a choice on Clear Clipboard.
String clipboardLabel(ClipboardClearDelay delay) => switch (delay) {
  ClipboardClearDelay.thirtySeconds => t.settings.after30Seconds,
  ClipboardClearDelay.oneMinute => t.settings.after1Minute,
  ClipboardClearDelay.twoMinutes => t.settings.after2Minutes,
  ClipboardClearDelay.never => t.settings.never,
};

/// "After 30 s" — the row's short value (board `S5-13`).
String clipboardValue(ClipboardClearDelay delay) => switch (delay) {
  ClipboardClearDelay.thirtySeconds => t.settings.after30s,
  ClipboardClearDelay.oneMinute => t.settings.after1Min,
  ClipboardClearDelay.twoMinutes => t.settings.after2Min,
  ClipboardClearDelay.never => t.settings.never,
};

/// Each language in its own language (the web's names).
String languageName(LocaleLanguage language) => kGeneratorLanguages
    .firstWhere((({String value, String label}) l) => l.value == language.name)
    .label;

/// "keeperpass folder · saved today at 9:41 AM" (board `S5-24`); the date
/// when it was another day, the folder alone when the time is not known.
String vaultFileLine(String folder, DateTime? savedAt, DateTime now) {
  if (savedAt == null) return folder;
  final String locale = LocaleSettings.currentLocale.languageCode;
  final DateTime local = savedAt.toLocal();
  final DateTime today = now.toLocal();
  if (local.year == today.year &&
      local.month == today.month &&
      local.day == today.day) {
    return t.storage.savedToday(
      folder: folder,
      time: formatShortTime(local, locale),
    );
  }
  return t.storage.savedOn(
    folder: folder,
    date: formatMediumDate(local, locale),
  );
}
