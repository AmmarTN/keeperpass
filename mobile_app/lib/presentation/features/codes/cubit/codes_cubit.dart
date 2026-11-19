import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/usecases/recent/record_recent_item.dart';
import 'package:keeperpass/core/utils/crypto/totp.dart';
import 'package:keeperpass/core/utils/items/item_codes.dart';
import 'package:keeperpass/core/utils/items/item_filter.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/models/general/cubitStatus.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/clipboard_service.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_view.dart';
import 'package:keeperpass/presentation/features/vault_list/widgets/vault_rows.dart';

part 'codes_cubit.freezed.dart';
part 'codes_state.dart';

/// The Codes tab (boards `Codes`, `S4-01` … `S4-06`): every item with a
/// setup key, its live code made on the phone, a search over item names,
/// and copying. Nothing is stored — the codes come from the vault in memory.
@injectable
class CodesCubit extends Cubit<CodesState> {
  CodesCubit(
    this._vault,
    this._recordRecentItem,
    this._clipboard, {
    @ignoreParam this._now = DateTime.now,
  }) : super(const CodesState()) {
    _changes = _vault.changes.listen((_) => _rebuild());
    _rebuild();
  }

  final VaultSessionService _vault;
  final RecordRecentItem _recordRecentItem;
  final ClipboardService _clipboard;
  final DateTime Function() _now;
  late final StreamSubscription<VaultSnapshot?> _changes;

  /// The clock the codes are made with (tests fix it).
  DateTime now() => _now();

  /// The vaults, for "Create an Authenticator item".
  List<Vault> get vaults => _vault.snapshot?.vaults ?? const <Vault>[];

  void setSearch(String search) => emit(state.copyWith(search: search));

  /// Copies the item's current code and records the item as recently used
  /// (Part 7: Recently Used also records copying). Null when its setup key
  /// makes no code.
  Future<Copied?> copy(String itemId) async {
    final CodeEntry? entry = state.entries
        .where((CodeEntry e) => e.itemId == itemId)
        .firstOrNull;
    if (entry == null) return null;
    final String code;
    try {
      code = generateTotp(
        entry.field.value,
        timestampMs: _now().millisecondsSinceEpoch,
      );
    } catch (_) {
      return null;
    }
    final Duration? clearsIn = await _clipboard.copy(code, sensitive: true);
    await _recordRecentItem(itemId);
    return (clearsIn: clearsIn);
  }

  void _rebuild() {
    if (isClosed) return;
    final VaultSnapshot? snapshot = _vault.snapshot;
    if (snapshot == null) {
      emit(state.copyWith(entries: const <CodeEntry>[]));
      return;
    }
    final String locale = LocaleSettings.currentLocale.languageCode;
    final List<VaultItem> items =
        snapshot.items.where((VaultItem i) => codeFieldOf(i) != null).toList()
          ..sort(compareItemsByNameThenAge);
    emit(
      state.copyWith(
        entries: <CodeEntry>[
          for (final VaultItem item in items)
            CodeEntry(
              row: buildVaultRow(
                snapshot: snapshot,
                item: item,
                favourite: false,
                findings: const {},
                locale: locale,
              ),
              field: codeFieldOf(item)!,
            ),
        ],
      ),
    );
  }

  @override
  Future<void> close() async {
    await _changes.cancel();
    return super.close();
  }
}
