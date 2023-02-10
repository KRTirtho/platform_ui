import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:platform_ui/platform_ui.dart';

class PlatformBottomNavigationBarItem {
  final IconData icon;
  final String label;
  final Color? backgroundColor;

  const PlatformBottomNavigationBarItem({
    required this.icon,
    required this.label,
    this.backgroundColor,
  });

  Widget android(
    BuildContext context, {
    Color? activeColor,
    Color? inactiveColor,
  }) {
    return NavigationDestination(
      icon: Icon(icon, color: inactiveColor),
      selectedIcon: Icon(icon, color: activeColor),
      label: label,
    );
  }

  BottomNavigationBarItem ios(BuildContext context) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
      backgroundColor: backgroundColor,
    );
  }

  ViewSwitcherData linux(BuildContext context) {
    return ViewSwitcherData(
      icon: icon,
      title: label,
    );
  }

  BottomNavigationBarItem macos(BuildContext context) {
    return ios(context);
  }

  ViewSwitcherData windows(BuildContext context) {
    return linux(context);
  }
}

class PlatformBottomNavigationBar extends StatelessWidget
    with PlatformMixin<Widget> {
  final List<PlatformBottomNavigationBarItem> items;
  final int selectedIndex;
  final ValueChanged<int>? onSelectedIndexChanged;
  final Color? backgroundColor;

  /// Doesn't apply in linux and windows
  final Color? activeColor;

  /// Doesn't apply in linux and windows
  final Color? inactiveColor;

  final double? height;

  const PlatformBottomNavigationBar({
    required this.items,
    this.selectedIndex = 0,
    this.onSelectedIndexChanged,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor,
    this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: getPlatformType(context),
    );
  }

  @override
  Widget android(BuildContext context) {
    return NavigationBar(
      destinations: items
          .map((e) => e.android(
                context,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
              ))
          .toList(),
      selectedIndex: selectedIndex,
      onDestinationSelected: onSelectedIndexChanged,
      backgroundColor: backgroundColor,
      height: height,
    );
  }

  @override
  Widget linux(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ColoredBox(
        color: backgroundColor ??
            Theme.of(context).bottomAppBarTheme.color ??
            Theme.of(context).canvasColor,
        child: Center(
          child: AdwViewSwitcher(
            currentIndex: selectedIndex,
            onViewChanged: (i) => onSelectedIndexChanged?.call(i),
            tabs: items.map((e) => e.linux(context)).toList(),
            policy: ViewSwitcherPolicy.narrow,
          ),
        ),
      ),
    );
  }

  @override
  Widget ios(BuildContext context) {
    return CupertinoTabBar(
      items: items.map((e) => e.ios(context)).toList(),
      currentIndex: selectedIndex,
      onTap: onSelectedIndexChanged,
      activeColor: activeColor,
      inactiveColor: inactiveColor ?? CupertinoColors.inactiveGray,
      backgroundColor: backgroundColor,
      height: height ?? 50,
    );
  }

  @override
  Widget macos(BuildContext context) {
    return CupertinoTabBar(
      items: items.map((e) => e.ios(context)).toList(),
      currentIndex: selectedIndex,
      onTap: onSelectedIndexChanged,
      inactiveColor: inactiveColor ?? CupertinoColors.inactiveGray,
      backgroundColor: backgroundColor ??
          MacosTheme.of(context).canvasColor.withOpacity(0.9),
      activeColor: activeColor,
      height: height ?? 50,
    );
  }

  @override
  Widget windows(BuildContext context) {
    return linux(context);
  }
}
