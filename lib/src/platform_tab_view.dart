import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:libadwaita_core/libadwaita_core.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:fluent_ui/fluent_ui.dart' as FluentUI;
import 'package:collection/collection.dart';
import 'package:platform_ui/src/tools/utils.dart';

class PlatformTab {
  final String label;
  final TextStyle? labelStyle;
  final Widget icon;
  final bool active;
  final Color? activeColor;
  final Color? color;

  PlatformTab({
    required this.label,
    required this.icon,
    this.labelStyle,
    this.activeColor,
    this.color,
    this.active = false,
  });

  Widget android(
    BuildContext context,
    bool active,
  ) {
    final theColor = active
        ? activeColor ??
            Theme.of(context).tabBarTheme.labelColor ??
            Theme.of(context).colorScheme.primary
        : color ?? Theme.of(context).tabBarTheme.unselectedLabelColor;

    final tabTheme = TabBarTheme.of(context);

    return Tab(
      height: 45,
      icon: IconTheme(
        data: IconThemeData(color: theColor),
        child: icon,
      ),
      child: Text(
        label,
        style: (labelStyle ??
                (active
                    ? tabTheme.labelStyle
                    : tabTheme.unselectedLabelStyle) ??
                const TextStyle())
            .copyWith(color: theColor),
      ),
    );
  }

  NavigationDestination androidNavigation(
    BuildContext context,
    bool active,
  ) {
    final theColor =
        color ?? Theme.of(context).tabBarTheme.unselectedLabelColor;
    final theActiveColor = activeColor ??
        Theme.of(context).tabBarTheme.labelColor ??
        Theme.of(context).colorScheme.primary;

    return NavigationDestination(
      icon: IconTheme(
        data: IconThemeData(color: theColor),
        child: icon,
      ),
      selectedIcon: IconTheme(
        data: IconThemeData(color: theActiveColor),
        child: icon,
      ),
      label: label,
    );
  }

  BottomNavigationBarItem iosNavigation(
    BuildContext context,
    bool active,
  ) {
    final theColor =
        color ?? Theme.of(context).tabBarTheme.unselectedLabelColor;
    final theActiveColor = activeColor ??
        Theme.of(context).tabBarTheme.labelColor ??
        Theme.of(context).colorScheme.primary;
    return BottomNavigationBarItem(
      icon: IconTheme(
        data: IconThemeData(color: theColor),
        child: icon,
      ),
      activeIcon: IconTheme(
        data: IconThemeData(color: theActiveColor),
        child: icon,
      ),
      label: label,
    );
  }

  Widget ios(
    BuildContext context,
    bool active,
  ) {
    final theColor = color ?? PlatformTextTheme.of(context).caption?.color;
    final theActiveColor = activeColor ??
        Theme.of(context).tabBarTheme.labelColor ??
        Theme.of(context).colorScheme.primary;
    return Text(
      label,
      style: PlatformTextTheme.of(context).label?.copyWith(
          color: active ? theActiveColor : theColor,
          fontSize: (PlatformTextTheme.of(context).label?.fontSize ?? 16) - 2),
      overflow: TextOverflow.ellipsis,
    );
  }

  MacosTab macos(
    BuildContext context,
    bool active,
  ) {
    return MacosTab(label: label, active: active);
  }

  FluentUI.Tab windows(
    BuildContext context,
    Widget body,
    bool active,
  ) {
    return FluentUI.Tab(
      text: Text(label, style: labelStyle),
      icon: icon,
      onClosed: null,
      body: body,
    );
  }

  FluentUI.NavigationPaneItem windowsNavigation(
    BuildContext context,
    Widget body,
  ) {
    return FluentUI.PaneItem(
      title: Text(label, style: labelStyle),
      icon: icon,
      body: body,
      selectedTileColor:
          activeColor != null ? FluentUI.ButtonState.all(activeColor) : null,
      tileColor: color != null ? FluentUI.ButtonState.all(color) : null,
    );
  }

