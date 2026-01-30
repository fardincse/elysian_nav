import 'package:flutter/material.dart';

/// Represents a single navigation item in [ElysianNav].
///
/// Each item can have an [icon], an optional [activeIcon] when selected,
/// a [label] for text, a [tooltip] for accessibility, and a custom
/// [backgroundColor].
class ElysianNavItem {
  /// The default icon to display.
  final Widget icon;

  /// The icon to display when the item is active.
  final Widget? activeIcon;

  /// The text label for the item.
  final String? label;

  /// Tooltip text shown on long press.
  final String? tooltip;

  /// Background color for this specific item.
  final Color? backgroundColor;

  /// Creates an [ElysianNavItem].
  ///
  /// The [icon] is required, while other properties are optional.
  ElysianNavItem({
    required this.icon,
    this.activeIcon,
    this.label,
    this.tooltip,
    this.backgroundColor,
  });
}
