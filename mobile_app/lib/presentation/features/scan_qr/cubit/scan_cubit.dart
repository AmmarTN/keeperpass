import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/item_edit_dto.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/items/create_item.dart';
import 'package:keeperpass/core/usecases/items/update_item.dart';
import 'package:keeperpass/core/utils/crypto/otpauth.dart';
import 'package:keeperpass/core/utils/items/item_codes.dart';
import 'package:keeperpass/core/utils/items/item_filter.dart';
import 'package:keeperpass/core/utils/items/item_templates.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/extensions/failures.dart';
import 'package:keeperpass/infrastructure/models/general/cubitStatus.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/camera_permission_service.dart';
import 'package:keeperpass/infrastructure/services/lock_service.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:keeperpass/presentation/common/cubit/audit/audit_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/sync/sync_cubit.dart';
import 'package:keeperpass/presentation/features/edit_item/widgets/edit_labels.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_view.dart';
import 'package:uuid/uuid.dart';

part 'scan_cubit.freezed.dart';
part 'scan_state.dart';

/// Scan a QR code (board `Scan-QR`, `S6-27` … `S6-32`): camera access
/// (primer, scanning, camera off), reading `otpauth://` links by the plan's
/// Part 15 rules, the items the code may join, and saving it — into an
/// existing item as an edit, or as a new Authenticator item.
@injectable
class ScanCubit extends Cubit<ScanState> {
  ScanCubit(
    this._vault,
    this._sync,
    this._audit,
    this._createItem,
    this._updateItem,
    this._camera,
    this._lock, {
    @ignoreParam this._now = DateTime.now,
  }) : super(const ScanState());

  final VaultSessionService _vault;
  final SyncCubit _sync;
  final AuditCubit _audit;
  final CreateItem _createItem;
  final UpdateItem _updateItem;
  final CameraPermissionService _camera;
  final LockService _lock;
  final DateTime Function() _now;

  /// How long the same QR code is not read again after it was refused or
  /// "Code Found" was closed: while it stays in the frame, it would come
  /// straight back.
  static const Duration rereadAfter = Duration(seconds: 3);

  String? _lastRead;
  DateTime? _lastReadAt;

  /// The clock the live code is made with (tests fix it).
  DateTime now() => _now();

  /// Where the screen starts: the primer only while the phone can still
  /// ask (plan, Part 15 rule 11).
  void open(CameraAccess access) =>
      emit(state.copyWith(step: _stepFor(access)));

  /// The primer's Continue: the system prompt, then the camera or "Camera
  /// access is off".
  Future<void> allowCamera() async {
    final CameraAccess access = await _lock.duringExternalUi(_camera.request);
    if (isClosed) return;
    emit(
      state.copyWith(
        step: access == CameraAccess.allowed
            ? ScanStep.scanning
            : ScanStep.cameraOff,
      ),
    );
  }

  /// "Open Settings": KeeperPass's page there.
  Future<void> openSettings() => _camera.openSettings();

  /// Back from Settings: scanning starts once the camera is allowed.
  Future<void> recheck() async {
    if (state.step != ScanStep.cameraOff) return;
    final CameraAccess access = await _camera.status();
    if (isClosed || access != CameraAccess.allowed) return;
    emit(state.copyWith(step: ScanStep.scanning));
  }

  /// The camera refused to run without access (it was turned off while
  /// scanning).
  void cameraRefused() => emit(state.copyWith(step: ScanStep.cameraOff));

  /// The camera could not start.
  void cameraFailed() => _notify(ScanNotice.cameraFailed);

  /// A QR code the camera read. Nothing while "Code Found" is up or a
  /// code is being saved, nor the same one again right away.
  void read(String raw) {
    if (state.step != ScanStep.scanning ||
        state.found != null ||
        state.saving) {
      return;
    }
    final DateTime at = _now();
    final DateTime? lastAt = _lastReadAt;
    if (raw == _lastRead &&
        lastAt != null &&
        at.difference(lastAt) < rereadAfter) {
      return;
    }
    _lastRead = raw;
    _lastReadAt = at;

    switch (readOtpauth(raw)) {
      case OtpauthRefused(:final OtpauthProblem problem):
        _notify(switch (problem) {
          OtpauthProblem.notACode => ScanNotice.notACode,
          OtpauthProblem.unsupported => ScanNotice.unsupported,
          OtpauthProblem.invalidKey => ScanNotice.invalidKey,
        });
      case final OtpauthCode code:
        final List<VaultRow> matches = _rows(
          itemsNamed(_items, code.issuer ?? ''),
        );
        emit(
          state.copyWith(
            found: code,
            matches: matches,
            targetId: matches.firstOrNull?.id,
            status: const CubitStatus(),
          ),
        );
    }
  }

  /// "Code Found" closed: scanning goes on.
  void closeFound() {
    _lastReadAt = _now();
    emit(state.copyWith(found: null, matches: const <VaultRow>[]));
  }

  /// "Save it to": an item of [ScanState.matches], or null for a new
  /// Authenticator item.
  void choose(String? itemId) => emit(state.copyWith(targetId: itemId));

  /// Every item, A to Z: the typed key's "Item" choice (your answer, Part
  /// 15).
  List<VaultRow> allItems() => _rows(_items);

  /// "Save code" on "Code Found": into the chosen item, or a new
  /// Authenticator item named after the site.
  Future<CodeAdded?> save() async {
    final OtpauthCode? code = state.found;
    if (code == null) return null;
    return _save(code.secret, itemId: state.targetId, code: code);
  }