  ViewSwitcherData linux(BuildContext context) {
    return ViewSwitcherData(
      title: label,
      icon: icon is Icon ? (icon as Icon).icon : null,
    );
  }
}

class PlatformTabController extends ChangeNotifier {
  late TabController android;
  late CupertinoTabController ios;
  late MacosTabController macos;
  late TabController linux;

  int _index;
  int length;

  PlatformTabController({
    int initialIndex = 0,
    required this.length,
    required TickerProvider vsync,
  }) : _index = initialIndex {
    android = TabController(
      initialIndex: initialIndex,
      length: length,
      vsync: vsync,
    );
    linux = android;
    ios = CupertinoTabController(initialIndex: initialIndex);
    macos = MacosTabController(initialIndex: initialIndex, length: length);

    android.addListener(() {
      _index = android.index;
      notifyListeners();
    });
    ios.addListener(() {
      _index = ios.index;
      notifyListeners();
    });
    macos.addListener(() {
      _index = macos.index;
      notifyListeners();
    });
  }

  int get index => _index;
  set index(int value) {
    android.index = value;
    ios.index = value;
    macos.index = value;
  }

  @override
  void dispose() {
    android.dispose();
    ios.dispose();
    macos.dispose();
    super.dispose();
  }
}

enum PlatformTabbarPlacement {
  top,
  bottom,
}

class PlatformTabView extends StatefulWidget {
  final PlatformTabController? controller;
  final Map<PlatformTab, Widget> body;
  final PlatformProperty<PlatformTabbarPlacement>? placement;
  final bool isNavigational;
  final bool androidIsScrollable;

  const PlatformTabView({
    required this.body,
    this.controller,
    this.androidIsScrollable = false,
    this.placement = const PlatformProperty(
      android: PlatformTabbarPlacement.bottom,
      ios: PlatformTabbarPlacement.bottom,
      macos: PlatformTabbarPlacement.top,
      windows: PlatformTabbarPlacement.top,
      linux: PlatformTabbarPlacement.top,
    ),
    this.isNavigational = true,
    Key? key,
  }) : super(key: key);

  @override
  State<PlatformTabView> createState() => _PlatformTabViewState();
}

