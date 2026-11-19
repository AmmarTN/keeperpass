import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/utils/items/field_editing.dart';
import 'package:keeperpass/core/utils/items/item_templates.dart';
import 'package:keeperpass/core/utils/items/tag_choices.dart';

void main() {
  test('nine templates in the web\'s order, Custom last and empty', () {
    expect(kItemTemplates.map((ItemTemplate t) => t.id), <String>[
      'website',
      'computer',
      'credit-card',
      'bank-account',
      'wifi',
      'passport',
      'note',
      'authenticator',
      'custom',
    ]);
    final ItemTemplate card = kItemTemplates[2];
    expect(card.icon, 'credit');
    expect(card.fields.map((TemplateField f) => f.type), <FieldType>[
      FieldType.credit,
      FieldType.text,
      FieldType.month,
      FieldType.pin,
      FieldType.pin,
    ]);
    expect(card.fields[3].name, TemplateFieldName.cvc);
    expect(card.fields[4].name, isNull);
    expect(kItemTemplates.last.fields, isEmpty);
  });

  group('validation (web fieldValueValidators)', () {
    test('passwords, PINs and cards: only the length', () {
      expect(fieldValueValid(FieldType.password, 'a\nb\u202e'), isTrue);
      expect(
        fieldValueValid(
          FieldType.password,
          'x' * (InputLimitsForTest.value + 1),
        ),
        isFalse,
      );
    });

    test('long text: line breaks yes, hidden controls no, bigger cap', () {
      expect(fieldValueValid(FieldType.note, 'a\nb'), isTrue);
      expect(fieldValueValid(FieldType.note, 'a\u202eb'), isFalse);
      expect(
        fieldValueValid(FieldType.note, 'x' * (InputLimitsForTest.value + 1)),
        isTrue,
      );
    });

    test('everything else: one safe line', () {
      expect(fieldValueValid(FieldType.username, 'jane'), isTrue);
      expect(fieldValueValid(FieldType.username, 'ja\nne'), isFalse);
      expect(fieldValueValid(FieldType.url, 'a\u200bb'), isFalse);
    });

    test('names', () {
      expect(itemNameValid(''), isFalse);
      expect(itemNameValid('GitHub'), isTrue);
      expect(itemNameValid('Git\nHub'), isFalse);
      expect(fieldNameValid(''), isTrue);
      expect(tagNameValid('x' * 100), isTrue);
      expect(tagNameValid('x' * 101), isFalse);
    });
  });

  group('tag choices (web tag combobox)', () {
    const List<String> known = <String>['work', 'dev', 'Travel', 'personal'];

    test('the vault\'s tags not on the item, folded match', () {
      final ({List<String> existing, String? create}) c = tagChoices(
        known: known,
        onItem: <String>['dev'],
        typed: 'E',
      );
      expect(c.existing, <String>['Travel', 'personal']);
      expect(c.create, 'E');
    });

    test('no "Create" for a known name (any case) or one too long', () {
      expect(
        tagChoices(
          known: known,
          onItem: const <String>[],
          typed: 'travel',
        ).create,
        isNull,
      );
      expect(
        tagChoices(
          known: known,
          onItem: const <String>[],
          typed: 'x' * 101,
        ).create,
        isNull,
      );
      expect(
        tagChoices(known: known, onItem: const <String>[], typed: '  ').create,
        isNull,
      );
    });
  });
}

/// The web's 10 000-character cap for one-line values.
abstract final class InputLimitsForTest {
  static const int value = 10000;
}
