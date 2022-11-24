import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:fluent_ui/fluent_ui.dart' as FluentUI;
import 'package:collection/collection.dart';

class PlatformTabBar extends StatefulWidget {
  final List<PlatformTab> tabs;
  final PlatformProperty<bool> isNavigational;
  final bool androidIsScrollable;
  final int selectedIndex;
  final ValueChanged<int> onSelectedIndexChanged;
  final Color? backgroundColor;
  const PlatformTabBar({
    required this.tabs,
    required this.selectedIndex,
    required this.onSelectedIndexChanged,
    this.backgroundColor,
    this.isNavigational = const PlatformProperty(
      android: true,
      ios: true,
      macos: true,
      windows: true,
      linux: true,
    ),
    this.androidIsScrollable = true,
    Key? key,
  }) : super(key: key);

  @override
  State<PlatformTabBar> createState() => _PlatformTabBarState();
}

class _PlatformTabBarState extends State<PlatformTabBar>
    with PlatformMixin<Widget>, SingleTickerProviderStateMixin {
  late TabController _tabController;
  late MacosTabController _macosTabController;
  @override
  void initState() {
    super.initState();
    _macosTabController = MacosTabController(
      initialIndex: widget.selectedIndex,
      length: widget.tabs.length,
    );
    _tabController = TabController(
      initialIndex: widget.selectedIndex,
      length: widget.tabs.length,
      vsync: this,
    );

    _tabController.addListener(() {
      if (_tabController.index != widget.selectedIndex) {
        widget.onSelectedIndexChanged(_tabController.index);
      }
    });
    _macosTabController.addListener(() {
      if (_macosTabController.index != widget.selectedIndex) {
        widget.onSelectedIndexChanged(_macosTabController.index);
      }
    });
  }

  @override
  void didUpdateWidget(covariant PlatformTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _tabController.index = widget.selectedIndex;
      _macosTabController.index = widget.selectedIndex;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _macosTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getPlatformType(context);
  }

  @override
  Widget android(BuildContext context) {
    if (widget.isNavigational.android) {
      return NavigationBar(
        backgroundColor: widget.backgroundColor,
        destinations: widget.tabs
            .mapIndexed(
              (i, e) => e.androidNavigation(context, widget.selectedIndex == i),
            )
            .toList(),
        selectedIndex: widget.selectedIndex,
        onDestinationSelected: widget.onSelectedIndexChanged,
      );
    }

    return TabBar(
      controller: _tabController,
      tabs: widget.tabs
          .mapIndexed(
              (i, tab) => tab.android(context, widget.selectedIndex == i))
          .toList(),
      isScrollable: widget.androidIsScrollable,
    );
  }

  @override
  Widget ios(BuildContext context) {
    if (widget.isNavigational.ios) {
      return MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: CupertinoTabBar(
          backgroundColor: widget.backgroundColor,
          activeColor: widget.tabs.toList()[widget.selectedIndex].activeColor,
          inactiveColor: widget.tabs.toList()[widget.selectedIndex].color ??
              CupertinoColors.inactiveGray,
          items: widget.tabs
              .mapIndexed(
                (i, e) => e.iosNavigation(context, widget.selectedIndex == i),
              )
              .toList(),
        ),
      );
    }
    return CupertinoSlidingSegmentedControl(
      backgroundColor:
          widget.backgroundColor ?? CupertinoColors.tertiarySystemFill,
      children: Map.fromEntries(
        widget.tabs.mapIndexed(
          (i, tab) => MapEntry(
            i,
            tab.ios(context, widget.selectedIndex == i),
          ),
        ),
      ),
      onValueChanged: (v) {
        if (v != null) {
          widget.onSelectedIndexChanged(v);
        }
      },
      groupValue: widget.selectedIndex,
    );
  }

  @override
  Widget linux(BuildContext context) {
    return AdwViewSwitcher(
      tabs: widget.tabs.mapIndexed((i, tab) => tab.linux(context)).toList(),
      currentIndex: widget.selectedIndex,
      onViewChanged: widget.onSelectedIndexChanged,
      policy: widget.isNavigational.linux
          ? ViewSwitcherPolicy.wide
          : ViewSwitcherPolicy.narrow,
    );
  }

  @override
  Widget macos(BuildContext context) {
    return DefaultTextStyle(
      style: PlatformTextTheme.of(context).body!,
      child: MacosSegmentedControl(
        controller: _macosTabController,
        tabs: widget.tabs
            .mapIndexed(
                (i, tab) => tab.macos(context, widget.selectedIndex == i))
            .toList(),
      ),
    );
  }

  @override
  Widget windows(BuildContext context) {
    if (widget.isNavigational.windows) {
      return SizedBox(
        height: 40,
        child: FluentUI.NavigationView(
          pane: FluentUI.NavigationPane(
            items: widget.tabs
                .mapIndexed((i, e) =>
                    e.windowsNavigation(context, const SizedBox.shrink()))
                .toList(),
            displayMode: FluentUI.PaneDisplayMode.top,
            selected: widget.selectedIndex,
            onChanged: widget.onSelectedIndexChanged,
          ),
        ),
      );
    }
    return SizedBox(
      height: 40,
      child: FluentUI.TabView(
        currentIndex: widget.selectedIndex,
        onNewPressed: null,
        onChanged: widget.onSelectedIndexChanged,
        closeButtonVisibility: FluentUI.CloseButtonVisibilityMode.never,
        tabs: widget.tabs
            .mapIndexed(
              (i, e) => e.windows(
                context,
                const SizedBox.shrink(),
                widget.selectedIndex == i,
              ),
            )
            .toList(),
      ),
    );
  }
}
