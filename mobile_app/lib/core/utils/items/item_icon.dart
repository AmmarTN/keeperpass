import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';

/// Favicon services, tried in order (web `item-favicon-url.ts`).
const String _duckDuckGoProxy = 'https://icons.duckduckgo.com/ip3';
const String _googleProxy = 'https://www.google.com/s2/favicons?sz=64&domain=';

/// Where the item's favicon may be found: the first Website field's host and
/// each parent domain, on DuckDuckGo then Google (web `itemFaviconUrls`).
/// Empty when the item has no Website field.
List<String> itemFaviconUrls(VaultItem item) {
  String? url;
  for (final Field field in item.fields) {
    if (field.type == FieldType.url) {
      url = field.value;
      break;
    }
  }
  if (url == null || url.isEmpty) return const <String>[];
  final List<String> hosts = _hostnameCandidates(_hostnameFrom(url));
  return <String>[
    for (final String host in hosts) '$_duckDuckGoProxy/$host.ico',
    for (final String host in hosts) '$_googleProxy$host',
  ];
}

/// The web icon name an item's tile shows when it has no favicon and no
/// picked glyph (web `itemIconName`): its own icon, else one inferred from
/// its field types.
String itemIconName(VaultItem item) {
  final String? icon = item.icon;
  if (icon != null && icon.isNotEmpty) return icon;
  final Set<FieldType> types = <FieldType>{
    for (final Field field in item.fields) field.type,
  };
  if (types.contains(FieldType.url)) return 'web';
  if (types.contains(FieldType.credit)) return 'credit';
  if (types.contains(FieldType.username) &&
      types.contains(FieldType.password)) {
    return 'login';
  }
  if (types.contains(FieldType.email) && types.contains(FieldType.password)) {
    return 'email';
  }
  if (types.contains(FieldType.password) || types.contains(FieldType.pin)) {
    return 'lock';
  }
  return 'note';
}

List<String> _hostnameCandidates(String hostname) {
  if (hostname.isEmpty) return const <String>[];
  final List<String> labels = hostname.split('.');
  return <String>[
    hostname,
    for (int i = 1; i <= labels.length - 2; i++) labels.sublist(i).join('.'),
  ];
}

String _hostnameFrom(String url) {
  final String host = _parseHostname(url);
  return host.startsWith('*.') ? host.substring(2) : host;
}

/// `new URL(url).hostname`, or — without a scheme — what was given, up to
/// the first `/`, `?` or `#`.
String _parseHostname(String url) {
  final Uri? uri = Uri.tryParse(url);
  if (uri != null && uri.hasScheme && uri.scheme.isNotEmpty) {
    return uri.host.toLowerCase();
  }
  return url.trim().split(RegExp('[/?#]')).first;
}
