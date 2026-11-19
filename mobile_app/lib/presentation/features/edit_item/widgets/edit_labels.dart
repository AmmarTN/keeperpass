import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/utils/items/item_templates.dart';
import 'package:keeperpass/i18n/strings.g.dart';

/// What the Add Field sheet calls a type, and a new field's first name
/// (web `FieldDefinition.labelKey`).
String fieldTypeLabel(FieldType type) => switch (type) {
  FieldType.username => t.editItem.types.username,
  FieldType.password => t.editItem.types.password,
  FieldType.email => t.editItem.types.email,
  FieldType.url => t.editItem.types.url,
  FieldType.ipHost => t.editItem.types.ipHost,
  FieldType.date => t.editItem.types.date,
  FieldType.month => t.editItem.types.month,
  FieldType.credit => t.editItem.types.credit,
  FieldType.phone => t.editItem.types.phone,
  FieldType.pin => t.editItem.types.pin,
  FieldType.totp => t.editItem.types.totp,
  FieldType.certificate => t.editItem.types.certificate,
  FieldType.sshKey => t.editItem.types.sshKey,
  FieldType.recoveryCodes => t.editItem.types.recoveryCodes,
  FieldType.note => t.editItem.types.note,
  FieldType.text => t.editItem.types.text,
};

/// A template's name (web `items.templates.*`).
String templateLabel(ItemTemplate template) => switch (template.id) {
  'website' => t.editItem.templates.website,
  'computer' => t.editItem.templates.computer,
  'credit-card' => t.editItem.templates.creditCard,
  'bank-account' => t.editItem.templates.bankAccount,
  'wifi' => t.editItem.templates.wifi,
  'passport' => t.editItem.templates.passport,
  'note' => t.editItem.templates.note,
  'authenticator' => t.editItem.templates.authenticator,
  _ => t.editItem.templates.custom,
};

/// What a template starts with (board `S3-37`).
String templateHint(ItemTemplate template) => switch (template.id) {
  'website' => t.editItem.templateHints.website,
  'computer' => t.editItem.templateHints.computer,
  'credit-card' => t.editItem.templateHints.creditCard,
  'bank-account' => t.editItem.templateHints.bankAccount,
  'wifi' => t.editItem.templateHints.wifi,
  'passport' => t.editItem.templateHints.passport,
  'note' => t.editItem.templateHints.note,
  'authenticator' => t.editItem.templateHints.authenticator,
  _ => t.editItem.templateHints.custom,
};

/// A template field's first name, in the app language.
String templateFieldName(TemplateField field) => switch (field.name) {
  null => fieldTypeLabel(field.type),
  TemplateFieldName.cardholder => t.editItem.templateFields.cardholder,
  TemplateFieldName.expiresOn => t.editItem.templateFields.expiresOn,
  TemplateFieldName.cvc => t.editItem.templateFields.cvc,
  TemplateFieldName.accountHolder => t.editItem.templateFields.accountHolder,
  TemplateFieldName.iban => t.editItem.templateFields.iban,
  TemplateFieldName.bic => t.editItem.templateFields.bic,
  TemplateFieldName.cardPin => t.editItem.templateFields.cardPin,
  TemplateFieldName.networkName => t.editItem.templateFields.networkName,
  TemplateFieldName.fullName => t.editItem.templateFields.fullName,
  TemplateFieldName.passportNumber => t.editItem.templateFields.passportNumber,
  TemplateFieldName.issuingCountry => t.editItem.templateFields.issuingCountry,
  TemplateFieldName.dateOfBirth => t.editItem.templateFields.dateOfBirth,
  TemplateFieldName.placeOfBirth => t.editItem.templateFields.placeOfBirth,
  TemplateFieldName.issuedOn => t.editItem.templateFields.issuedOn,
};
