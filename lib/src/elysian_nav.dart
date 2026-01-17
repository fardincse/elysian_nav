import 'package:flutter/material.dart';
import 'elysian_nav_item.dart';

class ElysianNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final List<ElysianNavItem> items;

  final double height;
  final double? borderRadius;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final LinearGradient? backgroundGradient;
  final List<BoxShadow>? boxShadow;
  final double iconSize;
  final bool enableGlowOnActive;

  const ElysianNav({
    super.key,
    required this.currentIndex,
    required this.items,
    this.onTap,
    this.height = 78,
    this.borderRadius = 38,
    this.padding,
    this.backgroundColor = Colors.white,
    this.backgroundGradient,
    this.boxShadow,
    this.iconSize = 38,
    this.enableGlowOnActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            gradient: backgroundGradient,
            borderRadius: BorderRadius.circular(borderRadius ?? 38),
            boxShadow: boxShadow ??
                [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.6),
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
            iconSize: iconSize,
            selectedLabelStyle: const TextStyle(
              fontSize: 12,
              color: Color(0xFF3B82F6),
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
            fontSize: 12,
            color: Color(0xFF3B82F6),
          fontWeight: FontWeight.w600,
        ),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: Color(0xFF3B82F6),
            unselectedItemColor: Color(0xFF98A2B3),
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
                          color: Color(0xFF3B82F6).withOpacity(0.5),
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