/// The avatar's letters (web `NavUser.initials`): the first letters of the
/// first and last words of the name — or of the address when there is no
/// name — upper-cased; "?" when there is neither.
String initialsOf(String displayName) {
  final String source = displayName.trim();
  if (source.isEmpty) return '?';
  final List<String> words = source
      .split(RegExp(r'\s+'))
      .where((String word) => word.isNotEmpty)
      .toList();
  final List<String> picked = words.length > 1
      ? <String>[words.first, words.last]
      : <String>[words.first];
  return picked.map(_firstLetter).join().toUpperCase();
}

/// The first character; a surrogate pair is kept whole.
String _firstLetter(String word) {
  final int unit = word.codeUnitAt(0);
  final bool pair = unit >= 0xD800 && unit <= 0xDBFF && word.length > 1;
  return word.substring(0, pair ? 2 : 1);
}
