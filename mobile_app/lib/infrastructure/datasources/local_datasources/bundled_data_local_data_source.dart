import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

/// Data bundled with the app: the generator's word lists (copied from the
/// web's `public/wordlists`) and the locale tables generated from Node's
/// `Intl` (open item O7).
abstract class IBundledDataLocalDataSource {
  /// The passphrase words for [language]; English when the language has no
  /// list (web `loadWordList`).
  Future<List<String>> wordList(String language);

  /// Country names per app language (`assets/i18n/country_names.json`).
  Future<Map<String, dynamic>> countryNames();

  /// Relative-time texts per app language (`assets/i18n/relative_time.json`).
  Future<Map<String, dynamic>> relativeTimeTable();

  /// The icon picker's catalogue (web `icon-catalog.ts`).
  Future<Map<String, dynamic>> iconCatalog();
}

@Singleton(as: IBundledDataLocalDataSource)
class BundledDataLocalDataSourceImpl implements IBundledDataLocalDataSource {
  BundledDataLocalDataSourceImpl(this._bundle);

  final AssetBundle _bundle;
  final Map<String, Future<List<String>>> _wordLists =
      <String, Future<List<String>>>{};
  Future<Map<String, dynamic>>? _countryNames;
  Future<Map<String, dynamic>>? _relativeTime;
  Future<Map<String, dynamic>>? _iconCatalog;

  @override
  Future<List<String>> wordList(String language) {
    return _wordLists[language] ??= _loadWordList(language);
  }

  Future<List<String>> _loadWordList(String language) async {
    List<String> words;
    try {
      final Object? json = jsonDecode(
        await _bundle.loadString('assets/wordlists/$language.json'),
      );
      words = (json! as List<dynamic>).cast<String>();
    } on Object {
      words = const <String>[];
    }
    return words.isNotEmpty || language == 'en' ? words : wordList('en');
  }

  @override
  Future<Map<String, dynamic>> countryNames() =>
      _countryNames ??= _loadJson('assets/i18n/country_names.json');

  @override
  Future<Map<String, dynamic>> relativeTimeTable() =>
      _relativeTime ??= _loadJson('assets/i18n/relative_time.json');

  @override
  Future<Map<String, dynamic>> iconCatalog() =>
      _iconCatalog ??= _loadJson('assets/i18n/icon_catalog.json');

  Future<Map<String, dynamic>> _loadJson(String path) async =>
      jsonDecode(await _bundle.loadString(path)) as Map<String, dynamic>;
}
