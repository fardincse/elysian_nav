import 'package:flutter/material.dart';

class ElysianNavItem {
  final Widget icon;
  final Widget? activeIcon;
  final String? label;
  final String? tooltip;
  final Color? backgroundColor;

  ElysianNavItem({
    required this.icon,
    this.activeIcon,
    this.label,
    this.tooltip,
    this.backgroundColor,
  });
}