// Card numbers (web `core/validation/card-number.ts`): brand, Luhn, and
// grouping for display.

/// The Luhn check over ASCII digits (at least two).
bool passesLuhn(String digits) {
  if (!RegExp(r'^\d{2,}$').hasMatch(digits)) return false;
  int sum = 0;
  bool double = false;
  for (int i = digits.length - 1; i >= 0; i--) {
    int digit = digits.codeUnitAt(i) - 48;
    if (double) {
      digit *= 2;
      if (digit > 9) digit -= 9;
    }
    sum += digit;
    double = !double;
  }
  return sum % 10 == 0;
}

/// A card network: its id, name, valid lengths and number prefix.
class CardBrand {
  const CardBrand(this.id, this.label, this.lengths, this.pattern);

  final String id;
  final String label;
  final List<int> lengths;
  final String pattern;

  bool matches(String digits) => RegExp(pattern).hasMatch(digits);
}

/// In the web's order: the first match wins.
const List<CardBrand> kCardBrands = <CardBrand>[
  CardBrand('visa', 'Visa', <int>[13, 16, 19], r'^4'),
  CardBrand('mastercard', 'Mastercard', <int>[
    16,
  ], r'^(5[1-5]|222[1-9]|22[3-9]|2[3-6]|27[01]|2720)'),
  CardBrand('amex', 'American Express', <int>[15], r'^3[47]'),
  CardBrand(
    'discover',
    'Discover',
    <int>[16, 19],
    r'^(6011|64[4-9]|65|622(12[6-9]|1[3-9]|[2-8]|9[01]|92[0-5]))',
  ),
  CardBrand('diners', 'Diners Club', <int>[
    14,
    16,
    19,
  ], r'^(30[0-5]|3095|36|3[89])'),
  CardBrand('jcb', 'JCB', <int>[16, 17, 18, 19], r'^35(2[89]|[3-8])'),
  CardBrand('unionpay', 'UnionPay', <int>[14, 15, 16, 17, 18, 19], r'^62'),
  CardBrand('maestro', 'Maestro', <int>[
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
  ], r'^(5018|5020|5038|5893|6304|6759|676[1-3])'),
  CardBrand('mir', 'Mir', <int>[16, 17, 18, 19], r'^220[0-4]'),
  CardBrand(
    'elo',
    'Elo',
    <int>[16],
    r'^(4011(78|79)|43(1274|8935)|45(1416|7393|763[12])|50(4175|6699|67[0-6]|677[0-8]|9[0-8])|627780|63(6297|6368)|650[0-9]|65[1-6]|6516[5-7]|6550[01])',
  ),
  CardBrand('hipercard', 'Hipercard', <int>[16], r'^(606282|3841)'),
  CardBrand('rupay', 'RuPay', <int>[16], r'^(60|65|81|82|508)'),
  CardBrand('troy', 'Troy', <int>[16], r'^9792'),
  CardBrand('uatp', 'UATP', <int>[15], r'^1'),
];

/// What a typed card number is.
typedef CardNumberInfo = ({
  String digits,
  CardBrand? brand,
  bool valid,
  bool complete,
  String formatted,
});

String _group(String digits, String? brandId) {
  final List<int>? sizes = switch (brandId) {
    'amex' => <int>[4, 6, 5],
    'diners' => <int>[4, 6, 4],
    _ => null,
  };
  if (sizes == null) {
    return digits
        .replaceAllMapped(RegExp('(.{4})'), (Match m) => '${m[1]} ')
        .trim();
  }
  final List<String> parts = <String>[];
  int at = 0;
  for (final int size in sizes) {
    if (at >= digits.length) break;
    parts.add(digits.substring(at, (at + size).clamp(0, digits.length)));
    at += size;
  }
  if (at < digits.length) parts.add(digits.substring(at));
  return parts.join(' ');
}

CardNumberInfo inspectCardNumber(String value) {
  final String digits = value.replaceAll(RegExp(r'\D'), '');
  CardBrand? brand;
  for (final CardBrand candidate in kCardBrands) {
    if (candidate.matches(digits)) {
      brand = candidate;
      break;
    }
  }
  final bool complete = brand != null && brand.lengths.contains(digits.length);
  return (
    digits: digits,
    brand: brand,
    complete: complete,
    valid: complete && passesLuhn(digits),
    formatted: _group(digits, brand?.id),
  );
}
