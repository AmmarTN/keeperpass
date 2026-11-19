import 'package:flutter/widgets.dart';
import 'package:keeperpass/presentation/common/theme/app_fixed_colors.dart';

/// [text] with every occurrence of each of [words] marked (board
/// `U3-Vault-home` 02: search "highlights it"). Matching ignores case, as
/// the search does (web `matchesSearch`); overlapping matches merge.
InlineSpan highlightedSpan(String text, List<String> words) {
  if (words.isEmpty || text.isEmpty) return TextSpan(text: text);
  final String lower = text.toLowerCase();
  final List<bool> marked = List<bool>.filled(text.length, false);
  for (final String word in words) {
    if (word.isEmpty || lower.length != text.length) continue;
    int start = lower.indexOf(word);
    while (start >= 0) {
      marked.fillRange(start, start + word.length, true);
      start = lower.indexOf(word, start + 1);
    }
  }
  final List<InlineSpan> spans = <InlineSpan>[];
  int runStart = 0;
  for (int i = 1; i <= text.length; i++) {
    if (i == text.length || marked[i] != marked[runStart]) {
      final String run = text.substring(runStart, i);
      spans.add(
        marked[runStart]
            ? TextSpan(
                text: run,
                style: const TextStyle(
                  backgroundColor: AppFixedColors.searchMark,
                ),
              )
            : TextSpan(text: run),
      );
      runStart = i;
    }
  }
  return TextSpan(children: spans);
}

/// The search words as the search reads them (web `matchesSearch`).
List<String> searchWords(String search) => search
    .toLowerCase()
    .split(RegExp(r'\s+'))
    .where((String word) => word.isNotEmpty)
    .toList();
