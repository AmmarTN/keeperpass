import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/rename_dto.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/tags/add_tag.dart';
import 'package:keeperpass/core/usecases/tags/delete_tags.dart';
import 'package:keeperpass/core/usecases/tags/rename_tag.dart';
import 'package:keeperpass/core/utils/items/tag_changes.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:keeperpass/presentation/common/cubit/sync/sync_cubit.dart';

part 'tags_cubit.freezed.dart';
part 'tags_state.dart';

/// Tags (boards `Tags`, `S5-07` … `S5-12`; web `TagsPage`): every tag with
/// its count and date; add, rename and delete — each item changed keeps its
/// earlier version in history. Each change is saved at once.
@injectable
class TagsCubit extends Cubit<TagsState> {
  TagsCubit(
    this._vault,
    this._sync,
    this._addTag,
    this._renameTag,
    this._deleteTags,
  ) : super(const TagsState()) {
    _changes = _vault.changes.listen((_) => _rebuild());
    _rebuild();
  }

  final VaultSessionService _vault;
  final SyncCubit _sync;
  final AddTag _addTag;
  final RenameTag _renameTag;
  final DeleteTags _deleteTags;
  late final StreamSubscription<VaultSnapshot?> _changes;

  void startSelecting() => emit(state.copyWith(selecting: true));

  void cancelSelecting() =>
      emit(state.copyWith(selecting: false, selected: const <String>{}));

  void toggle(String name) {
    final Set<String> next = Set<String>.of(state.selected);
    if (!next.remove(name)) next.add(name);
    emit(state.copyWith(selected: next));
  }

  /// Every tag, or none when they all are (web `toggleSelectAll`).
  void toggleSelectAll() {
    final bool all =
        state.tags.isNotEmpty && state.selected.length == state.tags.length;
    emit(
      state.copyWith(
        selected: all
            ? const <String>{}
            : <String>{for (final TagInfo tag in state.tags) tag.name},
      ),
    );
  }

  Future<bool> add(String name) => _change(() => _addTag(name));

  Future<bool> rename(String oldName, String newName) =>
      _change(() => _renameTag(RenameDto(id: oldName, name: newName)));

  /// Deletes [names] (the selection, or one from its row).
  Future<bool> delete(List<String> names) async {
    final bool done = await _change(() => _deleteTags(names));
    if (done) cancelSelecting();
    return done;
  }

  Future<bool> _change(Either<Failure, Unit> Function() change) async {
    if (!await _sync.checkBeforeEditing()) return false;
    if (change().isLeft()) return false;
    unawaited(_sync.saveNow());
    return true;
  }

  void _rebuild() {
    if (isClosed) return;
    final VaultSnapshot? snapshot = _vault.snapshot;
    final List<TagInfo> tags = snapshot == null
        ? const <TagInfo>[]
        : tagInfos(snapshot);
    final Set<String> names = <String>{for (final TagInfo t in tags) t.name};
    emit(
      state.copyWith(
        tags: tags,
        selected: state.selected.where(names.contains).toSet(),
      ),
    );
  }

  @override
  Future<void> close() async {
    await _changes.cancel();
    return super.close();
  }
}
