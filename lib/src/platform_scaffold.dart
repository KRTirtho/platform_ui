import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:platform_ui/platform_ui.dart';

class PlatformScaffold extends StatelessWidget {
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final AlignmentDirectional persistentFooterAlignment;
  final Widget? drawer;
  final DrawerCallback? onDrawerChanged;
  final Widget? endDrawer;
  final DrawerCallback? onEndDrawerChanged;
  final Color? drawerScrimColor;
  final PlatformProperty<Color>? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final String? restorationId;

  const PlatformScaffold({
    Key? key,
    this.appBar,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: appBar != null
          ? PreferredSize(
              preferredSize: appBar!.preferredSize,
              child: DefaultTextStyle(
                style: PlatformTextTheme.of(context).body!,
                child: appBar!,
              ),
            )
          : null,
      body: DefaultTextStyle(
        style: PlatformTextTheme.of(context).body!,
        child: body,
      ),
      floatingActionButton: floatingActionButton != null
          ? DefaultTextStyle(
              style: PlatformTextTheme.of(context).body!,
              child: floatingActionButton!,
            )
          : null,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      persistentFooterButtons: persistentFooterButtons,
      persistentFooterAlignment: persistentFooterAlignment,
      drawer: drawer != null
          ? DefaultTextStyle(
              style: PlatformTextTheme.of(context).body!,
              child: drawer!,
            )
          : null,
      onDrawerChanged: onDrawerChanged,
      endDrawer: endDrawer != null
          ? DefaultTextStyle(
              style: PlatformTextTheme.of(context).body!,
              child: endDrawer!,
            )
          : null,
      onEndDrawerChanged: onEndDrawerChanged,
      drawerScrimColor: drawerScrimColor,
      backgroundColor: PlatformTheme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: bottomNavigationBar != null
          ? DefaultTextStyle(
              style: PlatformTextTheme.of(context).body!,
              child: bottomNavigationBar!,
            )
          : null,
      bottomSheet: bottomSheet != null
          ? DefaultTextStyle(
              style: PlatformTextTheme.of(context).body!,
              child: bottomSheet!,
            )
          : null,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      primary: primary,
      drawerDragStartBehavior: drawerDragStartBehavior,
      drawerEdgeDragWidth: drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
      restorationId: restorationId,
    );
  }
}
