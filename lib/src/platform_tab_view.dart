import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:fluent_ui/fluent_ui.dart' as FluentUI;
import 'package:collection/collection.dart';

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

    return Tab(
      icon: IconTheme(
        data: IconThemeData(color: theColor),
        child: icon,
      ),
      child: Text(
        label,
        style: (labelStyle ??
                Theme.of(context).textTheme.labelMedium ??
                const TextStyle())
            .copyWith(color: theColor),
      ),
    );
  }

  BottomNavigationBarItem ios(
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

  const PlatformTabView({
    required this.body,
    this.controller,
    this.placement,
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
    return Scaffold(
      appBar: widget.placement?.android != PlatformTabbarPlacement.bottom
          ? TabBar(
              controller: controller.android,
              tabs: widget.body.keys
                  .mapIndexed((i, e) => e.android(context, currentIndex == i))
                  .toList(),
            )
          : null,
      bottomNavigationBar: widget.placement?.android ==
              PlatformTabbarPlacement.bottom
          ? TabBar(
              controller: controller.android,
              tabs: widget.body.keys
                  .mapIndexed((i, e) => e.android(context, currentIndex == i))
                  .toList(),
            )
          : null,
      body: TabBarView(
        controller: controller.android,
        children: widget.body.values.toList(),
      ),
    );
  }

  @override
  Widget ios(BuildContext context) {
    final widgets = widget.body.values.toList();
    final items = widget.body.keys
        .mapIndexed((i, e) => e.ios(context, currentIndex == i))
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
    return android(context);
  }

  @override
  Widget macos(BuildContext context) {
    return MacosTabView(
      controller: controller.macos,
      tabs: widget.body.keys
          .mapIndexed((i, e) => e.macos(context, currentIndex == i))
          .toList(),
      position: widget.placement?.macos == PlatformTabbarPlacement.bottom
          ? MacosTabPosition.bottom
          : MacosTabPosition.top,
      children: widget.body.values.toList(),
    );
  }

  @override
  Widget windows(BuildContext context) {
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
