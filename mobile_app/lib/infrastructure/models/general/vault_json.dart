import 'package:json_annotation/json_annotation.dart';

/// JSON rules shared by every model in the vault file.
///
/// The vault is written by the web app too, so its dates and its unknown keys
/// have to behave exactly as the web's `JSON.stringify` / `JSON.parse` +
/// `vault.store.ts` revive do.

/// The key under which a model keeps the JSON keys it does not know. Never
/// written to the file: [withUnknownKeys] spreads the map back out.
const String kUnknownJsonKey = r'$unknown';

/// The keys of [json] that are not in [known] — fields written by a newer
/// app that this version must carry through a load → save round trip
/// (plan X9).
Map<String, Object?> unknownJsonKeys(
  Map<String, dynamic> json,
  Iterable<String> known,
) {
  final Set<String> knownKeys = known.toSet();
  return <String, Object?>{
    for (final MapEntry<String, dynamic> entry in json.entries)
      if (!knownKeys.contains(entry.key)) entry.key: entry.value,
  };
}

/// [json] with the [unknown] keys put back; known keys win.
Map<String, dynamic> withUnknownKeys(
  Map<String, Object?> unknown,
  Map<String, dynamic> json,
) => <String, dynamic>{...unknown, ...json};

/// `JSON.stringify(date)`: UTC ISO 8601 with exactly three fraction digits,
/// e.g. `2026-10-30T09:41:12.345Z` (porting trap 5).
String webDateString(DateTime date) {
  final DateTime utc = date.toUtc();
  final DateTime millis = DateTime.fromMillisecondsSinceEpoch(
    utc.millisecondsSinceEpoch,
    isUtc: true,
  );
  return millis.toIso8601String();
}

/// `new Date(value)` as the web revives a stored date: an ISO string or a
/// number of milliseconds. Anything else (or an unparseable string) is null.
DateTime? parseWebDate(Object? value) {
  return switch (value) {
    final String text => DateTime.tryParse(text)?.toUtc(),
    final int millis => DateTime.fromMillisecondsSinceEpoch(
      millis,
      isUtc: true,
    ),
    final double millis when millis.isFinite =>
      DateTime.fromMillisecondsSinceEpoch(millis.truncate(), isUtc: true),
    _ => null,
  };
}

/// A required date. The web's `new Date(missing)` gives the epoch for null;
/// the same here, so a damaged entry still sorts somewhere stable.
class WebDateConverter implements JsonConverter<DateTime, Object?> {
  const WebDateConverter();

  @override
  DateTime fromJson(Object? json) =>
      parseWebDate(json) ?? DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);

  @override
  String toJson(DateTime date) => webDateString(date);
}

/// An optional date: absent stays absent.
class WebDateNullableConverter implements JsonConverter<DateTime?, Object?> {
  const WebDateNullableConverter();

  @override
  DateTime? fromJson(Object? json) => parseWebDate(json);

  @override
  String? toJson(DateTime? date) => date == null ? null : webDateString(date);
}
