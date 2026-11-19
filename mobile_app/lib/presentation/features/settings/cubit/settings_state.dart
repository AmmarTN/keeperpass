part of 'settings_cubit.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(ClipboardClearDelay.standard) ClipboardClearDelay clipboardDelay,
    @Default(true) bool hideInSwitcher,

    /// Android only; while hiding is on, screenshots are blocked anyway.
    @Default(true) bool blockScreenshots,

    /// Where the vault could move: configured here, not the one in use.
    @Default(<ProviderId>[]) List<ProviderId> moveTargets,

    /// Exports remembered in the vault (newest first, at most 10).
    @Default(<ExportRecord>[]) List<ExportRecord> exports,
  }) = _SettingsState;
}
