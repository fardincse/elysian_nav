import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'elysian_nav_item.dart';

/// A customizable bottom navigation bar with gradients, glow effects,
/// and smooth animations.
///
/// Use [ElysianNavItem] to define items and [celestialIcon] helper
/// to create gradient icons.
class ElysianNav extends StatelessWidget {
  /// The currently selected index in the navigation bar.
  final int currentIndex;

  /// Callback when a navigation item is tapped.
  final ValueChanged<int>? onTap;

  /// The list of navigation items displayed in the bar.
  final List<ElysianNavItem> items;

  /// Custom height of the navigation bar.
  final double? height;

  /// Border radius for rounded corners.
  final double? borderRadius;

  /// Padding around the navigation bar.
  final EdgeInsets? padding;

  /// Background color of the navigation bar.
  final Color? backgroundColor;

  /// Gradient background for the navigation bar.
  final LinearGradient? backgroundGradient;

  /// Custom shadow for the navigation bar.
  final List<BoxShadow>? boxShadow;

  /// Size of the icons (default 24dp).
  final double? iconSize;

  /// Enables glow effect on the active item.
  final bool enableGlowOnActive;

  /// Style for the selected label text.
  final TextStyle? selectedLabelStyle;

  /// Style for the unselected label text.
  final TextStyle? unselectedLabelStyle;

  /// Color for the selected item icon.
  final Color? selectedItemColor;

  /// Color for the unselected item icon.
  final Color? unselectedItemColor;

  /// Glow color for the active item.
  final Color? glowColor;

  /// If true, only the selected label is shown.
  final bool showSelectedLabelOnly;

  /// Creates an [ElysianNav] widget.
  const ElysianNav({
    super.key,
    required this.currentIndex,
    required this.items,
    this.onTap,
    this.height,
    this.borderRadius,
    this.padding,
    this.backgroundColor = Colors.white,
    this.backgroundGradient,
    this.boxShadow,
    this.iconSize,
    this.enableGlowOnActive = false,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.glowColor, 
    this.showSelectedLabelOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    /// Checks if any item has a label to adjust height and styles.
    final bool hasLabels = items.any(
      (item) => item.label != null && item.label!.isNotEmpty,
    );

    return SafeArea(
      top: false,
      bottom: true,
      child: Padding(
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Container(
          height: height ?? (hasLabels ? 72.h : 56.h),
          decoration: BoxDecoration(
            color: backgroundColor,
            gradient: backgroundGradient,
            borderRadius: BorderRadius.circular(
              borderRadius ?? (hasLabels ? 58.r : 44.r),
            ),
            boxShadow:
                boxShadow ??
                [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .08),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                  BoxShadow(
                    color: Colors.white.withValues(alpha: .6),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
          ),
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTap,
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            iconSize: iconSize ?? 24.sp,
            selectedLabelStyle:
                selectedLabelStyle ??
                TextStyle(
                  fontSize: hasLabels ? 14.sp : 0,
                  color: const Color(0xFF3B82F6),
                  fontWeight: FontWeight.w600,
                ),
            unselectedLabelStyle:
                unselectedLabelStyle ??
                TextStyle(
                  fontSize: hasLabels ? 12.sp : 0,
                  color: const Color(0xFF585C63),
                  fontWeight: FontWeight.w600,
                ),
            showSelectedLabels: true,
            showUnselectedLabels: showSelectedLabelOnly ? false : true,
            selectedItemColor: selectedItemColor ?? const Color(0xFF3B82F6),
            unselectedItemColor: unselectedItemColor ?? const Color(0xFF98A2B3),
            items: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isActive = currentIndex == index;

              return BottomNavigationBarItem(
                icon: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: isActive ? 1.0 : 0.7,
                  child: Center(child: item.icon),
                ),
                activeIcon: Center(
                  child: enableGlowOnActive
                      ? Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color:
                                    glowColor ??
                                    const Color(0xFF3B82F6).withValues(alpha: .5),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: item.activeIcon ?? item.icon,
                        )
                      : (item.activeIcon ?? item.icon),
                ),
                label: item.label,
                tooltip: item.tooltip,
                backgroundColor: item.backgroundColor,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  /// Creates a gradient icon using the provided [colors].
  ///
  /// Example:
  /// ```dart
  /// ElysianNav.celestialIcon(
  ///   icon: Icon(Icons.home),
  ///   colors: [Colors.blue, Colors.purple],
  /// )
  /// ```
  static Widget celestialIcon({
    required Widget icon,
    required List<Color> colors,
    Alignment begin = Alignment.topLeft,
    Alignment end = Alignment.bottomRight,
  }) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: colors,
        begin: begin,
        end: end,
      ).createShader(bounds),
      blendMode: BlendMode.srcIn,
      child: icon,
    );
  }
}
