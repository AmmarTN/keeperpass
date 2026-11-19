import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/infrastructure/datasources/local_datasources/recent_items_local_data_source.dart';

/// How many ids Recently Used keeps (web `MAX_RECENT_ITEMS`).
const int kMaxRecentItems = 50;

/// Recently Used, most recent first (web `RecentItemsService`): read once,
/// then held in memory and written through on every change.
abstract class IRecentItemsRepository {
  List<String> get ids;

  Stream<List<String>> get changes;

  /// Moves [id] to the front, keeping at most [kMaxRecentItems].
  Future<Either<Failure, Unit>> record(String id);

  /// Drops deleted items.
  Future<Either<Failure, Unit>> forget(Iterable<String> ids);
}

@Singleton(as: IRecentItemsRepository)
class RecentItemsRepositoryImpl implements IRecentItemsRepository {
  final IRecentItemsLocalDataSource _localDataSource;

  RecentItemsRepositoryImpl(this._localDataSource);

  final StreamController<List<String>> _changes =
      StreamController<List<String>>.broadcast();

  List<String>? _ids;

  @override
  List<String> get ids => _ids ??= _load();

  @override
  Stream<List<String>> get changes => _changes.stream;

  @override
  Future<Either<Failure, Unit>> record(String id) => _write(
    <String>[
      id,
      ...ids.where((String existing) => existing != id),
    ].take(kMaxRecentItems).toList(),
  );

  @override
  Future<Either<Failure, Unit>> forget(Iterable<String> ids) async {
    final Set<String> gone = ids.toSet();
    if (!this.ids.any(gone.contains)) return const Right(unit);
    return _write(this.ids.where((String id) => !gone.contains(id)).toList());
  }

  /// A missing or unreadable list is an empty one, as on the web.
  List<String> _load() {
    try {
      final Object? parsed = jsonDecode(
        _localDataSource.readRecentItemIds() ?? '[]',
      );
      return parsed is List ? parsed.whereType<String>().toList() : <String>[];
    } catch (_) {
      return <String>[];
    }
  }

  Future<Either<Failure, Unit>> _write(List<String> next) async {
    _ids = List<String>.unmodifiable(next);
    _changes.add(_ids!);
    try {
      await _localDataSource.writeRecentItemIds(jsonEncode(next));
      return const Right(unit);
    } catch (e) {
      return const Left(Failure.cacheWriteFailure());
    }
  }
}
