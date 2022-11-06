import 'package:fluent_ui/fluent_ui.dart' hide Colors;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:platform_ui/platform_ui.dart';
import 'package:collection/collection.dart';
import 'package:libadwaita_core/libadwaita_core.dart';

class PlatformSidebarItem {
  final Widget title;
  final Widget icon;
  final bool selected;
  final VoidCallback? onTap;
  PlatformSidebarItem({
    required this.title,
    required this.icon,
    this.selected = false,
    this.onTap,
  });

  NavigationRailDestination android() {
    return NavigationRailDestination(
      icon: icon,
      label: title,
    );
  }

  AdwSidebarItem linux() {
    return AdwSidebarItem(
      labelWidget: title,
      leading: icon,
    );
  }

  SidebarItem macos(BuildContext context, bool isActive) {
    return SidebarItem(
      label: title,
      leading: IconTheme(
        data: IconTheme.of(context).copyWith(
          color: isActive
              ? MacosTheme.of(context).canvasColor
              : MacosTheme.of(context).primaryColor,
          size: 16,
        ),
        child: icon,
      ),
    );
  }

  NavigationPaneItem windows(Widget body) {
    return PaneItem(
      icon: icon,
      title: title,
      body: body,
    );
  }
}

class PlatformSidebar extends StatefulWidget {
  final Widget? header;
  final Widget? footer;
  final List<NavigationPaneItem> windowsFooterItems;
  final Map<PlatformSidebarItem, Widget> body;
  final int? initialIndex;
  final int? currentIndex;
  final bool expanded;
  final double? minExpandedWidth;
  final double? minWidth;
  final void Function(int)? onIndexChanged;

  PlatformSidebar({
    Key? key,
    required this.body,
    this.initialIndex,
    this.onIndexChanged,
    this.currentIndex,
    this.minExpandedWidth,
    this.minWidth,
    this.header,
    this.footer,
    this.windowsFooterItems = const [],
    this.expanded = true,
  })  : assert(
          (initialIndex ?? 0) <= body.length,
          "`initialIndex` is out of range: 0..${body.length}",
        ),
        assert(
          footer != null && windowsFooterItems.isNotEmpty ||
              footer == null && windowsFooterItems.isEmpty,
          "`footer` and `windowsFooterItems` must be both null or not null",
        ),
        super(key: key);

  @override
  State<PlatformSidebar> createState() => _PlatformSidebarState();
}

class _PlatformSidebarState extends State<PlatformSidebar>
    with PlatformMixin<Widget> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex ?? currentIndex;
  }

  @override
  void didUpdateWidget(covariant PlatformSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      currentIndex = widget.currentIndex ?? currentIndex;
    }
  }

  onIndexChanged(value) => setState(() {
        currentIndex = value;
        widget.onIndexChanged?.call(value);
      });

  @override
  Widget build(BuildContext context) {
    return getPlatformType(context);
  }

  @override
  Widget android(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          leading: widget.header,
          trailing: widget.footer,
          selectedIndex: currentIndex,
          onDestinationSelected: onIndexChanged,
          destinations: widget.body.keys.map((e) => e.android()).toList(),
          minExtendedWidth: widget.minExpandedWidth,
          minWidth: widget.minWidth,
          extended: true,
        ),
        Expanded(
          child: widget.body.values.elementAt(currentIndex),
        ),
      ],
    );
  }

  @override
  Widget ios(BuildContext context) {
    return Row(
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            useMaterial3: false,
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
          ),
          child: SafeArea(
            child: Container(
              constraints: BoxConstraints(
                minWidth: widget.expanded
                    ? (widget.minExpandedWidth ?? 256) + 1
                    : (widget.minWidth ?? 72) + 1,
              ),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: CupertinoColors.separator.resolveFrom(context),
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              child: NavigationRail(
                leading: widget.header,
                trailing: widget.footer,
                minExtendedWidth: widget.minExpandedWidth,
                minWidth: widget.minWidth,
                extended: widget.expanded,
                unselectedIconTheme: IconThemeData(
                  color: CupertinoColors.label.resolveFrom(context),
                  opacity: 1,
                ),
                selectedIconTheme: IconThemeData(
                  color: CupertinoColors.activeBlue.resolveFrom(context),
                ),
                selectedLabelTextStyle: TextStyle(
                  color: CupertinoColors.activeBlue.resolveFrom(context),
                ),
                unselectedLabelTextStyle: TextStyle(
                  color: CupertinoColors.label.resolveFrom(context),
                ),
                indicatorColor: CupertinoColors.activeBlue.resolveFrom(context),
                selectedIndex: currentIndex,
                elevation: 0.1,
                backgroundColor: CupertinoTheme.of(context).barBackgroundColor,
                onDestinationSelected: onIndexChanged,
                destinations: widget.body.keys.map((e) => e.android()).toList(),
              ),
            ),
          ),
        ),
        Expanded(
          child: widget.body.values.elementAt(currentIndex),
        ),
      ],
    );
  }

  @override
  Widget linux(BuildContext context) {
    return Row(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: widget.minExpandedWidth ?? 270,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.header != null)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                  child: widget.header!,
                ),
              Expanded(
                child: AdwSidebar(
                  children: widget.body.keys.map((e) => e.linux()).toList(),
                  currentIndex: currentIndex,
                  onSelected: onIndexChanged,
                  width: widget.minExpandedWidth ?? 270,
                  isDrawer: false,
                ),
              ),
              if (widget.footer != null)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
                  child: widget.footer!,
                ),
            ],
          ),
        ),
        Expanded(
          child: AdwViewStack(
            animationDuration: const Duration(milliseconds: 100),
            index: currentIndex,
            children: widget.body.values.toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget macos(BuildContext context) {
    return MacosWindow(
      sidebar: Sidebar(
        top: widget.header,
        topOffset: 1,
        bottom: widget.footer,
        minWidth: widget.minExpandedWidth ?? 256,
        builder: (context, scrollController) {
          return SidebarItems(
            itemSize: SidebarItemSize.large,
            currentIndex: currentIndex,
            onChanged: onIndexChanged,
            items: widget.body.keys
                .mapIndexed((i, e) => e.macos(context, i == currentIndex))
                .toList(),
          );
        },
      ),
      child: widget.body.values.elementAt(currentIndex),
    );
  }

  @override
  Widget windows(BuildContext context) {
    return NavigationView(
      pane: NavigationPane(
        header: widget.header,
        size: NavigationPaneSize(
          openMaxWidth: 256,
          openMinWidth: widget.minExpandedWidth,
          compactWidth: widget.minWidth,
        ),
        selected: currentIndex,
        displayMode:
            widget.expanded ? PaneDisplayMode.open : PaneDisplayMode.compact,
        menuButton: Container(),
        footerItems: widget.windowsFooterItems,
        items: widget.body.keys.map((e) => e.windows(widget.body[e]!)).toList(),
        onChanged: onIndexChanged,
      ),
    );
  }
}