  /// "Save code" on "Enter Setup Key" with an existing item chosen.
  Future<CodeAdded?> saveTyped(String key, {required String itemId}) =>
      _save(key.trim(), itemId: itemId);

  // ---- Internals

  List<VaultItem> get _items => _vault.snapshot?.items ?? const <VaultItem>[];

  ScanStep _stepFor(CameraAccess access) => switch (access) {
    CameraAccess.allowed => ScanStep.scanning,
    CameraAccess.askable => ScanStep.primer,
    CameraAccess.refused => ScanStep.cameraOff,
  };

  void _notify(ScanNotice notice) =>
      emit(state.copyWith(notice: notice, notices: state.notices + 1));

  List<VaultRow> _rows(Iterable<VaultItem> items) {
    final VaultSnapshot? snapshot = _vault.snapshot;
    if (snapshot == null) return const <VaultRow>[];
    final String locale = LocaleSettings.currentLocale.languageCode;
    return <VaultRow>[
      for (final VaultItem item
          in items.toList()..sort(compareItemsByNameThenAge))
        buildVaultRow(
          snapshot: snapshot,
          item: item,
          favourite: false,
          findings: const {},
          locale: locale,
        ),
    ];
  }

  /// Saves [key] like an edit: the newer-version check first, then the
  /// item written, its audit, and the vault saved (plan, Part 15 rules 6
  /// and 7).
  Future<CodeAdded?> _save(
    String key, {
    String? itemId,
    OtpauthCode? code,
  }) async {
    if (state.saving) return null;
    emit(state.copyWith(status: _status(CubitStatusType.loading)));
    if (!await _sync.checkBeforeEditing()) {
      if (!isClosed) emit(state.copyWith(status: const CubitStatus()));
      return null;
    }
    final VaultSnapshot? snapshot = _vault.snapshot;
    final Either<Failure, CodeAdded> written = switch (itemId) {
      _ when snapshot == null => const Left(Failure.vaultLocked()),
      final String id => _addToItem(snapshot, id, key),
      null when code != null => _newItem(snapshot, key, code),
      null => const Left(Failure.unableToProcess('No item')),
    };
    return written.fold(
      (Failure failure) {
        if (!isClosed) {
          emit(
            state.copyWith(
              status: _status(
                CubitStatusType.failure,
                error: failure.getMessage(),
              ),
            ),
          );
        }
        return null;
      },
      (CodeAdded added) {
        unawaited(_audit.runAuditForItem(added.itemId));
        unawaited(_sync.saveNow());
        if (!isClosed) {
          emit(state.copyWith(status: _status(CubitStatusType.success)));
        }
        return added;
      },
    );
  }

  Either<Failure, CodeAdded> _addToItem(
    VaultSnapshot snapshot,
    String itemId,
    String key,
  ) {
    final VaultItem? item = snapshot.items
        .where((VaultItem i) => i.id == itemId)
        .firstOrNull;
    if (item == null) {
      return const Left(Failure.unableToProcess('No such item'));
    }
    return _updateItem(
      ItemEditDto(
        itemId: item.id,
        name: item.name,
        fields: withSetupKey(
          item.fields,
          key,
          name: fieldTypeLabel(FieldType.totp),
        ),
        tags: item.tags,
        iconGlyph: item.iconGlyph,
      ),
    ).map(
      (_) => CodeAdded(
        itemId: item.id,
        name: item.name.isEmpty ? t.vaultList.unnamed : item.name,
      ),
    );
  }

  /// An Authenticator item in your own vault, named after the site (else
  /// the account, else "Authenticator"), with the account as its username
  /// (your answer, Part 15).
  Either<Failure, CodeAdded> _newItem(
    VaultSnapshot snapshot,
    String key,
    OtpauthCode code,
  ) {
    final List<Vault> vaults = snapshot.vaults;
    if (vaults.isEmpty) return const Left(Failure.unableToProcess('No vault'));
    final String vaultId = vaults
        .firstWhere(
          (Vault v) => v.id == kPersonalVaultId,
          orElse: () => vaults.first,
        )
        .id;
    final ItemTemplate template = kItemTemplates.firstWhere(
      (ItemTemplate t) => t.id == 'authenticator',
    );
    final String name = newItemName(code);
    final String? account = code.account;
    return _createItem(
      ItemEditDto(
        itemId: const Uuid().v4(),
        name: name,
        fields: <Field>[
          Field.of(
            name: fieldTypeLabel(FieldType.totp),
            type: FieldType.totp,
            value: key,
          ),
          if (account != null)
            Field.of(
              name: fieldTypeLabel(FieldType.username),
              type: FieldType.username,
              value: account,
            ),
        ],
        tags: const <String>[],
        vaultId: vaultId,
        icon: template.icon,
      ),
    ).map((VaultItem item) => CodeAdded(itemId: item.id, name: name));
  }

  CubitStatus _status(CubitStatusType type, {String? error}) => CubitStatus(
    action: CubitAction.saveCode,
    statusType: type,
    errorMsg: error,
  );
}

/// The name a new Authenticator item gets from [code] (plan, Part 15 rule
/// 7): the site, else the account, else "Authenticator".
String newItemName(OtpauthCode code) =>
    code.issuer ?? code.account ?? t.editItem.templates.authenticator;
