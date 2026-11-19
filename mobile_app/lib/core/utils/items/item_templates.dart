import 'package:keeperpass/core/enums/field_type.dart';

/// A template field's name when it is not just its type's ("Cardholder",
/// "IBAN"…); the screen translates it (web `items.templates.fields.*`).
enum TemplateFieldName {
  cardholder,
  expiresOn,
  cvc,
  accountHolder,
  iban,
  bic,
  cardPin,
  networkName,
  fullName,
  passportNumber,
  issuingCountry,
  dateOfBirth,
  placeOfBirth,
  issuedOn,
}

/// A field a new item starts with; a null [name] means its type's own name
/// ("Username", "Password").
class TemplateField {
  const TemplateField(this.type, [this.name]);

  final FieldType type;
  final TemplateFieldName? name;
}

/// One of the kinds of item New Vault Item offers (web `ItemTemplate`): a
/// head start, not a schema — every field can be renamed or removed.
class ItemTemplate {
  const ItemTemplate(this.id, this.icon, this.fields);

  /// Stable slug, never shown.
  final String id;

  /// The web's icon name, stored as the new item's `icon`.
  final String icon;
  final List<TemplateField> fields;
}

/// In the web's order (`ITEM_TEMPLATES`); Custom last and empty.
const List<ItemTemplate> kItemTemplates = <ItemTemplate>[
  ItemTemplate('website', 'web', <TemplateField>[
    TemplateField(FieldType.username),
    TemplateField(FieldType.password),
    TemplateField(FieldType.url),
  ]),
  ItemTemplate('computer', 'computer', <TemplateField>[
    TemplateField(FieldType.username),
    TemplateField(FieldType.password),
  ]),
  ItemTemplate('credit-card', 'credit', <TemplateField>[
    TemplateField(FieldType.credit),
    TemplateField(FieldType.text, TemplateFieldName.cardholder),
    TemplateField(FieldType.month, TemplateFieldName.expiresOn),
    // Two different secrets: the CVC printed on the card, the PIN typed
    // into a terminal.
    TemplateField(FieldType.pin, TemplateFieldName.cvc),
    TemplateField(FieldType.pin),
  ]),
  ItemTemplate('bank-account', 'bank', <TemplateField>[
    TemplateField(FieldType.text, TemplateFieldName.accountHolder),
    TemplateField(FieldType.text, TemplateFieldName.iban),
    TemplateField(FieldType.text, TemplateFieldName.bic),
    TemplateField(FieldType.pin, TemplateFieldName.cardPin),
  ]),
  ItemTemplate('wifi', 'wifi', <TemplateField>[
    TemplateField(FieldType.text, TemplateFieldName.networkName),
    TemplateField(FieldType.password),
  ]),
  ItemTemplate('passport', 'passport', <TemplateField>[
    TemplateField(FieldType.text, TemplateFieldName.fullName),
    TemplateField(FieldType.text, TemplateFieldName.passportNumber),
    TemplateField(FieldType.text, TemplateFieldName.issuingCountry),
    TemplateField(FieldType.date, TemplateFieldName.dateOfBirth),
    TemplateField(FieldType.text, TemplateFieldName.placeOfBirth),
    TemplateField(FieldType.date, TemplateFieldName.issuedOn),
    TemplateField(FieldType.date, TemplateFieldName.expiresOn),
  ]),
  ItemTemplate('note', 'note', <TemplateField>[TemplateField(FieldType.note)]),
  ItemTemplate('authenticator', 'totp', <TemplateField>[
    TemplateField(FieldType.totp),
  ]),
  ItemTemplate('custom', 'custom', <TemplateField>[]),
];
