import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/utils/items/card_face.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';

VaultItem itemWith(List<Field> fields) => VaultItem(
  id: 'i',
  vaultId: 'v',
  name: 'Card',
  fields: fields,
  updated: DateTime.utc(2026),
);

Field f(String name, FieldType type, String value) =>
    Field.of(name: name, type: type, value: value);

void main() {
  test('an item with a card number gets a face from its fields', () {
    final CardFace? face = cardFaceOf(
      itemWith(<Field>[
        f('Cardholder', FieldType.text, ' Jane Doe '),
        f('Card Number', FieldType.credit, '4111 1111 1111 1111'),
        f('Expires On', FieldType.month, '2029-08'),
        f('Other Card', FieldType.credit, '5555555555554444'),
      ]),
    );
    expect(face, isNotNull);
    expect(face!.brand?.label, 'Visa');
    expect(face.number.formatted, '4111 1111 1111 1111');
    expect(face.holder, 'Jane Doe');
    expect(face.expiry, (year: 2029, month: 8));
  });

  test('missing parts stay blank; no card number, no face', () {
    final CardFace? face = cardFaceOf(
      itemWith(<Field>[
        f('Card Number', FieldType.credit, '0000'),
        f('Expires On', FieldType.month, 'soon'),
      ]),
    );
    expect(face!.brand, isNull);
    expect(face.holder, isNull);
    expect(face.expiry, isNull);
    expect(
      cardFaceOf(itemWith(<Field>[f('PIN', FieldType.pin, '1234')])),
      isNull,
    );
  });
}
