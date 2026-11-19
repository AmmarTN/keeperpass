import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/utils/audit/report.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';

VaultItem item(String id, List<String> passwords, {bool extra = false}) =>
    VaultItem(
      id: id,
      vaultId: 'v',
      name: id,
      updated: DateTime.utc(2026),
      fields: <Field>[
        Field.of(name: 'User', type: FieldType.username, value: 'jane'),
        for (final String p in passwords)
          Field.of(name: 'Password', type: FieldType.password, value: p),
        if (extra) Field.of(name: 'PIN', type: FieldType.pin, value: 'same'),
      ],
    );

void main() {
  test('the score as the web: healthy share, rounded as JavaScript', () {
    expect(healthScore(checked: 0, flagged: 0), isNull);
    expect(healthScore(checked: 16, flagged: 4), 75);
    expect(healthScore(checked: 16, flagged: 3), 81);
    // 87.5 rounds up, as Math.round does.
    expect(healthScore(checked: 8, flagged: 1), 88);
    // 62.5 too.
    expect(healthScore(checked: 8, flagged: 3), 63);
    // A deleted item's findings never push it below zero.
    expect(healthScore(checked: 2, flagged: 5), 0);
  });

  test('bands: Strong from 90, Needs work from 60, else At risk', () {
    expect(healthBand(100), HealthBand.good);
    expect(healthBand(90), HealthBand.good);
    expect(healthBand(89), HealthBand.fair);
    expect(healthBand(60), HealthBand.fair);
    expect(healthBand(59), HealthBand.poor);
  });

  test('an item is checked when it holds a Password field, even empty', () {
    expect(holdsPassword(item('a', <String>['x'])), isTrue);
    expect(holdsPassword(item('b', <String>[''])), isTrue);
    expect(holdsPassword(item('c', <String>[], extra: true)), isFalse);
  });

  group('PasswordUse', () {
    final PasswordUse use = PasswordUse(<VaultItem>[
      item('netflix', <String>['weak', 'shared']),
      item('spotify', <String>['other']),
      item('instagram', <String>['shared']),
      item('facebook', <String>['shared', 'breached']),
      item('twice', <String>['mine', 'mine']),
      item('empty', <String>['']),
    ]);

    test('who shares a password with an item, in vault order', () {
      expect(use.sharingWith('facebook'), <String>['netflix', 'instagram']);
      expect(use.sharingWith('netflix'), <String>['instagram', 'facebook']);
      expect(use.sharingWith('spotify'), isEmpty);
      // Reused only between its own fields.
      expect(use.sharingWith('twice'), isEmpty);
      expect(use.sharingWith('empty'), isEmpty);
    });

    test('how many reused passwords a set of items holds', () {
      expect(
        use.reusedPasswords(<String>['netflix', 'instagram', 'facebook']),
        1,
      );
      expect(use.reusedPasswords(<String>['netflix', 'twice']), 2);
      expect(use.reusedPasswords(<String>['spotify']), 0);
    });

    test('whether a value is held by another item', () {
      expect(use.usedOutside('netflix', 'shared'), isTrue);
      expect(use.usedOutside('spotify', 'other'), isFalse);
      expect(use.usedOutside('netflix', 'nobody has this'), isFalse);
    });
  });
}
