import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/infrastructure/datasources/local_datasources/bundled_data_local_data_source.dart';

/// Serves the real asset files from disk and counts the reads; no caching of
/// its own, so repeated reads show the data source's cache.
final class FakeAssetBundle extends AssetBundle {
  final List<String> reads = <String>[];

  @override
  Future<ByteData> load(String key) async {
    reads.add(key);
    final File file = File(key);
    if (!file.existsSync()) throw StateError('Unable to load asset: "$key".');
    return ByteData.sublistView(file.readAsBytesSync());
  }
}

void main() {
  late FakeAssetBundle bundle;
  late BundledDataLocalDataSourceImpl dataSource;

  setUp(() {
    bundle = FakeAssetBundle();
    dataSource = BundledDataLocalDataSourceImpl(bundle);
  });

  test('word lists load once per language', () async {
    final List<String> german = await dataSource.wordList('de');
    await dataSource.wordList('de');

    expect(german, isNotEmpty);
    expect(bundle.reads, <String>['assets/wordlists/de.json']);
  });

  test(
    'a language without a list falls back to English (web loadWordList)',
    () async {
      final List<String> unknown = await dataSource.wordList('xx');

      expect(unknown, await dataSource.wordList('en'));
      expect(unknown, isNotEmpty);
      expect(bundle.reads, <String>[
        'assets/wordlists/xx.json',
        'assets/wordlists/en.json',
      ]);
    },
  );

  test('locale tables cover the five app languages', () async {
    final Map<String, dynamic> names = await dataSource.countryNames();
    final Map<String, dynamic> relative = await dataSource.relativeTimeTable();
    await dataSource.countryNames();

    expect(names.keys, unorderedEquals(<String>['en', 'de', 'es', 'fr', 'pt']));
    expect(
      relative.keys,
      unorderedEquals(<String>['en', 'de', 'es', 'fr', 'pt']),
    );
    expect(
      bundle.reads.where(
        (String key) => key == 'assets/i18n/country_names.json',
      ),
      hasLength(1),
    );
  });
}
