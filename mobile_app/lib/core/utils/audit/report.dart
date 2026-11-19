import 'dart:math' as math;

import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/utils/crypto/sha1.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';

/// Score bands of the health card (web `HealthTone`): the band says in
/// words what the bar's colour says.
enum HealthBand { good, fair, poor }

/// From 90 the vault is "Strong"; from 60 it "Needs work"; below, "At
/// risk" (web `HEALTH_GOOD_FROM`, `HEALTH_FAIR_FROM`).
const int kHealthGoodFrom = 90;
const int kHealthFairFrom = 60;

/// At most this many items per finding card (web `MAX_VISIBLE_PER_SECTION`).
const int kReportRowsPerCard = 5;

/// Whether the audit looks at [item]: it holds a Password field, filled or
/// not (web `checkedItemCount`).
bool holdsPassword(VaultItem item) =>
    item.fields.any((Field field) => field.type == FieldType.password);

/// The share of checked items with no finding, in whole percent; null with
/// nothing to check (web `healthScore`, rounded as JavaScript does).
int? healthScore({required int checked, required int flagged}) {
  if (checked == 0) return null;
  final int healthy = math.max(0, checked - flagged);
  return (healthy / checked * 100 + 0.5).floor();
}

HealthBand healthBand(int score) {
  if (score >= kHealthGoodFrom) return HealthBand.good;
  return score >= kHealthFairFrom ? HealthBand.fair : HealthBand.poor;
}

/// Password hashes and where they are used, as the audit counts them: every
/// filled Password field of [items].
class PasswordUse {
  PasswordUse(List<VaultItem> items) {
    for (final VaultItem item in items) {
      final List<String> hashes = <String>[
        for (final Field field in item.fields)
          if (field.type == FieldType.password && field.value.isNotEmpty)
            sha1Hex(field.value),
      ];
      _byItem[item.id] = hashes;
      for (final String hash in hashes) {
        _fields[hash] = (_fields[hash] ?? 0) + 1;
        (_items[hash] ??= <String>[]).add(item.id);
      }
    }
  }

  final Map<String, List<String>> _byItem = <String, List<String>>{};
  final Map<String, int> _fields = <String, int>{};
  final Map<String, List<String>> _items = <String, List<String>>{};

  /// The other items holding one of [itemId]'s passwords, in vault order,
  /// each once.
  List<String> sharingWith(String itemId) {
    final Set<String> others = <String>{
      for (final String hash in _byItem[itemId] ?? const <String>[])
        for (final String other in _items[hash]!)
          if (other != itemId) other,
    };
    return <String>[
      for (final String id in _byItem.keys)
        if (others.contains(id)) id,
    ];
  }

  /// How many different reused passwords [itemIds] hold between them: one
  /// means they all share a single password.
  int reusedPasswords(Iterable<String> itemIds) => <String>{
    for (final String id in itemIds)
      for (final String hash in _byItem[id] ?? const <String>[])
        if (_fields[hash]! > 1) hash,
  }.length;

  /// Whether [value] is a password held by a field other than the ones
  /// [itemId] holds now (Edit: would saving it still be reuse).
  bool usedOutside(String itemId, String value) =>
      _items[sha1Hex(value)]?.any((String id) => id != itemId) ?? false;
}
