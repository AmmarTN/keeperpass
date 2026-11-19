import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/enums/clipboard_clear_delay.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/usecases/settings/apply_privacy_settings.dart';
import 'package:keeperpass/core/usecases/settings/get_block_screenshots.dart';
import 'package:keeperpass/core/usecases/settings/get_clipboard_clear_delay.dart';
import 'package:keeperpass/core/usecases/settings/get_hide_in_switcher.dart';
import 'package:keeperpass/core/usecases/settings/save_block_screenshots.dart';
import 'package:keeperpass/core/usecases/settings/save_clipboard_clear_delay.dart';
import 'package:keeperpass/core/usecases/settings/save_hide_in_switcher.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/usecases/vault/get_migration_targets.dart';
import 'package:keeperpass/infrastructure/models/vault/export_record.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/link_service.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

part 'settings_cubit.freezed.dart';
part 'settings_state.dart';

/// The Settings tab (boards `Settings`, `S5-13` … `S5-17`): the choices kept
/// on this phone (clear clipboard, hide in app switcher), where the vault
/// can move, and the vault's export record. Auto-lock, theme and language
/// live in their app-wide cubits.
@injectable
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(
    this._vault,
    this._getClipboardClearDelay,
    this._saveClipboardClearDelay,
    this._getHideInSwitcher,
    this._saveHideInSwitcher,
    this._getBlockScreenshots,
    this._saveBlockScreenshots,
    this._applyPrivacy,
    this._getMigrationTargets,
    this._links, {
    @ignoreParam this.now = DateTime.now,
  }) : super(const SettingsState()) {
    _changes = _vault.changes.listen((_) => _readVault());
    _readVault();
  }

  final VaultSessionService _vault;
  final GetClipboardClearDelay _getClipboardClearDelay;
  final SaveClipboardClearDelay _saveClipboardClearDelay;
  final GetHideInSwitcher _getHideInSwitcher;
  final SaveHideInSwitcher _saveHideInSwitcher;
  final GetBlockScreenshots _getBlockScreenshots;
  final SaveBlockScreenshots _saveBlockScreenshots;
  final ApplyPrivacySettings _applyPrivacy;
  final GetMigrationTargets _getMigrationTargets;
  final LinkService _links;

  /// The clock "saved today at 9:41 AM" is told against.
  final DateTime Function() now;
  late final StreamSubscription<VaultSnapshot?> _changes;

  Future<void> load() async {
    final ClipboardClearDelay delay = (await _getClipboardClearDelay(
      const NoParams(),
    )).getOrElse(() => ClipboardClearDelay.standard);
    final bool hide = (await _getHideInSwitcher(
      const NoParams(),
    )).getOrElse(() => true);
    final bool block = (await _getBlockScreenshots(
      const NoParams(),
    )).getOrElse(() => true);
    if (isClosed) return;
    emit(
      state.copyWith(
        clipboardDelay: delay,
        hideInSwitcher: hide,
        blockScreenshots: block,
        moveTargets: _getMigrationTargets(
          const NoParams(),
        ).getOrElse(() => const <ProviderId>[]),
      ),
    );
  }

  Future<void> setClipboardDelay(ClipboardClearDelay delay) async {
    emit(state.copyWith(clipboardDelay: delay));
    await _saveClipboardClearDelay(delay);
  }

  /// The cover in the app switcher; it also blocks screenshots while on
  /// (the plugin's way, accepted in Part 14).
  Future<void> setHideInSwitcher(bool hide) async {
    emit(state.copyWith(hideInSwitcher: hide));
    await _saveHideInSwitcher(hide);
    await _applyPrivacy(const NoParams());
  }

  /// Android's "Block screenshots" (screen recording too).
  Future<void> setBlockScreenshots(bool block) async {
    emit(state.copyWith(blockScreenshots: block));
    await _saveBlockScreenshots(block);
    await _applyPrivacy(const NoParams());
  }

  /// The storage's access page, an About link, the support address.
  Future<void> openLink(Uri uri) => _links.open(uri);

  void _readVault() {
    if (isClosed) return;
    emit(
      state.copyWith(
        exports: _vault.snapshot?.exportHistory ?? const <ExportRecord>[],
      ),
    );
  }

  @override
  Future<void> close() async {
    await _changes.cancel();
    return super.close();
  }
}