class _PlatformTabViewState extends State<PlatformTabView>
    with PlatformMixin<Widget>, SingleTickerProviderStateMixin {
  int currentIndex = 0;
  late PlatformTabController controller;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      controller = PlatformTabController(
        initialIndex: currentIndex,
        length: widget.body.length,
        vsync: this,
      );
    } else {
      controller = widget.controller!;
    }
    controller.addListener(() {
      setState(() {
        currentIndex = controller.index;
      });
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getPlatformType(context);
  }

  @override
  Widget android(BuildContext context) {
    final tabbar = TabBar(
      controller: controller.android,
      isScrollable: widget.androidIsScrollable,
      tabs: widget.body.keys
          .mapIndexed((i, e) => e.android(context, currentIndex == i))
          .toList(),
    );
    return Scaffold(
      appBar: widget.placement?.android != PlatformTabbarPlacement.bottom
          ? tabbar
          : null,
      bottomNavigationBar:
          widget.placement?.android == PlatformTabbarPlacement.bottom
              ? widget.isNavigational
                  ? NavigationBar(
                      destinations: widget.body.keys
                          .map((e) => e.androidNavigation(context,
                              e == widget.body.keys.elementAt(currentIndex)))
                          .toList(),
                      selectedIndex: currentIndex,
                      onDestinationSelected: (index) {
                        controller.index = index;
                      },
                    )
                  : tabbar
              : null,
      body: TabBarView(
        controller: controller.android,
        children: widget.body.values.toList(),
      ),
    );
  }

  @override
  Widget ios(BuildContext context) {
    if (widget.isNavigational &&
        widget.placement?.ios == PlatformTabbarPlacement.top) {
      final widgets = widget.body.values.toList();
      final items = widget.body.keys
          .mapIndexed((i, e) => e.ios(context, currentIndex == i))
          .toList();
      return PlatformScaffold(
        body: Column(
          children: [
            CupertinoSlidingSegmentedControl(
              children: items.asMap(),
              onValueChanged: (value) {
                if (value != null) controller.index = value;
              },
              groupValue: currentIndex,
            ),
            Expanded(child: widgets[currentIndex]),
          ],
        ),
      );
    }
    final widgets = widget.body.values.toList();
    final items = widget.body.keys
        .mapIndexed((i, e) => e.iosNavigation(context, currentIndex == i))
        .toList();
    return CupertinoTabScaffold(
      controller: controller.ios,
      tabBar: CupertinoTabBar(
        activeColor: widget.body.keys.toList()[currentIndex].activeColor,
        inactiveColor: widget.body.keys.toList()[currentIndex].color ??
            CupertinoColors.inactiveGray,
        items: items,
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) => widgets[index],
        );
      },
    );
  }

  @override
  Widget linux(BuildContext context) {
    if (kIsWeb) {
      return FluentUI.FluentTheme(
        data: Utils.brightnessSpecific(
          context,
          light: FluentUI.FluentThemeData.light(),
          dark: FluentUI.FluentThemeData.dark(),
        ),
        child: windows(context),
      );
    }
    final tabbar = AdwViewSwitcher(
      policy: widget.placement?.linux == PlatformTabbarPlacement.bottom
          ? ViewSwitcherPolicy.narrow
          : ViewSwitcherPolicy.wide,
      currentIndex: currentIndex,
      onViewChanged: (value) {
        controller.index = value;
      },
      tabs: widget.body.keys.mapIndexed((i, e) => e.linux(context)).toList(),
    );
    return Scaffold(
      appBar: widget.placement?.linux == PlatformTabbarPlacement.top
          ? PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: AdwHeaderBar(
                actions: AdwActions(),
                title: Center(child: tabbar),
              ),
            )
          : null,
      body: AdwViewStack(
        index: currentIndex,
        animationDuration: const Duration(milliseconds: 100),
        children: widget.body.values.toList(),
      ),
      bottomNavigationBar:
          widget.placement?.linux == PlatformTabbarPlacement.bottom
              ? SizedBox.fromSize(
                  size: const Size.fromHeight(kToolbarHeight - 9),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Theme.of(context).dividerColor,
                          width: 1,
                        ),
                      ),
                      color: Theme.of(context).appBarTheme.backgroundColor,
                    ),
                    child: Center(child: tabbar),
                  ),
                )
              : null,
    );
  }

  @override
  Widget macos(BuildContext context) {
    return DefaultTextStyle(
      style: PlatformTextTheme.of(context).body!,
      child: MacosTabView(
        controller: controller.macos,
        tabs: widget.body.keys
            .mapIndexed((i, e) => e.macos(context, currentIndex == i))
            .toList(),
        position: widget.placement?.macos == PlatformTabbarPlacement.bottom
            ? MacosTabPosition.bottom
            : MacosTabPosition.top,
        children: widget.body.values.toList(),
      ),
    );
  }

  @override
  Widget windows(BuildContext context) {
    if (widget.isNavigational) {
      return FluentUI.NavigationView(
        pane: FluentUI.NavigationPane(
          items: widget.body.keys
              .mapIndexed(
                  (i, e) => e.windowsNavigation(context, widget.body[e]!))
              .toList(),
          displayMode: FluentUI.PaneDisplayMode.top,
          selected: currentIndex,
          onChanged: (value) {
            controller.index = value;
          },
        ),
      );
    }

    return FluentUI.TabView(
      currentIndex: currentIndex,
      onNewPressed: null,
      onChanged: (value) {
        controller.index = value;
      },
      closeButtonVisibility: FluentUI.CloseButtonVisibilityMode.never,
      tabs: widget.body.keys
          .mapIndexed(
              (i, e) => e.windows(context, widget.body[e]!, currentIndex == i))
          .toList(),
    );
  }
}
