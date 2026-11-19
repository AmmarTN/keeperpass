import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/utils/items/item_icon.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';

VaultItem itemWith(
  List<FieldType> types, {
  String? icon,
  String url = 'https://www.github.com/login',
}) => VaultItem(
  id: 'i',
  vaultId: 'v',
  name: 'Item',
  icon: icon,
  updated: DateTime.utc(2026),
  fields: <Field>[
    for (final FieldType type in types)
      Field.of(
        name: type.value,
        type: type,
        value: type == FieldType.url ? url : 'x',
      ),
  ],
);

void main() {
  group('favicons (web itemFaviconUrls)', () {
    test('the host and each parent domain, DuckDuckGo then Google', () {
      expect(itemFaviconUrls(itemWith(<FieldType>[FieldType.url])), <String>[
        'https://icons.duckduckgo.com/ip3/www.github.com.ico',
        'https://icons.duckduckgo.com/ip3/github.com.ico',
        'https://www.google.com/s2/favicons?sz=64&domain=www.github.com',
        'https://www.google.com/s2/favicons?sz=64&domain=github.com',
      ]);
    });

    test('without a scheme the value is the host; wildcards drop', () {
      expect(
        itemFaviconUrls(
          itemWith(<FieldType>[FieldType.url], url: 'paypal.com/signin'),
        ).first,
        'https://icons.duckduckgo.com/ip3/paypal.com.ico',
      );
      expect(
        itemFaviconUrls(
          itemWith(<FieldType>[FieldType.url], url: '*.example.org'),
        ).first,
        'https://icons.duckduckgo.com/ip3/example.org.ico',
      );
    });

    test('no website, no favicon', () {
      expect(
        itemFaviconUrls(itemWith(<FieldType>[FieldType.username])),
        isEmpty,
      );
    });
  });

  test('the glyph, as the web infers it', () {
    expect(itemIconName(itemWith(<FieldType>[], icon: 'wifi')), 'wifi');
    expect(itemIconName(itemWith(<FieldType>[FieldType.url])), 'web');
    expect(itemIconName(itemWith(<FieldType>[FieldType.credit])), 'credit');
    expect(
      itemIconName(
        itemWith(<FieldType>[FieldType.username, FieldType.password]),
      ),
      'login',
    );
    expect(
      itemIconName(itemWith(<FieldType>[FieldType.email, FieldType.password])),
      'email',
    );
    expect(itemIconName(itemWith(<FieldType>[FieldType.pin])), 'lock');
    expect(itemIconName(itemWith(<FieldType>[FieldType.note])), 'note');
  });
}
