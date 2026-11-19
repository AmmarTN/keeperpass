import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/infrastructure/datasources/local_datasources/recent_items_local_data_source.dart';
import 'package:keeperpass/infrastructure/repositories/recent_items_repository_impl.dart';

class MemoryRecentItems implements IRecentItemsLocalDataSource {
  MemoryRecentItems([this.stored]);

  String? stored;

  @override
  String? readRecentItemIds() => stored;

  @override
  Future<void> writeRecentItemIds(String json) async => stored = json;
}

void main() {
  test(
    'most recent first, no repeats, at most 50 (web RecentItemsService)',
    () async {
      final MemoryRecentItems local = MemoryRecentItems();
      final RecentItemsRepositoryImpl recent = RecentItemsRepositoryImpl(local);
      await recent.record('a');
      await recent.record('b');
      await recent.record('a');
      expect(recent.ids, <String>['a', 'b']);
      expect(local.stored, '["a","b"]');

      for (int i = 0; i < 60; i++) {
        await recent.record('x$i');
      }
      expect(recent.ids, hasLength(kMaxRecentItems));
      expect(recent.ids.first, 'x59');
    },
  );

  test('deleted items are forgotten', () async {
    final RecentItemsRepositoryImpl recent = RecentItemsRepositoryImpl(
      MemoryRecentItems('["a","b","c"]'),
    );
    final List<List<String>> changes = <List<String>>[];
    recent.changes.listen(changes.add);
    await recent.forget(<String>['b', 'z']);
    expect(recent.ids, <String>['a', 'c']);
    await recent.forget(<String>['z']);
    await Future<void>.delayed(Duration.zero);
    expect(changes, hasLength(1));
  });

  test('a missing or damaged list is empty', () {
    expect(RecentItemsRepositoryImpl(MemoryRecentItems()).ids, isEmpty);
    expect(RecentItemsRepositoryImpl(MemoryRecentItems('{oops')).ids, isEmpty);
    expect(
      RecentItemsRepositoryImpl(MemoryRecentItems('["a",3,null]')).ids,
      <String>['a'],
    );
  });
}
