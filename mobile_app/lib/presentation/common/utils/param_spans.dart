import 'package:flutter/widgets.dart';

/// A translated sentence whose parameters look different from the rest (a
/// file name in Space Mono, a button's name in bold). [build] gets one
/// marker per value; each marker becomes that value's span, wherever the
/// language puts it.
List<InlineSpan> spansWithParams(
  String Function(List<String> markers) build,
  List<InlineSpan> values,
) {
  final List<String> markers = <String>[
    for (int i = 0; i < values.length; i++) String.fromCharCode(0xE000 + i),
  ];
  final String text = build(markers);
  final List<InlineSpan> spans = <InlineSpan>[];
  final StringBuffer plain = StringBuffer();
  for (final int unit in text.codeUnits) {
    final int index = unit - 0xE000;
    if (index >= 0 && index < values.length) {
      if (plain.isNotEmpty) spans.add(TextSpan(text: plain.toString()));
      plain.clear();
      spans.add(values[index]);
    } else {
      plain.writeCharCode(unit);
    }
  }
  if (plain.isNotEmpty) spans.add(TextSpan(text: plain.toString()));
  return spans;
}
