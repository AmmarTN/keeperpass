import 'package:flutter/material.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';

typedef BottomNavPageBuilder = Widget Function(BuildContext context);

/// One tab of the shell: its Lucide icon (drawn at stroke 2 when active,
/// 1.75 otherwise — board C4), label, badge count and page.
@immutable
final class BottomNavDestination {
  const BottomNavDestination({
    required this.label,
    required this.icon,
    required this.builder,
    this.badgeCount = 0,
    this.semanticLabel,
  });

  final String label;
  final AppIconName icon;
  final BottomNavPageBuilder builder;

  /// Security's flagged-item count (0 hides the badge).
  final int badgeCount;

  /// "Security, 4 items flagged".
  final String? semanticLabel;
}
