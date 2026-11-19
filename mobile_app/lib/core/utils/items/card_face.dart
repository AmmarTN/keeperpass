import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/utils/text/field_dates.dart';
import 'package:keeperpass/core/utils/validation/card_number.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';

/// What the card face in an item's header shows (board `S3-29`).
class CardFace {
  const CardFace({required this.number, this.holder, this.expiry});

  /// The brand and the number's groups, from the card number itself.
  final CardNumberInfo number;

  /// The first plain-text field's value; null when there is none.
  final String? holder;
  final ({int year, int month})? expiry;

  CardBrand? get brand => number.brand;
}

/// The card face for an item with a Card Number field (your answer,
/// Part 8): the number from the first one, the holder from the first
/// plain-text field, the expiry from the first Month field; null for an
/// item without a card number.
CardFace? cardFaceOf(VaultItem item) {
  final Field? number = _first(item, FieldType.credit);
  if (number == null) return null;
  final String? holder = _first(item, FieldType.text)?.value.trim();
  final Field? expiry = _first(item, FieldType.month);
  return CardFace(
    number: inspectCardNumber(number.value),
    holder: holder == null || holder.isEmpty ? null : holder,
    expiry: expiry == null ? null : parseFieldMonth(expiry.value),
  );
}

Field? _first(VaultItem item, FieldType type) =>
    item.fields.where((Field f) => f.type == type).firstOrNull;
