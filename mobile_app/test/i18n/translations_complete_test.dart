import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Every language must be complete, like on the web, where a missing key is a
/// compile error (plan, section 5.6). English is the source; German, Spanish,
/// French and Portuguese must have the same keys, no empty texts and the same
/// placeholders.
const List<String> _languages = <String>['de', 'es', 'fr', 'pt'];

Map<String, String> _flatten(Map<String, dynamic> json, [String prefix = '']) {
  final Map<String, String> flat = <String, String>{};
  json.forEach((String key, dynamic value) {
    final String path = prefix.isEmpty ? key : '$prefix.$key';
    // Slang plural and context maps (`key(plural)`) have per-language
    // categories; only their presence is compared.
    if (value is Map<String, dynamic> && !key.contains('(')) {
      flat.addAll(_flatten(value, path));
    } else {
      flat[path] = value is String ? value : jsonEncode(value);
    }
  });
  return flat;
}

Map<String, String> _load(String language) => _flatten(
  jsonDecode(File('lib/i18n/$language.i18n.json').readAsStringSync())
      as Map<String, dynamic>,
);

Set<String> _placeholders(String text) =>
    RegExp(r'\$\{?(\w+)\}?').allMatches(text).map((Match m) => m[1]!).toSet();

void main() {
  final Map<String, String> english = _load('en');

  for (final String language in _languages) {
    test('$language has every English text, none empty', () {
      final Map<String, String> translated = _load(language);

      expect(
        english.keys.toSet().difference(translated.keys.toSet()),
        isEmpty,
        reason: 'missing in $language',
      );
      expect(
        translated.keys.toSet().difference(english.keys.toSet()),
        isEmpty,
        reason: 'not in English (remove from $language)',
      );
      for (final MapEntry<String, String> e in translated.entries) {
        expect(e.value.trim(), isNotEmpty, reason: '$language ${e.key}');
        expect(
          _placeholders(e.value),
          _placeholders(english[e.key]!),
          reason: '$language ${e.key} placeholders',
        );
      }
    });
  }
}
